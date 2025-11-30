part of 'signals.dart';

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
/// In Flutter if you want to create a signal that automatically disposes itself when the widget is removed from the widget tree and rebuilds the widget when the signal changes, you can use the `createComputed` inside a stateful widget.
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
/// class _CounterWidgetState extends State<CounterWidget> with SignalsMixin {
///   late final counter = createSignal(0);
///   late final isEven = createComputed(() => counter.value.isEven);
///   late final isOdd = createComputed(() => counter.value.isOdd);
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Center(
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: [
///             Text('Counter: even=$isEven, odd=$isOdd'),
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
/// The `SignalsMixin` is a mixin that automatically disposes all signals created in the state when the widget is removed from the widget tree.
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
  /// In Flutter if you want to create a signal that automatically disposes itself when the widget is removed from the widget tree and rebuilds the widget when the signal changes, you can use the `createComputed` inside a stateful widget.
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
  /// class _CounterWidgetState extends State<CounterWidget> with SignalsMixin {
  ///   late final counter = createSignal(0);
  ///   late final isEven = createComputed(() => counter.value.isEven);
  ///   late final isOdd = createComputed(() => counter.value.isOdd);
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Scaffold(
  ///       body: Center(
  ///         child: Column(
  ///           mainAxisAlignment: MainAxisAlignment.center,
  ///           children: [
  ///             Text('Counter: even=$isEven, odd=$isOdd'),
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
  /// The `SignalsMixin` is a mixin that automatically disposes all signals created in the state when the widget is removed from the widget tree.
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
    custom_options.SignalOptions<T>? options,
  }) : super(
          options: options,
        ) {
    autoDispose = options?.autoDispose ?? false;
  }

  /// Override the current signal with a new value as if it was created with it
  ///
  /// This does not trigger any updates
  ///
  /// ```dart
  /// var counter = computed(() => 0);
  ///
  /// // Override the signal with a new value
  /// counter = counter.overrideWith(1);
  /// ```
  Computed<T> overrideWith(T val) {
    fn = () => val;
    flags = OUTDATED;
    // _version = 0;
    afterCreate(val);
    return this;
  }

  @override
  void afterCreate(T value) {}

  @override
  void beforeUpdate(T value) {}

  @override
  String? get debugLabel => name;

  @override
  T get value {
    if (disposed) {
      print(
        'computed warning: [$globalId|$debugLabel] has been read after disposed',
      );
    }
    return super.value;
  }

  /// Call the computed function and update the value
  void recompute() {
    value;
    final val = fn();
    beforeUpdate(val);
    internalValue = val;
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

  @override
  void unsubscribeFromNode(Node node) {
    super.unsubscribeFromNode(node);
    if (autoDispose && targets == null) {
      dispose();
    }
  }

  /// Returns a readonly signal
  ReadonlySignal<T> readonly() => this;
}

/// A callback that is executed inside a computed.
typedef ComputedCallback<T> = T Function();

/// {@template computed}
/// Data is often derived from other pieces of data. For example, we might have a `firstName` signal and a `lastName` signal, and we want to display the full name. We could create a `fullName` signal and update it whenever `firstName` or `lastName` changes, but that would be tedious and error-prone.
///
/// Instead, we can use a `computed` signal. A `computed` signal is a signal that derives its value from other signals. It's automatically updated whenever its dependencies change.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final firstName = signal('Jane');
/// final lastName = signal('Doe');
///
/// final fullName = computed(() => '${firstName.value} ${lastName.value}');
///
/// print(fullName.value); // Prints: Jane Doe
///
/// firstName.value = 'John';
/// print(fullName.value); // Prints: John Doe
/// ```
///
/// Any signal that is read inside the `computed` callback will be added as a dependency. When any of the dependencies change, the `computed` signal will be re-evaluated.
///
/// Computed signals are lazy, meaning they are only re-evaluated when their value is read. If a computed signal is not read, it will not be re-evaluated.
///
/// Computed signals are also memoized, meaning they cache their value and only re-evaluate when their dependencies change.
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
///             Text('Counter: even=$isEven, odd=$isOdd'),
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
/// The `SignalsMixin` is a mixin that automatically disposes all signals created in the state when the widget is removed from the widget tree.
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
  custom_options.SignalOptions<T>? options,
}) {
  return Computed<T>(
    compute,
    options: options,
  );
}
