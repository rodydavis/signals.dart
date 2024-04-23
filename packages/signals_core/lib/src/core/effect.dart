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
///
/// ## Flutter
///
/// In Flutter if you want to create an effect that automatically disposes itself when the widget is removed from the widget tree, you can use the `createEffect` inside a stateful widget.
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
///   late final counter = createSignal(this, 0);
///
///   @override
///   void initState() {
///     super.initState();
///     createEffect(this, () {
///       print('Counter: ${counter.value}');
///     });
///   }
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
/// The `SignalsAutoDisposeMixin` is a mixin that automatically disposes all signals created in the state when the widget is removed from the widget tree.
/// @link https://dartsignals.dev/core/effect
/// {@endtemplate}
class Effect implements SignalListenable {
  EffectCallback? _compute;

  @override
  final String? debugLabel;

  @override
  final int globalId;

  Function? _cleanup;

  @override
  _Node? _sources;

  Effect? _nextBatchedEffect;

  @override
  int _flags;

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
  ///
  /// ## Flutter
  ///
  /// In Flutter if you want to create an effect that automatically disposes itself when the widget is removed from the widget tree, you can use the `createEffect` inside a stateful widget.
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
  ///   late final counter = createSignal(this, 0);
  ///
  ///   @override
  ///   void initState() {
  ///     super.initState();
  ///     createEffect(this, () {
  ///       print('Counter: ${counter.value}');
  ///     });
  ///   }
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
  /// The `SignalsAutoDisposeMixin` is a mixin that automatically disposes all signals created in the state when the widget is removed from the widget tree.
  /// @link https://dartsignals.dev/core/effect
  /// {@endtemplate}
  Effect(
    EffectCallback compute, {
    this.debugLabel,
  })  : _flags = _TRACKING,
        _compute = compute,
        _cleanup = null,
        globalId = ++_lastGlobalId {
    assert(() {
      SignalsObserver.instance?.onEffectCreated(this);
      return true;
    }());
    try {
      _callback();
    } catch (e) {
      dispose();
      rethrow;
    }
  }

  /// @internal for testing getter to track all the signals currently
  /// subscribed in the effect
  Iterable<ReadonlySignal> get sources sync* {
    _Node? root = _sources;
    for (var node = root; node != null; node = node._nextSource) {
      yield node._source;
    }
  }

  void _callback() {
    final finish = _start();
    try {
      if ((_flags & _DISPOSED) != 0) return;
      if (_compute == null) return;
      _currentEffect = this;
      final cleanup = _compute!();
      _currentEffect = null;
      if (cleanup is Function) {
        _cleanup = cleanup;
      }
    } finally {
      finish();
    }
    assert(() {
      SignalsObserver.instance?.onEffectCalled(this);
      return true;
    }());
  }

  EffectCleanup _start() {
    if ((_flags & _RUNNING) != 0) {
      // coverage:ignore-start
      throw EffectCycleDetectionError();
      // coverage:ignore-end
    }
    _flags |= _RUNNING;
    _flags &= ~_DISPOSED;
    _cleanupEffect(this);
    _prepareSources(this);
    _startBatch();
    final prevContext = _evalContext;
    _evalContext = this;
    return () => _endEffect(this, prevContext);
  }

  @override
  void _notify() {
    if (!((_flags & _NOTIFIED) != 0)) {
      _flags |= _NOTIFIED;
      _nextBatchedEffect = _batchedEffect;
      _batchedEffect = this;
    }
  }

  void _dispose() {
    _flags |= _DISPOSED;
    if (!((_flags & _RUNNING) != 0)) {
      _disposeEffect(this);
    }
    assert(() {
      SignalsObserver.instance?.onEffectRemoved(this);
      return true;
    }());
  }

  @override
  void dispose() {
    if (_disposed) return;
    _dispose();
    for (final cleanup in _disposeCallbacks) {
      cleanup();
    }
    _disposed = true;
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
///
/// ## Flutter
///
/// In Flutter if you want to create an effect that automatically disposes itself when the widget is removed from the widget tree, you can use the `createEffect` inside a stateful widget.
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
///   late final counter = createSignal(this, 0);
///
///   @override
///   void initState() {
///     super.initState();
///     createEffect(this, () {
///       print('Counter: ${counter.value}');
///     });
///   }
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
/// The `SignalsAutoDisposeMixin` is a mixin that automatically disposes all signals created in the state when the widget is removed from the widget tree.
/// @link https://dartsignals.dev/core/effect
/// {@endtemplate}
EffectCleanup effect(
  EffectCallback compute, {
  String? debugLabel,
  EffectCallback? onDispose,
}) {
  final instance = Effect(
    compute,
    debugLabel: debugLabel,
  );
  if (onDispose != null) {
    instance._disposeCallbacks.add(onDispose);
  }
  // Return a bound function instead of a wrapper like `() => effect._dispose()`,
  // because bound functions seem to be just as fast and take up a lot less memory.
  return instance.dispose;
}
