import 'dart:async';

import '../core/signals.dart';
import 'signal.dart';
import 'state.dart';

/// {@template stream}
/// Stream signals wrap a standard asynchronous [Stream] and bridge it into the reactive state framework, exposing its emissions as a reactive [AsyncState].
///
/// You can construct a stream signal via the helper function [streamSignal] or by calling the `.toSignal()` extension method on any standard [Stream].
///
/// ### 1. Basic Stream Binding
/// ```dart
/// final s = streamSignal(() => countStream());
/// ```
///
/// Or via the extension:
/// ```dart
/// final s = countStream().toSignal();
/// ```
///
/// ### 2. Consuming stream emissions reactively
/// Reading `.value` on a [StreamSignal] returns an [AsyncState] object:
///
/// ```dart
/// effect(() {
///   s.value.map(
///     data: (val) => print('Stream emitted: $val'),
///     error: (err, stack) => print('Stream encountered error: $err'),
///     loading: () => print('Waiting for first stream emission...'),
///   );
/// });
/// ```
///
/// ### 3. Subscription Lifecycle and Manual Control
/// A stream signal automatically manages the underlying [StreamSubscription]. It listens when the signal has active subscribers and automatically cleans up/cancels when disposed to prevent memory leaks.
///
/// You can also manually control the subscription state:
/// - **`pause()`**: Pauses the underlying stream subscription.
/// - **`resume()`**: Resumes a paused subscription.
/// - **`cancel()`**: Cancels the subscription and marks the stream signal as done.
/// - **`isDone`**: Returns whether the stream has finished emitting or has been cancelled.
///
/// ```dart
/// final s = streamSignal(() => countStream());
/// s.pause(); // Temporarily halt stream values
/// ```
///
/// ### 4. Reactive Dependencies
/// Any reactive signals read synchronously inside the stream callback act as dependencies. When they mutate, the stream signal automatically cancels the current stream subscription, recreates a new stream using the updated values, and starts listening.
///
/// ```dart
/// final query = signal('flutter');
/// final s = streamSignal(() {
///   // Re-subscribes to a new database query stream every time the query changes!
///   return db.watchItems(query.value);
/// });
/// ```
/// {@endtemplate}
class StreamSignal<T> extends AsyncSignal<T> {
  /// {@template stream}
  /// Stream signals can be created by extension or method.
  ///
  /// ### streamSignal
  ///
  /// ```dart
  /// final stream = () async* {
  ///     yield 1;
  /// };
  /// final s = streamSignal(() => stream);
  /// ```
  ///
  /// ### toSignal()
  ///
  /// ```dart
  /// final stream = () async* {
  ///     yield 1;
  /// };
  /// final s = stream.toSignal();
  /// ```
  ///
  /// ## .value, .peek()
  ///
  /// Returns [`AsyncState<T>`](/dart/async/state) for the value and can handle the various states.
  ///
  /// The `value` getter returns the value of the stream if it completed successfully.
  ///
  /// > .peek() can also be used to not subscribe in an effect
  ///
  /// ```dart
  /// final stream = (int value) async* {
  ///     yield value;
  /// };
  /// final s = streamSignal(() => stream);
  /// final value = s.value.value; // 1 or null
  /// ```
  ///
  /// ## .reset()
  ///
  /// The `reset` method resets the stream to its initial state to recall on the next evaluation.
  ///
  /// ```dart
  /// final stream = (int value) async* {
  ///     yield value;
  /// };
  /// final s = streamSignal(() => stream);
  /// s.reset();
  /// ```
  ///
  /// ## .refresh()
  ///
  /// Refresh the stream value by setting `isLoading` to true, but maintain the current state (AsyncData, AsyncLoading, AsyncError).
  ///
  /// ```dart
  /// final stream = (int value) async* {
  ///     yield value;
  /// };
  /// final s = streamSignal(() => stream);
  /// s.refresh();
  /// print(s.value.isLoading); // true
  /// ```
  ///
  /// ## .reload()
  ///
  /// Reload the stream value by setting the state to `AsyncLoading` and pass in the value or error as data.
  ///
  /// ```dart
  /// final stream = (int value) async* {
  ///     yield value;
  /// };
  /// final s = streamSignal(() => stream);
  /// s.reload();
  /// print(s.value is AsyncLoading); // true
  /// ```
  ///
  /// ## Dependencies
  ///
  /// By default the callback will be called once and the stream will be cached unless a signal is read in the callback.
  ///
  /// ```dart
  /// final count = signal(0);
  /// final s = streamSignal(() async* {
  ///     final value = count();
  ///     yield value;
  /// });
  ///
  /// await s.future; // 0
  /// count.value = 1;
  /// await s.future; // 1
  /// ```
  ///
  /// If there are signals that need to be tracked across an async gap then use the `dependencies` when creating the `streamSignal` to [`reset`](#.reset()) every time any signal in the dependency array changes.
  ///
  /// ```dart
  /// final count = signal(0);
  /// final s = streamSignal(
  ///     () async* {
  ///         final value = count();
  ///         yield value;
  ///     },
  ///     dependencies: [count],
  /// );
  /// s.value; // state with count 0
  /// count.value = 1; // resets the future
  /// s.value; // state with count 1
  /// ```
  /// @link https://dartsignals.dev/async/stream
  /// {@endtemplate}
  StreamSignal(
    Stream<T> Function() fn, {
    AsyncSignalOptions<T>? options,
    @Deprecated('Use options: AsyncSignalOptions(cancelOnError: ...) instead')
    bool? cancelOnError,
    @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead')
    T? initialValue,
    @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead')
    List<ReadonlySignal<dynamic>>? dependencies,
    @Deprecated('Use options: AsyncSignalOptions(onDone: ...) instead')
    void Function()? onDone,
    @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead')
    bool? lazy,
    @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: AsyncSignalOptions(name: ...) instead')
    String? debugLabel,
  })  : _onDone = options?.onDone ?? onDone,
        cancelOnError = options?.cancelOnError ?? cancelOnError,
        dependencies = options?.dependencies ?? dependencies ?? const [],
        _stream = computed(
          () => fn(),
        ),
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

  final Computed<Stream<T>> _stream;
  bool _fetching = false;
  StreamSubscription<T>? _subscription;
  final void Function()? _onDone;
  bool _done = false;
  EffectCleanup? _cleanup;
  EffectCleanup? _depCleanup;

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
              execute(_stream.value);
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
              execute(_stream.value);
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

  /// Check if the signal is done
  bool get isDone => _done;

  /// Cancel the subscription on error
  late final bool? cancelOnError;

  /// List of dependencies to recompute the stream
  late final List<ReadonlySignal<dynamic>> dependencies;

  /// First value of the stream
  Future<T> get last => _stream.value.last;

  /// Last value of the stream
  Future<T> get first => _stream.value.first;

  /// Execute the stream
  Future<void> execute(Stream<T> src) async {
    if (_done || _fetching) return;
    _fetching = true;
    _subscription = src.listen(
      setValue,
      onError: setError,
      onDone: _finish,
      cancelOnError: cancelOnError,
    );
  }

  Future<void> _finish() async {
    _done = true;
    _onDone?.call();
    await _subscription?.cancel();
    _subscription = null;
    _fetching = false;
  }

  /// Check if the subscription is paused
  bool get isPaused => _subscription?.isPaused ?? false;

  /// Pause the subscription
  void pause([Future<void>? resume]) {
    _subscription?.pause(resume);
    set(value, force: true);
  }

  /// Resume the subscription
  void resume() {
    _subscription?.resume();
    set(value, force: true);
  }

  /// Cancel the subscription
  Future<void> cancel() async {
    await _finish();
  }

  @override
  Future<void> reload() async {
    super.reload();
    _stream.recompute();
    _fetching = false;
    _done = false;
    _subscription?.cancel();
    _subscription = null;
    await execute(_stream.value);
  }

  @override
  Future<void> refresh() async {
    super.refresh();
    _stream.recompute();
    _fetching = false;
    _done = false;
    _subscription?.cancel();
    _subscription = null;
    await execute(_stream.value);
  }

  @override
  void reset([AsyncState<T>? value]) {
    super.reset(value);
    _fetching = false;
    _done = false;
    _subscription?.cancel();
    _subscription = null;
    init();
  }

  @override
  void dispose() {
    super.dispose();
    _cleanup?.call();
    _depCleanup?.call();
    _subscription?.cancel();
  }

  @override
  AsyncState<T> get value {
    _cleanup ??= _stream.subscribe((src) {
      reset();
      execute(src);
    });
    _depCleanup ??= _listenToDeps();
    return super.value;
  }

  @override
  void setError(Object error, [StackTrace? stackTrace]) {
    super.setError(error, stackTrace);
    if (cancelOnError == true) {
      _finish();
    }
  }
}

/// {@template stream}
/// Stream signals can be created by extension or method.
///
/// ### streamSignal
///
/// ```dart
/// final stream = () async* {
///     yield 1;
/// };
/// final s = streamSignal(() => stream);
/// ```
///
/// ### toSignal()
///
/// ```dart
/// final stream = () async* {
///     yield 1;
/// };
/// final s = stream.toSignal();
/// ```
///
/// ## .value, .peek()
///
/// Returns [`AsyncState<T>`](/dart/async/state) for the value and can handle the various states.
///
/// The `value` getter returns the value of the stream if it completed successfully.
///
/// > .peek() can also be used to not subscribe in an effect
///
/// ```dart
/// final stream = (int value) async* {
///     yield value;
/// };
/// final s = streamSignal(() => stream);
/// final value = s.value.value; // 1 or null
/// ```
///
/// ## .reset()
///
/// The `reset` method resets the stream to its initial state to recall on the next evaluation.
///
/// ```dart
/// final stream = (int value) async* {
///     yield value;
/// };
/// final s = streamSignal(() => stream);
/// s.reset();
/// ```
///
/// ## .refresh()
///
/// Refresh the stream value by setting `isLoading` to true, but maintain the current state (AsyncData, AsyncLoading, AsyncError).
///
/// ```dart
/// final stream = (int value) async* {
///     yield value;
/// };
/// final s = streamSignal(() => stream);
/// s.refresh();
/// print(s.value.isLoading); // true
/// ```
///
/// ## .reload()
///
/// Reload the stream value by setting the state to `AsyncLoading` and pass in the value or error as data.
///
/// ```dart
/// final stream = (int value) async* {
///     yield value;
/// };
/// final s = streamSignal(() => stream);
/// s.reload();
/// print(s.value is AsyncLoading); // true
/// ```
///
/// ## Dependencies
///
/// By default the callback will be called once and the stream will be cached unless a signal is read in the callback.
///
/// ```dart
/// final count = signal(0);
/// final s = streamSignal(() async* {
///     final value = count();
///     yield value;
/// });
///
/// await s.future; // 0
/// count.value = 1;
/// await s.future; // 1
/// ```
///
/// If there are signals that need to be tracked across an async gap then use the `dependencies` when creating the `streamSignal` to [`reset`](#.reset()) every time any signal in the dependency array changes.
///
/// ```dart
/// final count = signal(0);
/// final s = streamSignal(
///     () async* {
///         final value = count();
///         yield value;
///     },
///     dependencies: [count],
/// );
/// s.value; // state with count 0
/// count.value = 1; // resets the future
/// s.value; // state with count 1
/// ```
/// @link https://dartsignals.dev/async/stream
/// {@endtemplate}
StreamSignal<T> streamSignal<T>(
  Stream<T> Function() callback, {
  AsyncSignalOptions<T>? options,
  @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead')
  T? initialValue,
  @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead')
  List<ReadonlySignal<dynamic>>? dependencies,
  @Deprecated('Use options: AsyncSignalOptions(onDone: ...) instead')
  void Function()? onDone,
  @Deprecated('Use options: AsyncSignalOptions(cancelOnError: ...) instead')
  bool? cancelOnError,
  @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy,
  @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: AsyncSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return StreamSignal(
    callback,
    options: (options ?? AsyncSignalOptions<T>()).copyWith(
      initialValue: initialValue,
      dependencies: dependencies,
      onDone: onDone,
      cancelOnError: cancelOnError,
      lazy: lazy,
      autoDispose: autoDispose,
      name: debugLabel,
    ),
  );
}
