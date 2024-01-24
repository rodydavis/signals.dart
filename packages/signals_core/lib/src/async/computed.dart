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
}) {
  return FutureSignal<T>(
    future: () => callback(signals.map((e) => e()).toList()),
    fireImmediately: true,
    dependencies: signals,
    initialValue: initialValue,
    debugLabel: debugLabel,
    equality: equality,
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
}) {
  return FutureSignal<T>(
    future: callback,
    fireImmediately: true,
    dependencies: [computed(callback)],
    initialValue: initialValue,
    debugLabel: debugLabel,
    equality: equality,
  );
}
