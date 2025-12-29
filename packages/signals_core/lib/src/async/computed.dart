import '../core/signals.dart';
import 'future.dart';

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
///
/// If async signals need to be tracked across an async gap and they are being awaited via their `.future`,
/// then use their `.completion` for the dependencies rather than the async signal itself.
/// This way the `computedFrom` will be reset when the tracked signal completes, effectively ignoring their transition into a loading state.
///
/// ```dart
/// final count = asyncSignal(AsyncData(0));
///
/// final s = computedFrom([count.completion], (_) async => await count.future);
///
/// await s.future; // 0
/// count.value = AsyncLoading(); // ignored by the computedFrom
/// count.value = AsyncData(1);
/// await s.future; // 1
/// ```
FutureSignal<T> computedFrom<T, A>(
  List<ReadonlySignal<A>> signals,
  Future<T> Function(List<A> args) fn, {
  T? initialValue,
  String? debugLabel,
  bool autoDispose = false,
  bool lazy = true,
}) {
  return FutureSignal<T>(
    () => fn(signals.map((e) => e()).toList()),
    dependencies: signals,
    initialValue: initialValue,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
    lazy: lazy,
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
  String? debugLabel,
  bool autoDispose = false,
  List<ReadonlySignal<dynamic>> dependencies = const [],
  bool lazy = true,
}) {
  return FutureSignal<T>(
    fn,
    dependencies: dependencies,
    initialValue: initialValue,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
    lazy: lazy,
  );
}
