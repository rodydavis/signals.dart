import 'dart:async';

import '../core/signals.dart';
import 'signal.dart';
import 'state.dart';

/// {@template future}
/// Future signals wrap a standard asynchronous [Future] and bridge it into the reactive state framework, exposing its lifecycle and value as a reactive [AsyncState].
///
/// You can construct a future signal via the helper function [futureSignal] or by calling the `.toSignal()` extension method on any standard [Future].
///
/// ### 1. Basic Async Fetching
/// ```dart
/// final s = futureSignal(() async {
///   final data = await fetchUserData(123);
///   return data;
/// });
/// ```
///
/// Or via the extension:
/// ```dart
/// final s = fetchUserData(123).toSignal();
/// ```
///
/// ### 2. Consuming and Pattern Matching `AsyncState`
/// Reading `.value` on a [FutureSignal] returns an [AsyncState] object. You can safely pattern-match or map this state to reactively build your user interface or perform side-effects:
///
/// ```dart
/// effect(() {
///   s.value.map(
///     data: (user) => print('User fetched successfully: ${user.name}'),
///     error: (err, stack) => print('Failed to fetch user: $err'),
///     loading: () => print('Loading user...'),
///   );
/// });
/// ```
///
/// ### 3. Reset, Refresh, and Reload
/// - **`reset()`**: Reverts the signal back to its initial/loading state.
/// - **`refresh()`**: Triggers a new evaluation of the future while maintaining the current data in the meantime (sets `isLoading` to true but does not discard existing data/error).
/// - **`reload()`**: Discards current state, sets the signal to `AsyncLoading`, and executes a fresh evaluation of the future.
///
/// ```dart
/// final s = futureSignal(() => fetchConfig());
/// s.refresh(); // Triggers reload under the hood
/// ```
///
/// ### 4. Reactive Dependencies
/// Any reactive signals read *synchronously* inside the future callback are registered as dependencies. When they mutate, the future signal automatically invalidates and schedules a fresh fetch.
///
/// ```dart
/// final userId = signal(123);
/// final userProfile = futureSignal(() async {
///   // Subscribes to userId! Mutating userId automatically re-runs this future.
///   final currentId = userId.value;
///   return fetchUserProfile(currentId);
/// });
/// ```
///
/// <Info>
///   If you need to track dependencies across an asynchronous gap (i.e. reading a signal's value *after* an `await`), pass them explicitly in the `dependencies` list inside `AsyncSignalOptions` or the constructor to guarantee they are properly subscribed.
/// </Info>
/// {@endtemplate}
class FutureSignal<T> extends AsyncSignal<T> {
  /// {@template future}
  /// Future signals can be created by extension or method.
  ///
  /// ### futureSignal
  ///
  /// ```dart
  /// final s = futureSignal(() async => 1);
  /// ```
  ///
  /// ### toSignal()
  ///
  /// ```dart
  /// final s = Future(() => 1).toSignal();
  /// ```
  ///
  /// ## .value, .peek()
  ///
  /// Returns [`AsyncState<T>`](/dart/async/state) for the value and can handle the various states.
  ///
  /// The `value` getter returns the value of the future if it completed successfully.
  ///
  /// > .peek() can also be used to not subscribe in an effect
  ///
  /// ```dart
  /// final s = futureSignal(() => Future(() => 1));
  /// final value = s.value.value; // 1 or null
  /// ```
  ///
  /// ## .reset()
  ///
  /// The `reset` method resets the future to its initial state to recall on the next evaluation.
  ///
  /// ```dart
  /// final s = futureSignal(() => Future(() => 1));
  /// s.reset();
  /// ```
  ///
  /// ## .refresh()
  ///
  /// Refresh the future value by setting `isLoading` to true, but maintain the current state (AsyncData, AsyncLoading, AsyncError).
  ///
  /// ```dart
  /// final s = futureSignal(() => Future(() => 1));
  /// s.refresh();
  /// print(s.value.isLoading); // true
  /// ```
  ///
  /// ## .reload()
  ///
  /// Reload the future value by setting the state to `AsyncLoading` and pass in the value or error as data.
  ///
  /// ```dart
  /// final s = futureSignal(() => Future(() => 1));
  /// s.reload();
  /// print(s.value is AsyncLoading); // true
  /// ```
  ///
  /// ## Dependencies
  ///
  /// By default the callback will be called once and the future will be cached unless a signal is read in the callback.
  ///
  /// ```dart
  /// final count = signal(0);
  /// final s = futureSignal(() async => count.value);
  ///
  /// await s.future; // 0
  /// count.value = 1;
  /// await s.future; // 1
  /// ```
  ///
  /// If there are signals that need to be tracked across an async gap then use the `dependencies` when creating the `futureSignal` to [`reset`](#.reset()) every time any signal in the dependency array changes.
  ///
  /// ```dart
  /// final count = signal(0);
  /// final s = futureSignal(
  ///     () async => count.value,
  ///     dependencies: [count],
  /// );
  /// s.value; // state with count 0
  /// count.value = 1; // resets the future
  /// s.value; // state with count 1
  /// ```
  /// @link https://dartsignals.dev/async/future
  /// {@endtemplate}
  FutureSignal(
    Future<T> Function() fn, {
    AsyncSignalOptions<T>? options,
    @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead')
    T? initialValue,
    @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead')
    List<ReadonlySignal<dynamic>>? dependencies,
    @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead')
    bool? lazy,
    @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: AsyncSignalOptions(name: ...) instead')
    String? debugLabel,
  })  : dependencies = options?.dependencies ?? dependencies ?? const [],
        _computedFuture = computed(() => fn()),
        super(
          (options?.initialValue ?? initialValue) != null
              ? AsyncState.data((options?.initialValue ?? initialValue) as T)
              : AsyncState.loading(),
          options: options ??
              AsyncSignalOptions<T>(
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        ) {
    if (!(options?.lazy ?? lazy ?? true)) value;
  }

  /// List of dependencies to recompute the future
  final List<ReadonlySignal<dynamic>> dependencies;
  late final Computed<Future<T>> _computedFuture;
  Future<T>? _currentFuture;
  EffectCleanup? _cleanup;
  EffectCleanup? _depCleanup;

  @override
  void dispose() {
    super.dispose();
    _cleanup?.call();
    _depCleanup?.call();
  }

  void _executeFuture(Future<T> future) {
    if (_currentFuture == future) return;

    if (completer.isCompleted) {
      completer = Completer<T>();
    }

    _currentFuture = future;

    future.then((val) {
      if (_currentFuture == future) {
        setValue(val);
      }
    }).catchError((Object err, StackTrace stackTrace) {
      if (_currentFuture == future) {
        setError(err, stackTrace);
      }
    });
  }

  @override
  void reset([AsyncState<T>? value]) {
    super.reset(value);
    _currentFuture = null;
    _computedFuture.recompute();
  }

  @override
  void init() {
    super.init();
    _executeFuture(_computedFuture.value);
  }

  @override
  AsyncState<T> get value {
    _cleanup ??= _computedFuture.subscribe((future) {
      _executeFuture(future);
    });
    _depCleanup ??= _listenToDeps();
    return super.value;
  }

  EffectCleanup _listenToDeps() {
    return untracked(() {
      if (dependencies.isEmpty) return () {};
      final cleanups = <void Function()>[];
      for (final dep in dependencies) {
        if (dep is AsyncSignal) {
          AsyncState? prev;
          final cleanup = dep.subscribe((val) {
            final oldPrev = prev;
            prev = val;
            if (oldPrev == null) return;
            if (oldPrev.isLoading && !val.isLoading) {
              return;
            }
            if (oldPrev != val) {
              reset();
            }
          });
          cleanups.add(cleanup);
        } else {
          dynamic prev;
          final cleanup = dep.subscribe((val) {
            final oldPrev = prev;
            prev = val;
            if (oldPrev == null) return;
            if (oldPrev != val) {
              reset();
            }
          });
          cleanups.add(cleanup);
        }
      }
      return () {
        for (final c in cleanups) {
          c();
        }
      };
    });
  }

  @override
  Future<void> reload() async {
    await super.reload();
    _currentFuture = null;
    _computedFuture.recompute();
    await future;
  }

  @override
  Future<void> refresh() async {
    await super.refresh();
    _currentFuture = null;
    _computedFuture.recompute();
    await future;
  }
}

/// {@template future}
/// Future signals can be created by extension or method.
///
/// ### futureSignal
///
/// ```dart
/// final s = futureSignal(() async => 1);
/// ```
///
/// ### toSignal()
///
/// ```dart
/// final s = Future(() => 1).toSignal();
/// ```
///
/// ## .value, .peek()
///
/// Returns [`AsyncState<T>`](/dart/async/state) for the value and can handle the various states.
///
/// The `value` getter returns the value of the future if it completed successfully.
///
/// > .peek() can also be used to not subscribe in an effect
///
/// ```dart
/// final s = futureSignal(() => Future(() => 1));
/// final value = s.value.value; // 1 or null
/// ```
///
/// ## .reset()
///
/// The `reset` method resets the future to its initial state to recall on the next evaluation.
///
/// ```dart
/// final s = futureSignal(() => Future(() => 1));
/// s.reset();
/// ```
///
/// ## .refresh()
///
/// Refresh the future value by setting `isLoading` to true, but maintain the current state (AsyncData, AsyncLoading, AsyncError).
///
/// ```dart
/// final s = futureSignal(() => Future(() => 1));
/// s.refresh();
/// print(s.value.isLoading); // true
/// ```
///
/// ## .reload()
///
/// Reload the future value by setting the state to `AsyncLoading` and pass in the value or error as data.
///
/// ```dart
/// final s = futureSignal(() => Future(() => 1));
/// s.reload();
/// print(s.value is AsyncLoading); // true
/// ```
///
/// ## Dependencies
///
/// By default the callback will be called once and the future will be cached unless a signal is read in the callback.
///
/// ```dart
/// final count = signal(0);
/// final s = futureSignal(() async => count.value);
///
/// await s.future; // 0
/// count.value = 1;
/// await s.future; // 1
/// ```
///
/// If there are signals that need to be tracked across an async gap then use the `dependencies` when creating the `futureSignal` to [`reset`](#.reset()) every time any signal in the dependency array changes.
///
/// ```dart
/// final count = signal(0);
/// final s = futureSignal(
///     () async => count.value,
///     dependencies: [count],
/// );
/// s.value; // state with count 0
/// count.value = 1; // resets the future
/// s.value; // state with count 1
/// ```
/// @link https://dartsignals.dev/async/future
/// {@endtemplate}
FutureSignal<T> futureSignal<T>(
  Future<T> Function() fn, {
  AsyncSignalOptions<T>? options,
  @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead')
  T? initialValue,
  @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead')
  List<ReadonlySignal<dynamic>>? dependencies,
  @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy,
  @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: AsyncSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return FutureSignal(
    fn,
    options: (options ?? AsyncSignalOptions<T>()).copyWith(
      initialValue: initialValue,
      dependencies: dependencies,
      lazy: lazy,
      autoDispose: autoDispose,
      name: debugLabel,
    ),
  );
}
