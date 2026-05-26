import 'package:meta/meta.dart';

import 'batch.dart';
import 'equality.dart';
import 'globals.dart';
import 'node.dart';
import 'options.dart';
import 'readonly.dart';

/// Represents a mutable reactive state container that sits at the foundation of the reactivity system.
///
/// Signals hold a single, mutable [value] that can be read or modified. When a signal's value
/// is updated, any active computations (like [Computed]) or effects (like [effect]) that
/// read the signal's value inside their execution context are automatically notified and scheduled to re-run.
///
/// Under the hood, this establishes a reactive dependency graph where reading a signal registers the reader as a
/// "target", and updating a signal triggers direct, glitch-free propagation to all registered targets.
///
/// <Info>
///   Accessing `.value` inside a reactive context (like `effect` or `computed`) registers a dependency. Reading a value
///   outside a reactive context behaves like a standard getter without creating a subscription.
/// </Info>
///
/// ### Example Usage
///
/// #### 1. Basic Reactive Flow
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// void main() {
///   final count = Signal(0);
///
///   // The effect automatically subscribes to count.value
///   effect(() {
///     print('Count is: ${count.value}');
///   });
///
///   count.value = 5; // Triggers print: Count is: 5
/// }
/// ```
///
/// #### 2. Controlling Subscriptions via `.peek()`
/// If you need to read a signal's value without subscribing to updates, use the `.peek()` method:
/// ```dart
/// final count = Signal(0);
/// final threshold = Signal(10);
///
/// effect(() {
///   // Subscribes to count, but NOT to threshold
///   if (count.value >= threshold.peek()) {
///     print('Threshold reached!');
///   }
/// });
/// ```
class Signal<T> with ReadonlySignal<T> {
  @override
  final int globalId;

  @override
  final String? name;

  @override
  final void Function()? watched;

  @override
  final void Function()? unwatched;

  /// Signal equality check
  final SignalEquality<T> _equalityCheck;

  /// Get the active equality check
  SignalEquality<T> get equalityCheck => _equalityCheck;

  /// Check if the value is set and not a lazy signal
  bool get isInitialized => _isInitialized;
  bool _isInitialized;

  /// @internal
  /// The global batch snapshot version tracked during mutation cycles.
  @internal
  int batchSnapshotVersion = 0;

  /// @internal
  /// Set if the signal is initialized.
  @internal
  set isInitialized(bool val) {
    _isInitialized = val;
  }

  late T _internalValue;

  @override
  T get internalValue => _internalValue;

  /// @internal
  /// Set the internal raw value of the signal.
  @internal
  set internalValue(T value) {
    _internalValue = value;
    _isInitialized = true;
  }

  /// Creates a new [Signal] instance with the given initial value.
  ///
  /// You can optionally provide:
  /// - A [name] for debugging/observer tracing.
  /// - [watched]/[unwatched] hooks triggered when the signal gains its first subscriber or loses its last subscriber.
  /// - [equality] checking callback to customize how value modifications are compared.
  ///
  /// ```dart
  /// final count = Signal(0, name: 'counter_signal');
  /// ```
  Signal(
    this._internalValue, {
    String? name,
    void Function()? watched,
    void Function()? unwatched,
    ReadonlySignalOptions<T>? options,
    SignalEquality<T>? equality,
  })  : name = options?.name ?? name,
        watched = options?.watched ?? watched,
        unwatched = options?.unwatched ?? unwatched,
        _equalityCheck =
            (options is SignalOptions<T> ? options.equalityCheck : null) ??
                equality ??
                const SignalStandardEquality<Never>(),
        version = 0,
        globalId = ++lastGlobalId,
        _isInitialized = true;

  /// Creates a new lazy [Signal] instance that is computed on-demand upon first read.
  ///
  /// <Warning>
  ///   Reading a lazy signal before a value has been explicitly set or assigned via `.value = ...` or `.set(...)`
  ///   will throw a runtime initialization exception.
  /// </Warning>
  ///
  /// ```dart
  /// final lazyUser = Signal<User>.lazy(name: 'lazy_user');
  ///
  /// // Throws error:
  /// // print(lazyUser.value);
  ///
  /// lazyUser.value = User(id: 1, name: 'John'); // Initialized successfully
  /// print(lazyUser.value); // Safe to read now
  /// ```
  Signal.lazy({
    String? name,
    void Function()? watched,
    void Function()? unwatched,
    ReadonlySignalOptions<T>? options,
    SignalEquality<T>? equality,
  })  : name = options?.name ?? name,
        watched = options?.watched ?? watched,
        unwatched = options?.unwatched ?? unwatched,
        _equalityCheck =
            (options is SignalOptions<T> ? options.equalityCheck : null) ??
                equality ??
                const SignalStandardEquality<Never>(),
        version = 0,
        globalId = ++lastGlobalId,
        _isInitialized = false;

  /// Version numbers should always be >= 0, because the special value -1 is used
  /// by Nodes to signify potentially unused but recyclable nodes.
  @override
  int version;

  @override
  bool internalRefresh() {
    return true;
  }

  @override
  void subscribeToNode(Node node) {
    internalSubscribe(node);
  }

  @override
  void unsubscribeFromNode(Node node) {
    signalUnsubscribe(node);
  }

  @override
  void Function() subscribe(void Function(T value) fn) {
    return signalSubscribe(fn);
  }

  @override
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
  /// Gets the current value of the signal.
  ///
  /// If read inside an active reactive context (e.g., an [effect] or [computed] signal),
  /// the calling context automatically subscribes to updates of this signal.
  @override
  T get value {
    final node = addDependency();
    if (node != null) {
      node.version = version;
    }
    return internalValue;
  }

  /// Sets the current value of the signal.
  ///
  /// If the new value is not equal to the existing value (based on [equalityCheck]), the
  /// signal's version is incremented and all active downstream subscribers (computeds/effects)
  /// are synchronously notified to re-evaluate.
  set value(T val) => set(val);

  /// Updates the signal's value by method call.
  ///
  /// Under normal conditions, this only notifies subscribers if the new value is different
  /// from the current value.
  ///
  /// Set [force] to `true` to bypass standard equality checks and notify downstream subscribers
  /// unconditionally. This is useful when working with mutable collections or class instances where
  /// properties change in-place but the object reference remains identical.
  ///
  /// ```dart
  /// final numbers = Signal([1, 2, 3]);
  /// numbers.value.add(4); // In-place modification
  /// numbers.set(numbers.value, force: true); // Force notify downstream subscribers
  /// ```
  bool set(
    T val, {
    /// Skip equality check and update the value
    bool force = false,
  }) {
    if (force || !isInitialized || !equalityCheck.equals(val, internalValue)) {
      internalSetValue(val);
      return true;
    }
    return false;
  }

  /// @internal
  /// Sets the internal value of the signal during batch updates.
  @internal
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
  void internalSetValue(T val) {
    if (batchIteration > 100) {
      throwCycleDetected();
    }

    recordBatchSnapshot(this);
    internalValue = val;
    version++;
    globalVersion++;

    startBatch();
    try {
      for (var node = targets; node != null; node = node.nextTarget) {
        node.target.notify();
      }
    } finally {
      endBatch();
    }
  }
}

/// Convenient global constructor for creating a mutable reactive state signal.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final count = signal(0);
/// final name = signal('Jane');
/// ```
Signal<T> signal<T>(
  T value, [
  SignalOptions<T>? options,
]) {
  return Signal<T>(
    value,
    options: options,
  );
}
