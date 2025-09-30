import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'core.dart';

/// Creates a new [Signal] from a [ValueNotifier] and subscribes to it.
///
/// The signal is created only once and is preserved across widget rebuilds.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final notifier = useValueNotifier(0);
///     final signal = useValueNotifierToSignal(notifier);
///     return Text('${signal.value}');
///   }
/// }
/// ```
Signal<T> useValueNotifierToSignal<T>(
  ValueNotifier<T> value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the signal will be re-created with the
  /// new initial value.
  List<Object?> keys = const <Object>[],

  /// The debug label for the signal.
  String? debugLabel,
}) {
  final s = useMemoized(
      () => valueNotifierToSignal(value, debugLabel: debugLabel), keys);
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [ReadonlySignal] from a [ValueListenable] and subscribes to it.
///
/// The signal is created only once and is preserved across widget rebuilds.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final notifier = useValueNotifier(0);
///     final signal = useValueListenableToSignal(notifier);
///     return Text('${signal.value}');
///   }
/// }
/// ```
ReadonlySignal<T> useValueListenableToSignal<T>(
  ValueListenable<T> value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the signal will be re-created with the
  /// new initial value.
  List<Object?> keys = const <Object>[],

  /// The debug label for the signal.
  String? debugLabel,
}) {
  final s = useMemoized(
      () => valueListenableToSignal(value, debugLabel: debugLabel), keys);
  return useExistingSignal(s, keys: keys);
}
