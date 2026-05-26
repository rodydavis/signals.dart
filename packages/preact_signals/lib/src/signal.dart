import 'package:meta/meta.dart';

import 'batch.dart';
import 'equality.dart';
import 'globals.dart';
import 'node.dart';
import 'options.dart';
import 'readonly.dart';

/// Represents a mutable reactive state container.
///
/// Signals hold a single [value] that can be read or modified. When a signal's value
/// is updated, any active computations (like [Computed]) or effects (like [effect]) that
/// read the signal's value are automatically notified and scheduled to re-run.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// void main() {
///   final count = Signal(0);
///
///   effect(() {
///     print('Count is: ${count.value}');
///   });
///
///   count.value = 5; // Triggers print: Count is: 5
/// }
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
  T get value {
    final node = addDependency();
    if (node != null) {
      node.version = version;
    }
    return internalValue;
  }

  /// Set the current value by a setter
  set value(T val) => set(val);

  /// Set the current value by a method
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
