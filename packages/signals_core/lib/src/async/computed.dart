import '../core/signals.dart';
import 'future.dart';
import 'state.dart';

/// Async Computed is syntax sugar around [FutureSignal].
///
/// computedFrom takes a list of [signals] and a [callback] function to
/// compute the value of the signal every time one of the [signals] changes.
///
/// ```dart
/// final movieId = signal('id');
/// late final movie = computedFrom(args, ([movieId]) => fetchMovie(args.first));
/// ```
FutureSignal<T> computedFrom<T, A>(
  List<ReadonlySignal<A>> signals,
  Future<T> Function(List<A> args) callback, {
  T? initialValue,
  String? debugLabel,
  SignalEquality<AsyncState<T>>? equality,
  bool autoDispose = false,
  bool lazy = true,
}) {
  return FutureSignal<T>(
    () => callback(signals.map((e) => e()).toList()),
    dependencies: signals,
    initialValue: initialValue,
    debugLabel: debugLabel,
    equality: equality,
    autoDispose: autoDispose,
    lazy: lazy,
  );
}

/// Async Computed is syntax sugar around [FutureSignal].
///
/// computedAsync takes a [callback] function to compute the value
/// of the signal. This callback is converted into a [Computed] signal.
///
/// ```dart
/// final movieId = signal('id');
/// late final movie = computedAsync(() => fetchMovie(movieId()));
/// ```
///
/// It is important that signals are called before any async gaps with await.
FutureSignal<T> computedAsync<T>(
  Future<T> Function() callback, {
  T? initialValue,
  String? debugLabel,
  SignalEquality<AsyncState<T>>? equality,
  bool autoDispose = false,
  List<ReadonlySignal<dynamic>> dependencies = const [],
  bool lazy = true,
}) {
  return FutureSignal<T>(
    callback,
    dependencies: dependencies,
    initialValue: initialValue,
    debugLabel: debugLabel,
    equality: equality,
    autoDispose: autoDispose,
    lazy: lazy,
  );
}
