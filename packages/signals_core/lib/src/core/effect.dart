part of 'signals.dart';

/// Clean up function to stop subscriptions from updating the callback
typedef EffectCleanup = void Function();

/// Function called when signals in the callback change
typedef EffectCallback = Function();

/// {@template effect}
/// The `effect` function is the last piece that makes everything reactive. When you access a signal inside its callback function, that signal and every dependency of said signal will be activated and subscribed to. In that regard it is very similar to [`computed(fn)`](/core/computed). By default all updates are lazy, so nothing will update until you access a signal inside `effect`.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final name = signal("Jane");
/// final surname = signal("Doe");
/// final fullName = computed(() => name.value + " " + surname.value);
///
/// // Logs: "Jane Doe"
/// effect(() => print(fullName.value));
///
/// // Updating one of its dependencies will automatically trigger
/// // the effect above, and will print "John Doe" to the console.
/// name.value = "John";
/// ```
///
/// You can destroy an effect and unsubscribe from all signals it was subscribed to, by calling the returned function.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final name = signal("Jane");
/// final surname = signal("Doe");
/// final fullName = computed(() => name.value + " " + surname.value);
///
/// // Logs: "Jane Doe"
/// final dispose = effect(() => print(fullName.value));
///
/// // Destroy effect and subscriptions
/// dispose();
///
/// // Update does nothing, because no one is subscribed anymore.
/// // Even the computed `fullName` signal won't change, because it knows
/// // that no one listens to it.
/// surname.value = "Doe 2";
/// ```
///
/// ## Cleanup Callback
///
/// You can also return a cleanup function from an effect. This function will be called when the effect is destroyed.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final s = signal(0);
///
/// final dispose = effect(() {
///   print(s.value);
///   return () => print('Effect destroyed');
/// });
///
/// // Destroy effect and subscriptions
/// dispose();
/// ```
///
/// ## On Dispose Callback
///
/// You can also pass a callback to `effect` that will be called when the effect is destroyed.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final s = signal(0);
///
/// final dispose = effect(() {
///   print(s.value);
/// }, onDispose: () => print('Effect destroyed'));
///
/// // Destroy effect and subscriptions
/// dispose();
/// ```
///
/// ## Warning About Cycles
///
/// Mutating a signal inside an effect will cause an infinite loop, because the effect will be triggered again. To prevent this, you can use [`untracked(fn)`](/core/untracked) to read a signal without subscribing to it.
///
/// ```dart
/// import 'dart:async';
///
/// import 'package:signals/signals.dart';
///
/// Future<void> main() async {
///   final completer = Completer<void>();
///   final age = signal(0);
///
///   effect(() {
///     print('You are ${age.value} years old');
///     age.value++; // <-- This will throw a cycle error
///   });
///
///   await completer.future;
/// }
/// ```
/// @link https://dartsignals.dev/core/effect
/// {@endtemplate}
class Effect extends signals.Effect {
  final _disposeCallbacks = <void Function()>{};

  /// {@template effect}
  /// The `effect` function is the last piece that makes everything reactive. When you access a signal inside its callback function, that signal and every dependency of said signal will be activated and subscribed to. In that regard it is very similar to [`computed(fn)`](/core/computed). By default all updates are lazy, so nothing will update until you access a signal inside `effect`.
  ///
  /// ```dart
  /// import 'package:signals/signals.dart';
  ///
  /// final name = signal("Jane");
  /// final surname = signal("Doe");
  /// final fullName = computed(() => name.value + " " + surname.value);
  ///
  /// // Logs: "Jane Doe"
  /// effect(() => print(fullName.value));
  ///
  /// // Updating one of its dependencies will automatically trigger
  /// // the effect above, and will print "John Doe" to the console.
  /// name.value = "John";
  /// ```
  ///
  /// You can destroy an effect and unsubscribe from all signals it was subscribed to, by calling the returned function.
  ///
  /// ```dart
  /// import 'package:signals/signals.dart';
  ///
  /// final name = signal("Jane");
  /// final surname = signal("Doe");
  /// final fullName = computed(() => name.value + " " + surname.value);
  ///
  /// // Logs: "Jane Doe"
  /// final dispose = effect(() => print(fullName.value));
  ///
  /// // Destroy effect and subscriptions
  /// dispose();
  ///
  /// // Update does nothing, because no one is subscribed anymore.
  /// // Even the computed `fullName` signal won't change, because it knows
  /// // that no one listens to it.
  /// surname.value = "Doe 2";
  /// ```
  ///
  /// ## Cleanup Callback
  ///
  /// You can also return a cleanup function from an effect. This function will be called when the effect is destroyed.
  ///
  /// ```dart
  /// import 'package:signals/signals.dart';
  ///
  /// final s = signal(0);
  ///
  /// final dispose = effect(() {
  ///   print(s.value);
  ///   return () => print('Effect destroyed');
  /// });
  ///
  /// // Destroy effect and subscriptions
  /// dispose();
  /// ```
  ///
  /// ## On Dispose Callback
  ///
  /// You can also pass a callback to `effect` that will be called when the effect is destroyed.
  ///
  /// ```dart
  /// import 'package:signals/signals.dart';
  ///
  /// final s = signal(0);
  ///
  /// final dispose = effect(() {
  ///   print(s.value);
  /// }, onDispose: () => print('Effect destroyed'));
  ///
  /// // Destroy effect and subscriptions
  /// dispose();
  /// ```
  ///
  /// ## Warning About Cycles
  ///
  /// Mutating a signal inside an effect will cause an infinite loop, because the effect will be triggered again. To prevent this, you can use [`untracked(fn)`](/core/untracked) to read a signal without subscribing to it.
  ///
  /// ```dart
  /// import 'dart:async';
  ///
  /// import 'package:signals/signals.dart';
  ///
  /// Future<void> main() async {
  ///   final completer = Completer<void>();
  ///   final age = signal(0);
  ///
  ///   effect(() {
  ///     print('You are ${age.value} years old');
  ///     age.value++; // <-- This will throw a cycle error
  ///   });
  ///
  ///   await completer.future;
  /// }
  /// ```
  /// @link https://dartsignals.dev/core/effect
  /// {@endtemplate}
  Effect(
    EffectCallback fn, {
    EffectOptions? options,
  }) : super(fn, options) {
    SignalsObserver.instance?.onEffectCreated(this);
  }

  @override
  void Function() call() {
    SignalsObserver.instance?.onEffectCalled(this);
    return super.call();
  }

  @override
  void dispose() {
    if (_disposed) return;
    super.dispose();
    for (final cleanup in _disposeCallbacks) {
      cleanup();
    }
    _disposed = true;
    SignalsObserver.instance?.onEffectRemoved(this);
  }

  bool _disposed = false;

  /// Check if the effect is disposed
  bool get disposed => _disposed;

  /// Force an effect to be disposed
  set disposed(bool value) {
    if (_disposed == value) return;
    if (!_disposed && value) dispose();
    _disposed = value;
  }

  /// Add a cleanup function to be called when the signal is disposed
  ///
  /// ```dart
  /// final counter = signal(0);
  /// final effectCount = signal(0);
  ///
  /// final cleanup = counter.onDispose(() {
  ///  print('Counter has been disposed');
  /// });
  ///
  /// // Remove the cleanup function
  /// cleanup();
  /// ```
  EffectCleanup onDispose(void Function() cleanup) {
    _disposeCallbacks.add(cleanup);
    return () {
      _disposeCallbacks.remove(cleanup);
    };
  }
}

/// {@template effect}
/// The `effect` function is the last piece that makes everything reactive. When you access a signal inside its callback function, that signal and every dependency of said signal will be activated and subscribed to. In that regard it is very similar to [`computed(fn)`](/core/computed). By default all updates are lazy, so nothing will update until you access a signal inside `effect`.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final name = signal("Jane");
/// final surname = signal("Doe");
/// final fullName = computed(() => name.value + " " + surname.value);
///
/// // Logs: "Jane Doe"
/// effect(() => print(fullName.value));
///
/// // Updating one of its dependencies will automatically trigger
/// // the effect above, and will print "John Doe" to the console.
/// name.value = "John";
/// ```
///
/// You can destroy an effect and unsubscribe from all signals it was subscribed to, by calling the returned function.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final name = signal("Jane");
/// final surname = signal("Doe");
/// final fullName = computed(() => name.value + " " + surname.value);
///
/// // Logs: "Jane Doe"
/// final dispose = effect(() => print(fullName.value));
///
/// // Destroy effect and subscriptions
/// dispose();
///
/// // Update does nothing, because no one is subscribed anymore.
/// // Even the computed `fullName` signal won't change, because it knows
/// // that no one listens to it.
/// surname.value = "Doe 2";
/// ```
///
/// ## Cleanup Callback
///
/// You can also return a cleanup function from an effect. This function will be called when the effect is destroyed.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final s = signal(0);
///
/// final dispose = effect(() {
///   print(s.value);
///   return () => print('Effect destroyed');
/// });
///
/// // Destroy effect and subscriptions
/// dispose();
/// ```
///
/// ## On Dispose Callback
///
/// You can also pass a callback to `effect` that will be called when the effect is destroyed.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final s = signal(0);
///
/// final dispose = effect(() {
///   print(s.value);
/// }, onDispose: () => print('Effect destroyed'));
///
/// // Destroy effect and subscriptions
/// dispose();
/// ```
///
/// ## Warning About Cycles
///
/// Mutating a signal inside an effect will cause an infinite loop, because the effect will be triggered again. To prevent this, you can use [`untracked(fn)`](/core/untracked) to read a signal without subscribing to it.
///
/// ```dart
/// import 'dart:async';
///
/// import 'package:signals/signals.dart';
///
/// Future<void> main() async {
///   final completer = Completer<void>();
///   final age = signal(0);
///
///   effect(() {
///     print('You are ${age.value} years old');
///     age.value++; // <-- This will throw a cycle error
///   });
///
///   await completer.future;
/// }
/// ```
/// @link https://dartsignals.dev/core/effect
/// {@endtemplate}
EffectCleanup effect(
  EffectCallback fn, {
  EffectOptions? options,
  EffectCallback? onDispose,
}) {
  final instance = Effect(
    fn,
    options: options,
  );
  if (onDispose != null) {
    instance._disposeCallbacks.add(onDispose);
  }
  return instance.call();
}
