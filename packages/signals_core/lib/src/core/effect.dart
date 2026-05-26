part of 'signals.dart';

/// Clean up function to stop subscriptions from updating the callback
typedef EffectCleanup = void Function();

/// Function called when signals in the callback change
typedef EffectCallback = Function();

/// {@template effect}
/// An `Effect` is the passive consumer of the reactive model. It allows you to run arbitrary side-effects (such as logging, database writes, or UI rendering updates) whenever any of its tracked dependencies mutate.
///
/// Any signal accessed via `.value` inside the effect callback is automatically registered as a dependency. When a dependency changes, the effect is re-run.
///
/// ### Core Example
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final counter = signal(0);
///
/// // Create an active effect: prints "Count: 0" immediately
/// final dispose = effect(() {
///   print('Count: ${counter.value}');
/// });
///
/// // Updating the signal re-runs the effect: prints "Count: 1"
/// counter.value = 1;
///
/// // Clean up the effect to unsubscribe from updates
/// dispose();
/// ```
///
/// ---
///
/// ## Key API Capabilities
///
/// ### 1. Lifecycle Cleanup Callback
/// You can return an optional `void Function()` from the effect callback block. This cleanup function is automatically invoked the next time the effect is re-run, or when the effect is permanently disposed. This is perfect for cancelling timers, sockets, or other active event channels.
///
/// ```dart
/// final counter = signal(0);
///
/// effect(() {
///   final count = counter.value;
///   final timer = Timer(Duration(seconds: 1), () => print('Timer fired for $count'));
///
///   // Cleanup function called before re-run or dispose
///   return () => timer.cancel();
/// });
/// ```
///
/// ### 2. Lifecycle Listeners via `onDispose`
/// You can attach explicit cleanup routines that run when the effect is destroyed by passing `onDispose` in the options or by calling `.onDispose(callback)` directly on the effect instance.
///
/// ```dart
/// final counter = signal(0);
/// final dispose = effect(
///   () => print(counter.value),
///   options: EffectOptions(
///     onDispose: () => print('Effect has been unmounted!'),
///   ),
/// );
///
/// dispose(); // Prints: "Effect has been unmounted!"
/// ```
///
/// ---
///
/// ## ⚠️ Warning: Preventing Cycles
/// Mutating a signal *directly* inside an effect that reads that same signal will cause an infinite loop (cycle), throwing a `StackOverflowError` or a cycle exception. To read a signal inside an effect without subscribing to its updates, wrap the read operation in `untracked()`.
///
/// ```dart
/// final a = signal(0);
/// final b = signal(0);
///
/// effect(() {
///   // Active subscription to a
///   final valA = a.value;
///
///   // Read b non-reactively using untracked to prevent circular subscriptions
///   final valB = untracked(() => b.value);
///
///   print('A: $valA, B: $valB');
/// });
/// ```
///
/// @link https://dartsignals.dev/core/effect
/// {@endtemplate}
class Effect extends signals.Effect {
  final _disposeCallbacks = <void Function()>{};

  /// Label used for debugging
  @Deprecated('Use name instead')
  String? get debugLabel => name;

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
    super.fn, {
    EffectOptions? options,
    @Deprecated('Use options: EffectOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: EffectOptions(name: ...) instead')
    String? debugLabel,
    @Deprecated('Use options: EffectOptions(onDispose: ...) instead')
    void Function()? onDispose,
  }) : super(
          name: options?.name ?? debugLabel,
          options: options ??
              EffectOptions(
                autoDispose: autoDispose ?? false,
                name: debugLabel,
                onDispose: onDispose,
              ),
        ) {
    if (options?.onDispose != null) {
      _disposeCallbacks.add(options!.onDispose!);
    } else if (onDispose != null) {
      _disposeCallbacks.add(onDispose);
    }
    if (kDebugMode) {
      SignalsObserver.instance?.onEffectCreated(this);
    }
  }

  @override
  void Function() call() {
    if (kDebugMode) {
      SignalsObserver.instance?.onEffectCalled(this);
    }
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
    if (kDebugMode) {
      SignalsObserver.instance?.onEffectRemoved(this);
    }
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
  @Deprecated('Use options: EffectOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: EffectOptions(name: ...) instead')
  String? debugLabel,
  @Deprecated('Use options: EffectOptions(onDispose: ...) instead')
  void Function()? onDispose,
}) {
  final instance = Effect(
    fn,
    options: options ??
        EffectOptions(
          autoDispose: autoDispose ?? false,
          name: debugLabel,
          onDispose: onDispose,
        ),
  );
  return instance.call();
}
