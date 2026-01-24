import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_core.dart';

import 'core.dart';

/// Creates a new [FutureSignal] and subscribes to it.
///
/// The signal is created only once and is preserved across widget rebuilds.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final future = useFutureSignal(() => Future.delayed(const Duration(seconds: 1), () => 1));
///     return future.value.map(
///       data: (value) => Text('$value'),
///       error: (error, stack) => Text('$error'),
///       loading: () => const CircularProgressIndicator(),
///     );
///   }
/// }
/// ```
FutureSignal<T> useFutureSignal<T>(
  Future<T> Function() value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the signal will be re-created with the
  /// new initial value.
  List<Object?> keys = const <Object>[],

  /// The initial value of the signal.
  T? initialValue,

  /// A list of signals to watch for changes.
  List<ReadonlySignal<dynamic>> dependencies = const [],

  /// If true, the future will not be executed until the signal is read.
  bool lazy = true,

  /// The debug label for the signal.
  String? debugLabel,
}) {
  final s = useMemoized(
    () {
      return futureSignal(
        value,
        initialValue: initialValue,
        dependencies: dependencies,
        lazy: lazy,
        debugLabel: debugLabel,
      );
    },
    keys,
  );
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [StreamSignal] and subscribes to it.
///
/// The signal is created only once and is preserved across widget rebuilds.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final stream = useStreamSignal(() => Stream.periodic(const Duration(seconds: 1), (i) => i));
///     return stream.value.map(
///       data: (value) => Text('$value'),
///       error: (error, stack) => Text('$error'),
///       loading: () => const CircularProgressIndicator(),
///     );
///   }
/// }
/// ```
StreamSignal<T> useStreamSignal<T>(
  Stream<T> Function() value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the signal will be re-created with the
  /// new initial value.
  List<Object?> keys = const <Object>[],

  /// The initial value of the signal.
  T? initialValue,

  /// A callback to execute when the stream is done.
  void Function()? onDone,

  /// If true, the stream will be canceled on error.
  bool? cancelOnError,

  /// If true, the stream will not be subscribed to until the signal is read.
  bool lazy = true,

  /// A list of signals to watch for changes.
  List<ReadonlySignal<dynamic>> dependencies = const [],

  /// The debug label for the signal.
  String? debugLabel,
}) {
  final s = useMemoized(
    () {
      return streamSignal(
        value,
        onDone: onDone,
        initialValue: initialValue,
        cancelOnError: cancelOnError,
        lazy: lazy,
        dependencies: dependencies,
        debugLabel: debugLabel,
      );
    },
    keys,
  );
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [AsyncSignal] and subscribes to it.
///
/// The signal is created only once and is preserved across widget rebuilds.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final signal = useAsyncSignal<int>(AsyncState.loading());
///     return signal.value.map(
///       data: (value) => Text('$value'),
///       error: (error, stack) => Text('$error'),
///       loading: () => const CircularProgressIndicator(),
///     );
///   }
/// }
/// ```
AsyncSignal<T> useAsyncSignal<T>(
  AsyncState<T> value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the signal will be re-created with the
  /// new initial value.
  List<Object?> keys = const <Object>[],

  /// The debug label for the signal.
  String? debugLabel,
}) {
  final s = useMemoized(() => asyncSignal(value, debugLabel: debugLabel), keys);
  return useExistingSignal(s, keys: keys);
}

/// Creates a new [FutureSignal] from a computed async value and subscribes to it.
///
/// The signal is created only once and is preserved across widget rebuilds.
///
/// ```dart
/// class MyWidget extends HookWidget {
///   @override
///   Widget build(BuildContext context) {
///     final count = useSignal(0);
///     final future = useAsyncComputed(() async {
///       await Future.delayed(const Duration(seconds: 1));
///       return count.value * 2;
///     }, dependencies: [count]);
///     return future.value.map(
///       data: (value) => Text('$value'),
///       error: (error, stack) => Text('$error'),
///       loading: () => const CircularProgressIndicator(),
///     );
///   }
/// }
/// ```
FutureSignal<T> useAsyncComputed<T>(
  Future<T> Function() value, {
  /// A list of objects to watch for changes.
  ///
  /// If any of the keys change, the signal will be re-created with the
  /// new initial value.
  List<Object?> keys = const <Object>[],

  /// A list of signals to watch for changes.
  List<ReadonlySignal<dynamic>> dependencies = const [],

  /// If true, the future will not be executed until the signal is read.
  bool lazy = true,

  /// The initial value of the signal.
  T? initialValue,

  /// The debug label for the signal.
  String? debugLabel,
}) {
  final s = useMemoized(
    () {
      return computedAsync(
        value,
        dependencies: dependencies,
        lazy: lazy,
        initialValue: initialValue,
        debugLabel: debugLabel,
      );
    },
    keys,
  );
  return useExistingSignal(s, keys: keys);
}
