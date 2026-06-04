part of 'signals.dart';

/// Simple writeable signal
class Signal<T> extends signals.Signal<T>
    with ReadonlySignalMixin<T>, SignalsAutoDisposeMixin<T>
    implements ReadonlySignal<T> {
  /// Simple writeable signal.
  ///
  /// ```dart
  /// final count = signal(0);
  /// print(count.value); // 0
  /// count.value++;
  /// print(count.value); // 1
  /// ```
  Signal(
    super.internalValue, {
    SignalOptions<T>? options,
    @Deprecated('Use options: SignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: SignalOptions(name: ...) instead')
    String? debugLabel,
  }) : super(
          name: options?.name ?? debugLabel,
          watched: options?.watched,
          unwatched: options?.unwatched,
          options: options ??
              SignalOptions<T>(
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        ) {
    this.autoDispose = options?.autoDispose ?? autoDispose ?? false;
    afterCreate(super.internalValue);
  }

  /// Lazy signal that can be created with type T that
  /// the value will be assigned later.
  ///
  /// ```dart
  /// final db = Signal.lazy<DatabaseConnection>();
  /// ...
  /// db.value = DatabaseConnect(...);
  /// ```
  Signal.lazy({
    SignalOptions<T>? options,
    @Deprecated('Use options: SignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: SignalOptions(name: ...) instead')
    String? debugLabel,
  }) : super.lazy(
          name: options?.name ?? debugLabel,
          watched: options?.watched,
          unwatched: options?.unwatched,
          options: options ??
              SignalOptions<T>(
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        ) {
    this.autoDispose = options?.autoDispose ?? autoDispose ?? false;
  }

  @override
  @internal
  void afterCreate(T val) {
    if (kDebugMode) {
      SignalsObserver.instance?.onSignalCreated(this, val);
    }
    isInitialized = true;
  }

  @override
  @internal
  void beforeUpdate(T val) {
    if (kDebugMode) {
      SignalsObserver.instance?.onSignalUpdated(this, val);
    }
  }

  @override
  @Deprecated('Use name instead')
  String? get debugLabel => name;

  /// Optional method to check if to values are the same
  @override
  signals.SignalEquality<T> get equalityCheck => super.equalityCheck;

  @override
  bool set(
    T val, {
    /// Skip equality check and update the value
    bool force = false,
  }) {
    if (disposed) {
      throw SignalsWriteAfterDisposeError(this);
    }
    if (force || !isInitialized || !equalityCheck.equals(val, internalValue)) {
      beforeUpdate(val);
      internalSetValue(val);
      return true;
    }
    return false;
  }

  @override
  T get value {
    if (!isInitialized) {
      throw LazySignalInitializationError(this);
    }
    if (disposed) {
      if (kDebugMode) {
        print(
          'signal warning: [$globalId|$debugLabel] has been '
          'read after disposed: ${StackTrace.current}',
        );
      }
    }
    return super.value;
  }

  /// Returns a readonly signal
  ReadonlySignal<T> readonly() => this;

  @override
  void unsubscribeFromNode(Node node) {
    super.unsubscribeFromNode(node);
    if (autoDispose && targets == null) {
      dispose();
    }
  }

  /// Override the current signal with a new value as if it was created with it.
  ///
  /// This does not trigger any updates.
  ///
  /// ```dart
  /// var counter = signal(0);
  ///
  /// // Override the signal with a new value
  /// counter = counter.overrideWith(1);
  /// ```
  @Deprecated(
    'Use direct signal mutation in tests, or wrap signals in Ref from lite_ref and use Ref.overrideWith instead. '
    'This method will be removed in a future major release.',
  )
  Signal<T> overrideWith(T val) {
    version = 0;
    afterCreate(val);
    internalValue = val;
    return this;
  }
}

// /// A signal that tracks the previous value
// class _Signal<T> extends _SignalBase<T> implements TrackedReadonlySignal<T> {
//   /// Create a signal that tracks the previous value
//   _Signal(
//     super.val, {
//     super.debugLabel,
//     super.equality,
//     super.autoDispose,
//   }) : _initialValue = val;

//   T _initialValue;
//   T? _previousValue;

//   @override
//   void _updateValue(T val) {
//     _previousValue = _value;
//     super._updateValue(val);
//   }

//   /// Get the value the signal was created with
//   @override
//   T get initialValue => _initialValue;

//   /// Get the previous value if present
//   @override
//   T? get previousValue => _previousValue;

//   @override
//   void _reset(T? value) {
//     _previousValue = value ?? _initialValue;
//     _initialValue = value ?? _initialValue;
//     super._reset(value);
//   }
// }

/// {@template signal}
/// A `Signal` is a reactive container for a value that changes over time. It forms the bedrock of the reactive framework, allowing fine-grained, glitch-free propagation of state updates to dependent computeds and effects.
///
/// You can read a signal's current state, mutate it to dispatch updates, or subscribe to changes by accessing its `.value` property inside any active reactive context.
///
/// ### Core Example
/// ```dart
/// import 'package:signals/signals.dart';
///
/// // Create a reactive signal holding an integer
/// final counter = signal(0);
///
/// // Read the value: prints 0
/// print(counter.value);
///
/// // Write to a signal: dispatches updates to all downstreams synchronously
/// counter.value = 1;
/// ```
///
/// ---
///
/// ## Key API Capabilities
///
/// ### 1. Reading & Writing via `.value`
/// The `.value` property is the default way to interact with a signal.
/// - **Inside a Reactive Context:** Accessing `.value` inside a [computed] block or [effect] callback automatically registers the signal as a dependency, establishing an active subscription.
/// - **Outside a Reactive Context:** Acts as a standard getter and setter, allowing you to fetch or update the underlying state.
///
/// ### 2. Non-reactive Reads via `.peek()`
/// If you need to read a signal's current value *without* subscribing to its updates inside a reactive context, use the `.peek()` method. This is invaluable when writing to another signal inside an effect based on the previous state, preventing infinite update loops (cycles).
///
/// ```dart
/// final counter = signal(0);
/// final effectTriggerCount = signal(0);
///
/// effect(() {
///   // Subscribes to changes of `counter`
///   final current = counter.value;
///   print('Counter updated: $current');
///
///   // Read current count non-reactively and increment.
///   // The effect will NOT subscribe to `effectTriggerCount`.
///   effectTriggerCount.value = effectTriggerCount.peek() + 1;
/// });
/// ```
///
/// ### 3. Accessing the Previous State via `.previousValue`
/// Signals automatically cache their immediately preceding value. Accessing `.previousValue` lets you perform diffing or historic analysis. Like `.peek()`, reading `.previousValue` does not establish a reactive dependency.
///
/// ```dart
/// final username = signal("initial_user");
///
/// effect(() {
///   print('Current Username: ${username.value}');
///   print('Previous Username: ${username.previousValue}');
/// });
///
/// username.value = "new_user";
/// // Prints:
/// // Current Username: new_user
/// // Previous Username: initial_user
/// ```
///
/// ### 4. Force Updates via `.set()`
/// When dealing with mutable data types (e.g., custom class instances, collections), mutating properties directly does not change the instance reference. You can force an update using `.set(..., force: true)` to skip standard equality checks and notify all downstreams.
///
/// ```dart
/// final numbers = signal([1, 2, 3]);
///
/// // Modify the list in-place and force notify
/// numbers.value.add(4);
/// numbers.set(numbers.value, force: true);
/// ```
///
/// ---
///
/// ## Lifecycle & Resource Management
///
/// ### Auto-Disposal
/// If a signal is constructed with `autoDispose: true`, it will automatically destroy itself when it no longer has active reactive listeners (subscriptions). This prevents memory leaks by freeing resources as soon as they are out of scope.
///
/// ```dart
/// final s = signal(0, options: SignalOptions(autoDispose: true));
///
/// s.onDispose(() => print('Signal has been disposed!'));
///
/// // Create active subscriber
/// final dispose = s.subscribe((_) {});
///
/// // Cancel subscription: s has no listeners, so it self-disposes
/// dispose();
/// // Prints: "Signal has been disposed!"
/// ```
///
/// You can manually verify the lifecycle state using `.disposed`, or register custom clean-up routines via `.onDispose(callback)`.
///
/// ---
///
/// ## Flutter Integration
/// In Flutter applications, manage state and reactivity seamlessly by using [SignalWidget] (for stateless widgets) or [SignalStatefulWidget] (for stateful widgets).
/// These widgets establish an implicit reactive context directly at the element layer. Any signal accessed via `.value` inside the `build` method is automatically tracked, and the widget automatically rebuilds when they mutate.
///
/// ### Stateless Example with [SignalWidget]
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:signals/signals_flutter.dart';
///
/// final counter = signal(0);
///
/// class CounterDisplay extends SignalWidget {
///   const CounterDisplay({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Center(
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: [
///             Text('Count: ${counter.value}'),
///             ElevatedButton(
///               onPressed: () => counter.value++,
///               child: const Text('Increment'),
///             ),
///           ],
///         ),
///       ),
///     );
///   }
/// }
/// ```
///
/// ### Stateful Example with [SignalStatefulWidget]
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:signals/signals_flutter.dart';
///
/// class CounterDisplay extends SignalStatefulWidget {
///   const CounterDisplay({super.key});
///
///   @override
///   State<CounterDisplay> createState() => _CounterDisplayState();
/// }
///
/// class _CounterDisplayState extends State<CounterDisplay> {
///   // Local signal scoped to this widget state:
///   final counter = signal(0);
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Center(
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: [
///             Text('Count: ${counter.value}'),
///             ElevatedButton(
///               onPressed: () => counter.value++,
///               child: const Text('Increment'),
///             ),
///           ],
///         ),
///       ),
///     );
///   }
/// }
/// ```
///
/// ---
///
/// ## Testing Strategies
///
/// ### 1. Converting to Streams
/// You can convert any reactive signal into a standard Dart [Stream] by calling `.toStream()`. This is highly beneficial for testing signal value sequences in order using test matchers.
///
/// ```dart
/// test('emits sequential count updates in order', () async {
///   final counter = signal(0);
///   final stream = counter.toStream();
///
///   counter.value = 1;
///   counter.value = 2;
///
///   await expectLater(stream, emitsInOrder([0, 1, 2]));
/// });
/// ```
///
/// ### 2. Dependency Injection & Mock Overrides
/// Global or lazy signals used across your application can be mocked or overridden during testing via `.overrideWith(value)`. This returns a new signal sharing the same global identifier, helping you mock complex state dependencies seamlessly.
///
/// ```dart
/// test('mocking global signals', () {
///   final apiToken = signal("production_token");
///
///   // Override with test mock token
///   apiToken.overrideWith("mock_test_token");
///
///   expect(apiToken.value, "mock_test_token");
/// });
/// ```
///
/// @link https://dartsignals.dev/core/signal
/// {@endtemplate}
Signal<T> signal<T>(
  T value, {
  SignalOptions<T>? options,
  @Deprecated('Use options: SignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: SignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return Signal<T>(
    value,
    options: options ??
        SignalOptions<T>(
          autoDispose: autoDispose ?? false,
          name: debugLabel,
        ),
  );
}

/// Lazy signal that can be created with type T that
/// the value will be assigned later.
///
/// ```dart
/// final db = lazySignal<DatabaseConnection>();
/// ...
/// db.value = DatabaseConnect(...);
/// ```
Signal<T> lazySignal<T>({
  SignalOptions<T>? options,
  @Deprecated('Use options: SignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: SignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return Signal<T>.lazy(
    options: options ??
        SignalOptions<T>(
          autoDispose: autoDispose ?? false,
          name: debugLabel,
        ),
  );
}
