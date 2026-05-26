part of 'signals.dart';

/// {@template computed}
/// A `Computed` signal represents derived reactive state. It combines the values of multiple dependency signals into a new read-only signal, automatically re-evaluating whenever any of its dependencies mutate.
///
/// Computed signals are **lazily evaluated** and **memoized** by default:
/// - **Lazy Evaluation:** The computed callback is only executed when the computed signal is actively read or listened to.
/// - **Memoization:** The computed signal caches its return value and will not re-run its callback if its dependency values have not changed or if no active listeners exist.
/// - **Glitch-Free Propagation:** The reactive graph updates topologically. This guarantees that intermediate "glitches" (inconsistent state views) are physically impossible during multiple simultaneous signal updates.
///
/// ### Core Example
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final firstName = signal("Jane");
/// final lastName = signal("Doe");
///
/// // Create a derived computed signal
/// final fullName = computed(() => "${firstName.value} ${lastName.value}");
///
/// // Accessing .value: prints "Jane Doe"
/// print(fullName.value); 
///
/// // Update a dependency: fullName will automatically reflect changes on next read
/// firstName.value = "John";
/// print(fullName.value); // Prints "John Doe"
/// ```
///
/// Any signal accessed inside the computed callback block is automatically registered as a dependency.
///
/// ---
///
/// ## Key API Capabilities
///
/// ### 1. Forcing Re-evaluation via `.recompute()`
/// In advanced scenarios where a computed value depends on external, non-reactive variables, you can force the computed block to discard its cache and re-evaluate immediately using `.recompute()`.
///
/// ```dart
/// final externalTime = DateTime.now();
/// final timeString = computed(() {
///   return "Time: ${externalTime.toIso8601String()}";
/// });
///
/// // Force re-runs the callback
/// timeString.recompute(); 
/// ```
///
/// ### 2. Resource Management & Disposal
/// Like standard signals, a computed signal can be configured to automatically garbage-collect itself when it has no active subscribers.
///
/// - **Auto-Dispose:** Set `autoDispose: true` in the options. The computed signal will release its cached value, clear all dependency listeners, and enter a frozen state once all active subscriptions are terminated.
/// - **Lifecyle Callbacks:** Register custom routines via `.onDispose(callback)` to clean up external streams or resources used within the computed block.
///
/// ```dart
/// final s = computed(
///   () => 42,
///   options: ComputedOptions(autoDispose: true),
/// );
/// 
/// s.onDispose(() => print('Computed destroyed'));
///
/// final dispose = s.subscribe((_) {});
/// dispose(); // Prints: "Computed destroyed"
/// ```
///
/// ---
///
/// ## Flutter Integration
/// In Flutter applications, manage derived/computed state seamlessly by utilizing [SignalStatefulWidget] (for state-bound signals and computeds) or [SignalWidget].
/// Computed signals accessed via `.value` inside the `build` method are automatically tracked, ensuring the widget rebuilds only when the computed value changes.
///
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:signals/signals_flutter.dart';
///
/// class EvenOddWidget extends SignalStatefulWidget {
///   const EvenOddWidget({super.key});
///
///   @override
///   State<EvenOddWidget> createState() => _EvenOddWidgetState();
/// }
///
/// class _EvenOddWidgetState extends State<EvenOddWidget> {
///   final counter = signal(0);
///   
///   // Derived state tied directly to the State object lifecycle
///   late final isEven = computed(() => counter.value.isEven);
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Center(
///         // Rebuilds implicitly when isEven.value changes
///         child: Text('Is Even: ${isEven.value}'),
///       ),
///     );
///   }
/// }
/// ```
///
/// ---
///
/// ## Testing Strategies
/// Testing derived computed states is extremely straightforward. You can easily test them directly as raw values or sequence them in asynchronous flows by converting the computed signal into a Dart stream via `.toStream()`.
///
/// ```dart
/// test('computed stream emissions', () async {
///   final a = signal(0);
///   final doubleVal = computed(() => a.value * 2);
///   final stream = doubleVal.toStream();
///
///   a.value = 1;
///   a.value = 2;
///
///   await expectLater(stream, emitsInOrder([0, 2, 4]));
/// });
/// ```
/// @link https://dartsignals.dev/core/computed
/// You can also override the initial value of a computed signal when testing. This is is useful for mocking and testing specific value implementations.
///
/// ```dart
/// test('test with override', () {
///     final a = signal(0);
///     final s = computed(() => a()).overrideWith(-1);
///
///     final stream = s.toStream();
///
///     a.value = 1;
///     a.value = 2;
///     a.value = 2; // check if skipped
///     a.value = 3;
///
///     expect(stream, emitsInOrder([-1, 1, 2, 3]));
/// });
/// ```
///
/// `overrideWith` returns a new computed signal with the same global id sets the value as if the computed callback returned it.
/// @link https://dartsignals.dev/core/computed
/// {@endtemplate}
class Computed<T> extends signals.Computed<T>
    with ReadonlySignalMixin<T>, SignalsAutoDisposeMixin<T>
    implements ReadonlySignal<T> {
  /// {@template computed}
  /// Data is often derived from other pieces of existing data. The `computed` function lets you combine the values of multiple signals into a new signal that can be reacted to, or even used by additional computeds. When the signals accessed from within a computed callback change, the computed callback is re-executed and its new return value becomes the computed signal's value.
  ///
  /// > `Computed` class extends the [`Signal`](/core/signal/) class, so you can use it anywhere you would use a signal.
  ///
  /// ```dart
  /// import 'package:signals/signals.dart';
  ///
  /// final name = signal("Jane");
  /// final surname = signal("Doe");
  ///
  /// final fullName = computed(() => name.value + " " + surname.value);
  ///
  /// // Logs: "Jane Doe"
  /// print(fullName.value);
  ///
  /// // Updates flow through computed, but only if someone
  /// // subscribes to it. More on that later.
  /// name.value = "John";
  /// // Logs: "John Doe"
  /// print(fullName.value);
  /// ```
  ///
  /// Any signal that is accessed inside the `computed`'s callback function will be automatically subscribed to and tracked as a dependency of the computed signal.
  ///
  /// > Computed signals are both lazily evaluated and memoized
  ///
  /// ## Force Re-evaluation
  ///
  /// You can force a computed signal to re-evaluate by calling its `.recompute` method. This will re-run the computed callback and update the computed signal's value.
  ///
  /// ```dart
  /// final name = signal("Jane");
  /// final surname = signal("Doe");
  /// final fullName = computed(() => name.value + " " + surname.value);
  ///
  /// fullName.recompute(); // Re-runs the computed callback
  /// ```
  ///
  /// ## Disposing
  ///
  /// ### Auto Dispose
  ///
  /// If a computed signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.
  ///
  /// ```dart
  /// final s = computed(() => 0, autoDispose: true);
  /// s.onDispose(() => print('Signal destroyed'));
  /// final dispose = s.subscribe((_) {});
  /// dispose();
  /// final value = s.value; // 0
  /// // prints: Signal destroyed
  /// ```
  ///
  /// A auto disposing signal does not require its dependencies to be auto disposing. When it is disposed it will freeze its value and stop tracking its dependencies.
  ///
  /// This means that it will no longer react to changes in its dependencies.
  ///
  /// ```dart
  /// final s = computed(() => 0);
  /// s.dispose();
  /// final value = s.value; // 0
  /// final b = computed(() => s.value); // 0
  /// // b will not react to changes in s
  /// ```
  ///
  /// You can check if a signal is disposed by calling the `.disposed` method.
  ///
  /// ```dart
  /// final s = computed(() => 0);
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
  /// final s = computed(() => 0);
  /// s.onDispose(() => print('Signal destroyed'));
  /// s.dispose();
  /// ```
  ///
  ///
  /// ## Flutter
  ///
  /// In Flutter applications, manage derived/computed state seamlessly by utilizing [SignalStatefulWidget] (for state-bound signals and computeds) or [SignalWidget].
  /// Computed signals accessed via `.value` inside the `build` method are automatically tracked, ensuring the widget rebuilds only when the computed value changes.
  ///
  /// ```dart
  /// import 'package:flutter/material.dart';
  /// import 'package:signals/signals_flutter.dart';
  ///
  /// class CounterWidget extends SignalStatefulWidget {
  ///   @override
  ///   _CounterWidgetState createState() => _CounterWidgetState();
  /// }
  ///
  /// class _CounterWidgetState extends State<CounterWidget> {
  ///   final counter = signal(0);
  ///   late final isEven = computed(() => counter.value.isEven);
  ///   late final isOdd = computed(() => counter.value.isOdd);
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Scaffold(
  ///       body: Center(
  ///         child: Column(
  ///           mainAxisAlignment: MainAxisAlignment.center,
  ///           children: [
  ///             Text('Counter: even=${isEven.value}, odd=${isOdd.value}'),
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
  /// No manual `Watch` widget or context extension is needed; the widget automatically rebuilds when any tracked signal mutates.
  ///
  /// ## Testing
  ///
  /// Testing computed signals is possible by converting a computed to a stream and testing it like any other stream in Dart.
  ///
  /// ```dart
  /// test('test as stream', () {
  ///     final a = signal(0);
  ///     final s = computed(() => a());
  ///     final stream = s.toStream();
  ///
  ///     a.value = 1;
  ///     a.value = 2;
  ///     a.value = 3;
  ///
  ///     expect(stream, emitsInOrder([0, 1, 2, 3]));
  /// });
  /// ```
  ///
  /// `emitsInOrder` is a matcher that will check if the stream emits the values in the correct order which in this case is each value after a signal is updated.
  ///
  /// You can also override the initial value of a computed signal when testing. This is is useful for mocking and testing specific value implementations.
  ///
  /// ```dart
  /// test('test with override', () {
  ///     final a = signal(0);
  ///     final s = computed(() => a()).overrideWith(-1);
  ///
  ///     final stream = s.toStream();
  ///
  ///     a.value = 1;
  ///     a.value = 2;
  ///     a.value = 2; // check if skipped
  ///     a.value = 3;
  ///
  ///     expect(stream, emitsInOrder([-1, 1, 2, 3]));
  /// });
  /// ```
  ///
  /// `overrideWith` returns a new computed signal with the same global id sets the value as if the computed callback returned it.
  /// @link https://dartsignals.dev/core/computed
  /// {@endtemplate}
  Computed(
    super.fn, {
    ComputedOptions<T>? options,
    @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: ComputedOptions(name: ...) instead')
    String? debugLabel,
  }) : super(
          name: options?.name ?? debugLabel,
          watched: options?.watched,
          unwatched: options?.unwatched,
          options: options ??
              ComputedOptions<T>(
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        ) {
    this.autoDispose = options?.autoDispose ?? autoDispose ?? false;
    if (kDebugMode) {
      SignalsObserver.instance?.onComputedCreated(this);
    }
  }

  /// Override the current signal with a new value as if it was created with it.
  ///
  /// This does not trigger any updates.
  ///
  /// ```dart
  /// var counter = computed(() => 0);
  ///
  /// // Override the signal with a new value
  /// counter = counter.overrideWith(1);
  /// ```
  @Deprecated(
    'Wrap signals/computeds in Ref from lite_ref and use Ref.overrideWith instead. '
    'This method will be removed in a future major release.',
  )
  Computed<T> overrideWith(T val) {
    fn = () => val;
    flags = OUTDATED;
    // _version = 0;
    afterCreate(val);
    return this;
  }

  @override
  void afterCreate(T val) {
    if (kDebugMode) {
      SignalsObserver.instance?.onComputedCreated(this);
    }
  }

  @override
  void beforeUpdate(T val) {
    if (kDebugMode) {
      SignalsObserver.instance?.onComputedUpdated(this, val);
    }
  }

  @override
  @Deprecated('Use name instead')
  String? get debugLabel => name;

  /// Call the computed function and update the value
  void recompute() {
    value;
    internalValue = fn();
    flags |= OUTDATED | NOTIFIED;

    for (var node = targets; node != null; node = node.nextTarget) {
      node.target.notify();
    }
  }

  @override
  void dispose() {
    super.dispose();
    flags |= DISPOSED;
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

  @override
  T get value {
    if (disposed) {
      print(
        'computed warning: [$globalId|$debugLabel] has been '
        'read after disposed: ${StackTrace.current}',
      );
    }
    return super.value;
  }

  @override
  set internalValue(T value) {
    beforeUpdate(value);
    super.internalValue = value;
  }
}

/// A callback that is executed inside a computed.
typedef ComputedCallback<T> = T Function();

/// {@template computed}
/// Data is often derived from other pieces of existing data. The `computed` function lets you combine the values of multiple signals into a new signal that can be reacted to, or even used by additional computeds. When the signals accessed from within a computed callback change, the computed callback is re-executed and its new return value becomes the computed signal's value.
///
/// > `Computed` class extends the [`Signal`](/core/signal/) class, so you can use it anywhere you would use a signal.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final name = signal("Jane");
/// final surname = signal("Doe");
///
/// final fullName = computed(() => name.value + " " + surname.value);
///
/// // Logs: "Jane Doe"
/// print(fullName.value);
///
/// // Updates flow through computed, but only if someone
/// // subscribes to it. More on that later.
/// name.value = "John";
/// // Logs: "John Doe"
/// print(fullName.value);
/// ```
///
/// Any signal that is accessed inside the `computed`'s callback function will be automatically subscribed to and tracked as a dependency of the computed signal.
///
/// > Computed signals are both lazily evaluated and memoized
///
/// ## Force Re-evaluation
///
/// You can force a computed signal to re-evaluate by calling its `.recompute` method. This will re-run the computed callback and update the computed signal's value.
///
/// ```dart
/// final name = signal("Jane");
/// final surname = signal("Doe");
/// final fullName = computed(() => name.value + " " + surname.value);
///
/// fullName.recompute(); // Re-runs the computed callback
/// ```
///
/// ## Disposing
///
/// ### Auto Dispose
///
/// If a computed signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.
///
/// ```dart
/// final s = computed(() => 0, autoDispose: true);
/// s.onDispose(() => print('Signal destroyed'));
/// final dispose = s.subscribe((_) {});
/// dispose();
/// final value = s.value; // 0
/// // prints: Signal destroyed
/// ```
///
/// A auto disposing signal does not require its dependencies to be auto disposing. When it is disposed it will freeze its value and stop tracking its dependencies.
///
/// This means that it will no longer react to changes in its dependencies.
///
/// ```dart
/// final s = computed(() => 0);
/// s.dispose();
/// final value = s.value; // 0
/// final b = computed(() => s.value); // 0
/// // b will not react to changes in s
/// ```
///
/// You can check if a signal is disposed by calling the `.disposed` method.
///
/// ```dart
/// final s = computed(() => 0);
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
/// final s = computed(() => 0);
/// s.onDispose(() => print('Signal destroyed'));
/// s.dispose();
/// ```
///
///
/// ## Flutter
///
/// In Flutter applications, manage derived/computed state seamlessly by utilizing [SignalStatefulWidget] (for state-bound signals and computeds) or [SignalWidget].
/// Computed signals accessed via `.value` inside the `build` method are automatically tracked, ensuring the widget rebuilds only when the computed value changes.
///
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:signals/signals_flutter.dart';
///
/// class CounterWidget extends SignalStatefulWidget {
///   @override
///   _CounterWidgetState createState() => _CounterWidgetState();
/// }
///
/// class _CounterWidgetState extends State<CounterWidget> {
///   final counter = signal(0);
///   late final isEven = computed(() => counter.value.isEven);
///   late final isOdd = computed(() => counter.value.isOdd);
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Center(
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: [
///             Text('Counter: even=${isEven.value}, odd=${isOdd.value}'),
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
/// No manual `Watch` widget or context extension is needed; the widget automatically rebuilds when any tracked signal mutates.
///
/// ## Testing
///
/// Testing computed signals is possible by converting a computed to a stream and testing it like any other stream in Dart.
///
/// ```dart
/// test('test as stream', () {
///     final a = signal(0);
///     final s = computed(() => a());
///     final stream = s.toStream();
///
///     a.value = 1;
///     a.value = 2;
///     a.value = 3;
///
///     expect(stream, emitsInOrder([0, 1, 2, 3]));
/// });
/// ```
///
/// `emitsInOrder` is a matcher that will check if the stream emits the values in the correct order which in this case is each value after a signal is updated.
///
/// You can also override the initial value of a computed signal when testing. This is is useful for mocking and testing specific value implementations.
///
/// ```dart
/// test('test with override', () {
///     final a = signal(0);
///     final s = computed(() => a()).overrideWith(-1);
///
///     final stream = s.toStream();
///
///     a.value = 1;
///     a.value = 2;
///     a.value = 2; // check if skipped
///     a.value = 3;
///
///     expect(stream, emitsInOrder([-1, 1, 2, 3]));
/// });
/// ```
///
/// `overrideWith` returns a new computed signal with the same global id sets the value as if the computed callback returned it.
/// @link https://dartsignals.dev/core/computed
/// {@endtemplate}
Computed<T> computed<T>(
  ComputedCallback<T> compute, {
  ComputedOptions<T>? options,
  @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: ComputedOptions(name: ...) instead')
  String? debugLabel,
}) {
  return Computed<T>(
    compute,
    options: options ??
        ComputedOptions<T>(
          autoDispose: autoDispose ?? false,
          name: debugLabel,
        ),
  );
}
