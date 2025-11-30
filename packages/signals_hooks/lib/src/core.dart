import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_flutter/signals_core.dart';

import 'base.dart';

/// Subscribes to an existing signal and returns it.
///
/// This is useful when you have a signal that is created outside of the
/// widget tree and you want to listen to its changes.
///
/// ```dart
/// final counter = signal(0);
///
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final count = useExistingSignal(counter);
///     return Text('$count');
///   }
/// }
/// ```
S useExistingSignal<T, S extends ReadonlySignal<T>>(
  S value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the hook will be re-evaluated.
  List<Object?> keys = const <Object>[],
}) {
  return use(SignalHook<T, S>(value, keys: keys));
}

/// Subscribes to an existing signal and returns its value.
///
/// This is a convenience hook that is equivalent to `useExistingSignal(signal)()`.
///
/// ```dart
/// final counter = signal(0);
///
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final count = useSignalValue(counter);
///     return Text('$count');
///   }
/// }
/// ```
T useSignalValue<T, S extends ReadonlySignal<T>>(
  S value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the hook will be re-evaluated.
  List<Object?> keys = const <Object>[],
}) {
  return useExistingSignal(value, keys: keys)();
}

/// Creates a new signal and subscribes to it.
///
/// The signal is created only once and is preserved across widget rebuilds.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final counter = useSignal(0);
///     return Text('${counter.value}');
///   }
/// }
/// ```
Signal<T> useSignal<T>(
  T value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the signal will be re-created with the
  /// new initial value.
  List<Object?> keys = const <Object>[],
  SignalOptions<T>? options,
}) {
  final s = useMemoized(() => signal<T>(value, options: options), keys);
  return useExistingSignal(s, keys: keys);
}

/// Creates a new computed signal and subscribes to it.
///
/// The computed signal is created only once and is preserved across
/// widget rebuilds.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final counter = useSignal(0);
///     final doubleCounter = useComputed(() => counter.value * 2);
///     return Text('$doubleCounter');
///   }
/// }
/// ```
Computed<T> useComputed<T>(
  T Function() value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the computed signal will be re-created.
  List<Object?> keys = const <Object>[],
  SignalOptions<T>? options,
}) {
  final s = useMemoized(() => computed<T>(value, options: options), keys);
  return useExistingSignal(s, keys: keys);
}

/// Creates a new effect and subscribes to it.
///
/// The effect is created only once and is preserved across widget rebuilds.
/// The effect is automatically disposed when the widget is disposed.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final counter = useSignal(0);
///     useSignalEffect(() {
///       print('Counter changed: ${counter.value}');
///     });
///     return TextButton(
///       onPressed: () => counter.value++,
///       child: Text('${counter.value}'),
///     );
///   }
/// }
/// ```
void useSignalEffect(
  dynamic Function() cb, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the effect will be re-created.
  List<Object?> keys = const <Object>[],

  /// A callback that is executed when the effect is disposed.
  dynamic Function()? onDispose,
  EffectOptions? options,
}) {
  useEffect(
    () => effect(cb, onDispose: onDispose, options: options),
    keys,
  );
  return;
}
