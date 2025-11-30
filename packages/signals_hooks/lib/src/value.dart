import 'dart:collection';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_core.dart';

import 'core.dart';

/// Creates a new [ListSignal] and subscribes to it.
///
/// The signal is created only once and is preserved across widget rebuilds.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final list = useListSignal([1, 2, 3]);
///     return Text('${list.value}');
///   }
/// }
/// ```
ListSignal<T> useListSignal<T>(
  List<T> value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the signal will be re-created with the
  /// new initial value.
  List<Object?> keys = const <Object>[],

  /// The options for the signal.
  SignalOptions<List<T>>? options,
}) {
  final s = useMemoized(
    () => listSignal(value, options: options),
    keys,
  );
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [SetSignal] and subscribes to it.
///
/// The signal is created only once and is preserved across widget rebuilds.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final set = useSetSignal({1, 2, 3});
///     return Text('${set.value}');
///   }
/// }
/// ```
SetSignal<T> useSetSignal<T>(
  Set<T> value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the signal will be re-created with the
  /// new initial value.
  List<Object?> keys = const <Object>[],

  /// The options for the signal.
  SignalOptions<Set<T>>? options,
}) {
  final s = useMemoized(
    () => setSignal(value, options: options),
    keys,
  );
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [IterableSignal] and subscribes to it.
///
/// The signal is created only once and is preserved across widget rebuilds.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final iter = useIterableSignal([1, 2, 3]);
///     return Text('${iter.value}');
///   }
/// }
/// ```
IterableSignal<T> useIterableSignal<T>(
  Iterable<T> value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the signal will be re-created with the
  /// new initial value.
  List<Object?> keys = const <Object>[],

  /// The options for the signal.
  SignalOptions<Iterable<T>>? options,
}) {
  final s = useMemoized(
    () => iterableSignal(
      value,
      options: options,
    ),
    keys,
  );
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [MapSignal] and subscribes to it.
///
/// The signal is created only once and is preserved across widget rebuilds.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final map = useMapSignal({'a': 1, 'b': 2});
///     return Text('${map.value}');
///   }
/// }
/// ```
MapSignal<K, V> useMapSignal<K, V>(
  Map<K, V> value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the signal will be re-created with the
  /// new initial value.
  List<Object?> keys = const <Object>[],

  /// The options for the signal.
  SignalOptions<Map<K, V>>? options,
}) {
  final s = useMemoized(
    () => mapSignal(value, options: options),
    keys,
  );
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [TrackedSignal] and subscribes to it.
///
/// The signal is created only once and is preserved across widget rebuilds.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final counter = useTrackedSignal(0);
///     return Text('${counter.value}');
///   }
/// }
/// ```
TrackedSignal<T> useTrackedSignal<T>(
  T value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the signal will be re-created with the
  /// new initial value.
  List<Object?> keys = const <Object>[],

  /// The options for the signal.
  SignalOptions<T>? options,
}) {
  final s = useMemoized(
    () => trackedSignal(value, options: options),
    keys,
  );
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [QueueSignal] and subscribes to it.
///
/// The signal is created only once and is preserved across widget rebuilds.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final queue = useQueueSignal(Queue.from([1, 2, 3]));
///     return Text('${queue.value}');
///   }
/// }
/// ```
QueueSignal<T> useQueueSignal<T>(
  Queue<T> value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the signal will be re-created with the
  /// new initial value.
  List<Object?> keys = const <Object>[],

  /// The options for the signal.
  SignalOptions<Queue<T>>? options,
}) {
  final s = useMemoized(
    () => queueSignal(value, options: options),
    keys,
  );
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [ChangeStackSignal] and subscribes to it.
///
/// The signal is created only once and is preserved across widget rebuilds.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final stack = useChangeStackSignal(0);
///     return Text('${stack.value}');
///   }
/// }
/// ```
ChangeStackSignal<T> useChangeStackSignal<T>(
  T value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the signal will be re-created with the
  /// new initial value.
  List<Object?> keys = const <Object>[],

  /// The options for the signal.
  ChangeStackSignalOptions<T>? options,
}) {
  final s = useMemoized(
    () => changeStack(
      value,
      options: options,
    ),
    keys,
  );
  return useExistingSignal(s, keys: keys);
}
