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
/// late final movie = computedFrom([movieId], (args) => fetchMovie(args.first));
/// ```
///
/// Since all dependencies are passed in as arguments there is no need to worry about calling the signals before any async gaps with await.
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

/// [computedFrom] for a one element record.
FutureSignal<T> computedFrom1<T, A>(
  (ReadonlySignal<A>,) signals,
  Future<T> Function((A,) args) fn, {
  T? initialValue,
  String? debugLabel,
  bool autoDispose = false,
  bool lazy = true,
}) {
  return FutureSignal<T>(
    () => fn((signals.$1(),)),
    dependencies: [signals.$1],
    initialValue: initialValue,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
    lazy: lazy,
  );
}

/// [computedFrom] for a two element record.
FutureSignal<T> computedFrom2<T, A, B>(
  (ReadonlySignal<A>, ReadonlySignal<B>) signals,
  Future<T> Function(
          (
            A,
            B,
          ) args)
      fn, {
  T? initialValue,
  String? debugLabel,
  bool autoDispose = false,
  bool lazy = true,
}) {
  return FutureSignal<T>(
    () => fn((signals.$1(), signals.$2())),
    dependencies: [signals.$1, signals.$2],
    initialValue: initialValue,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
    lazy: lazy,
  );
}

/// [computedFrom] for a three element record.
FutureSignal<T> computedFrom3<T, A, B, C>(
  (ReadonlySignal<A>, ReadonlySignal<B>, ReadonlySignal<C>) signals,
  Future<T> Function(
          (
            A,
            B,
            C,
          ) args)
      fn, {
  T? initialValue,
  String? debugLabel,
  bool autoDispose = false,
  bool lazy = true,
}) {
  return FutureSignal<T>(
    () => fn((signals.$1(), signals.$2(), signals.$3())),
    dependencies: [signals.$1, signals.$2, signals.$3],
    initialValue: initialValue,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
    lazy: lazy,
  );
}

/// [computedFrom] for a four element record.
FutureSignal<T> computedFrom4<T, A, B, C, D>(
  (
    ReadonlySignal<A>,
    ReadonlySignal<B>,
    ReadonlySignal<C>,
    ReadonlySignal<D>
  ) signals,
  Future<T> Function(
          (
            A,
            B,
            C,
            D,
          ) args)
      fn, {
  T? initialValue,
  String? debugLabel,
  bool autoDispose = false,
  bool lazy = true,
}) {
  return FutureSignal<T>(
    () => fn((signals.$1(), signals.$2(), signals.$3(), signals.$4())),
    dependencies: [signals.$1, signals.$2, signals.$3, signals.$4],
    initialValue: initialValue,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
    lazy: lazy,
  );
}

/// [computedFrom] for a five element record.
FutureSignal<T> computedFrom5<T, A, B, C, D, E>(
  (
    ReadonlySignal<A>,
    ReadonlySignal<B>,
    ReadonlySignal<C>,
    ReadonlySignal<D>,
    ReadonlySignal<E>
  ) signals,
  Future<T> Function(
          (
            A,
            B,
            C,
            D,
            E,
          ) args)
      fn, {
  T? initialValue,
  String? debugLabel,
  bool autoDispose = false,
  bool lazy = true,
}) {
  return FutureSignal<T>(
    () => fn(
        (signals.$1(), signals.$2(), signals.$3(), signals.$4(), signals.$5())),
    dependencies: [signals.$1, signals.$2, signals.$3, signals.$4, signals.$5],
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
