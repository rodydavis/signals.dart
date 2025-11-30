import '../core/signals.dart';
import 'future.dart';
import 'state.dart';

/// Async Computed is syntax sugar around [FutureSignal].
///
/// _Inspired by [computedFrom](https://ngxtension.netlify.app/utilities/signals/computed-from/) from Angular NgExtension._
///
/// computedFrom takes a list of [signals] and a [callback] function to
/// compute the value of the signal every time one of the [signals] changes.
///
/// ```dart
/// final movieId = signal('id');
/// late final movie = computedFrom(args, ([movieId]) => fetchMovie(args.first));
/// ```
///
/// Since all dependencies are passed in as arguments there is no need to worry about calling the signals before any async gaps with await.
FutureSignal<T> computedFrom<T, A>(
  List<ReadonlySignal<A>> signals,
  Future<T> Function(List<A> args) fn, {
  T? initialValue,
  bool lazy = true,
  SignalOptions<AsyncState<T>>? options,
}) {
  return FutureSignal<T>(
    () => fn(signals.map((e) => e()).toList()),
    initialValue: initialValue,
    lazy: lazy,
    options: options,
  );
}

/// Async Computed is syntax sugar around [FutureSignal].
///
/// _Inspired by [computedAsync](https://ngxtension.netlify.app/utilities/signals/computed-async/) from Angular NgExtension._
///
/// computedAsync takes a [callback] function to compute the value
/// of the signal. This callback is converted into a [Computed] signal.
///
/// ```dart
/// final movieId = signal('id');
/// late final movie = computedAsync(() => fetchMovie(movieId()));
/// ```
///
/// **It is important that signals are called before any async gaps with await.**
///
/// Any signal that is read inside the callback will be tracked as a dependency and the computed signal will be re-evaluated when any of the dependencies change.
FutureSignal<T> computedAsync<T>(
  Future<T> Function() fn, {
  T? initialValue,
  List<ReadonlySignal<dynamic>> dependencies = const [],
  bool lazy = true,
  SignalOptions<AsyncState<T>>? options,
}) {
  return FutureSignal<T>(
    fn,
    initialValue: initialValue,
    dependencies: dependencies,
    lazy: lazy,
    options: options,
  );
}
