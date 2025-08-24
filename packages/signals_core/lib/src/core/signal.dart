part of 'signals.dart';

/// Simple writeable signal
class Signal<T> extends signals.Signal<T>
    with ReadonlySignalMixin<T>
    implements ReadonlySignal<T> {
  /// {@macro signal}
  Signal(
    super.internalValue, {
    this.debugLabel,
    bool autoDispose = false,
  }) {
    this.autoDispose = autoDispose;
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
    this.debugLabel,
    bool autoDispose = false,
  }) : super.lazy() {
    this.autoDispose = autoDispose;
  }

  @override
  void afterCreate(T val) {
    SignalsObserver.instance?.onSignalCreated(this, val);
    isInitialized = true;
  }

  @override
  void beforeUpdate(T val) {
    SignalsObserver.instance?.onSignalUpdated(this, val);
  }

  @override
  final String? debugLabel;

  /// Optional method to check if to values are the same
  bool Function(T a, T b) equalityCheck = (T a, T b) => a == b;

  @override
  bool set(
    T val, {
    /// Skip equality check and update the value
    bool force = false,
  }) {
    if (disposed) {
      throw SignalsWriteAfterDisposeError(this);
    }
    if (force || !isInitialized || !equalityCheck(val, internalValue)) {
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

  /// Override the current signal with a new value as if it was created with it
  ///
  /// This does not trigger any updates
  ///
  /// ```dart
  /// var counter = signal(0);
  ///
  /// // Override the signal with a new value
  /// counter = counter.overrideWith(1);
  /// ```
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
/// The `signal` function creates a new signal. A signal is a container for a value that can change over time. You can read a signal's value or subscribe to value updates by accessing its `.value` property.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final counter = signal(0);
///
/// // Read value from signal, logs: 0
/// print(counter.value);
///
/// // Write to a signal
/// counter.value = 1;
/// ```
///
/// Signals can be created globally, inside classes or functions. It's up to you how you want to structure your app.
///
/// It is not recommended to create signals inside effects or computed, as this will create a new signal every time the effect or computed is triggered. This can lead to unexpected behavior.
///
/// In Flutter do not create signals inside `build` methods, as this will create a new signal every time the widget is rebuilt.
///
/// ## Writing to a signal
///
/// Writing to a signal is done by setting its `.value` property. Changing a signal's value synchronously updates every [computed](/core/computed) and [effect](/core/effect) that depends on that signal, ensuring your app state is always consistent.
///
/// ## .peek()
///
/// In the rare instance that you have an effect that should write to another signal based on the previous value, but you _don't_ want the effect to be subscribed to that signal, you can read a signals's previous value via `signal.peek()`.
///
/// ```dart
/// final counter = signal(0);
/// final effectCount = signal(0);
///
/// effect(() {
/// 	print(counter.value);
///
/// 	// Whenever this effect is triggered, increase `effectCount`.
/// 	// But we don't want this signal to react to `effectCount`
/// 	effectCount.value = effectCount.peek() + 1;
/// });
/// ```
///
/// Note that you should only use `signal.peek()` if you really need it. Reading a signal's value via `signal.value` is the preferred way in most scenarios.
///
/// ## .value
///
/// The `.value` property of a signal is used to read or write to the signal. If used inside an effect or computed, it will subscribe to the signal and trigger the effect or computed whenever the signal's value changes.
///
/// ```dart
/// final counter = signal(0);
///
/// effect(() {
/// 	print(counter.value);
/// });
///
/// counter.value = 1;
/// ```
///
/// ## .previousValue
///
/// The `.previousValue` property of a signal is used to read the previous value of the signal. If used inside an effect or computed, it will not subscribe to the signal and not trigger the effect or computed whenever the signal's value changes.
///
/// ```dart
/// final counter = signal(0);
///
/// effect(() {
/// 	print('Current value: ${counter.value}');
/// 	print('Previous value: ${counter.previousValue}');
/// });
///
/// counter.value = 1;
/// ```
///
/// ## Force Update
///
/// If you want to force an update for a signal, you can call the `.set(..., force: true)` method. This will trigger all effects and mark all computed as dirty.
///
/// ```dart
/// final counter = signal(0);
/// counter.set(1, force: true);
/// ```
///
/// ## Disposing
///
/// ### Auto Dispose
///
/// If a signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.
///
/// ```dart
/// final s = signal(0, autoDispose: true);
/// s.onDispose(() => print('Signal destroyed'));
/// final dispose = s.subscribe((_) {});
/// dispose();
/// final value = s.value; // 0
/// // prints: Signal destroyed
/// ```
///
/// A auto disposing signal does not require its dependencies to be auto disposing. When it is disposed it will freeze its value and stop tracking its dependencies.
///
/// ```dart
/// final s = signal(0);
/// s.dispose();
/// final c = computed(() => s.value);
/// // c will not react to changes in s
/// ```
///
/// You can check if a signal is disposed by calling the `.disposed` method.
///
/// ```dart
/// final s = signal(0);
/// print(s.disposed); // false
/// s.dispose();
/// print(s.disposed); // true
/// ```
///
/// ### On Dispose Callback
///
/// You can attach a callback to a signal that will be called when the signal is destroyed.
///
/// ```dart
/// final s = signal(0);
/// s.onDispose(() => print('Signal destroyed'));
/// s.dispose();
/// ```
///
/// ## Flutter
///
/// In Flutter if you want to create a signal that automatically disposes itself when the widget is removed from the widget tree and rebuilds the widget when the signal changes, you can use the `createSignal` inside a stateful widget.
///
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:signals/signals_flutter.dart';
///
/// class CounterWidget extends StatefulWidget {
///   @override
///   _CounterWidgetState createState() => _CounterWidgetState();
/// }
///
/// class _CounterWidgetState extends State<CounterWidget> with SignalsAutoDisposeMixin {
///   late final counter = createSignal(0);
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Center(
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: [
///             Text('Counter: $counter'),
///             ElevatedButton(
///               onPressed: () => counter.value++,
///               child: Text('Increment'),
///             ),
///           ],
///         ),
///       ),
///     );
///   }
/// }
/// ```
///
/// No `Watch` widget or extension is needed, the signal will automatically dispose itself when the widget is removed from the widget tree.
///
/// The `SignalsAutoDisposeMixin` is a mixin that automatically disposes all signals created in the state when the widget is removed from the widget tree.
///
/// ## Testing
///
/// Testing signals is possible by converting a signal to a stream and testing it like any other stream in Dart.
///
/// ```dart
/// test('test as stream', () {
///   final s = signal(0);
///   final stream = s.toStream(); // create a stream of values
///
///   s.value = 1;
///   s.value = 2;
///   s.value = 3;
///
///   expect(stream, emitsInOrder([0, 1, 2, 3]));
/// });
/// ```
///
/// `emitsInOrder` is a matcher that will check if the stream emits the values in the correct order which in this case is each value after a signal is updated.
///
/// You can also override the initial value of a signal when testing. This is is useful for mocking and testing specific value implementations.
///
/// ```dart
/// test('test with override', () {
///   final s = signal(0).overrideWith(-1);
///
///   final stream = s.toStream();
///
///   s.value = 1;
///   s.value = 2;
///   s.value = 3;
///
///   expect(stream, emitsInOrder([-1, 1, 2, 3]));
/// });
/// ```
///
/// `overrideWith` returns a new signal with the same global id sets the value as if it was created with it. This can be useful when using async signals or global signals used for dependency injection.
/// @link https://dartsignals.dev/core/signal
/// {@endtemplate}
Signal<T> signal<T>(
  T value, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return Signal<T>(
    value,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
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
  String? debugLabel,
  bool autoDispose = false,
}) {
  return Signal<T>.lazy(
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}
