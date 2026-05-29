import 'dart:async';

import 'package:meta/meta.dart';

import '../core/signals.dart';
import '../mixins/event_sink.dart';
import 'state.dart';

/// {@template signal}
/// A highly powerful [Signal] specifically designed for manual, imperative asynchronous state management.
///
/// Unlike declarative reactive signals like [futureSignal] or [streamSignal] (which automatically wrap and listen
/// to an existing `Future` or `Stream`), `AsyncSignal<T>` gives you full manual/imperative control over pushing
/// async states ([AsyncState.loading], [AsyncState.data], and [AsyncState.error]) into the reactive graph.
///
/// This is the perfect state primitive for building custom repositories, handling manual user action triggers
/// (e.g., submitting a registration form, calling an API on button click), or bridging low-level callback-based APIs
/// into reactive states.
///
/// ### 1. Imperative State Mutations
/// You can update the state of the signal directly using specialized mutation helpers:
/// - `setLoading()` puts the signal into a clean `AsyncLoading` state.
/// - `setValue(T data)` pushes a new `AsyncData` state containing the data.
/// - `setError(Object error, [StackTrace? stackTrace])` transitions the signal to an `AsyncError` state.
///
/// ```dart
/// final authState = asyncSignal<User>(AsyncState.loading());
///
/// Future<void> login(String email, String password) async {
///   try {
///     authState.setLoading(); // Set UI to loading state
///     final user = await authApi.signIn(email, password);
///     authState.setValue(user); // Push success data
///   } catch (err, stack) {
///     authState.setError(err, stack); // Push error state
///   }
/// }
/// ```
///
/// ### 2. Awaiting Async Completion via `.future`
/// An outstanding capability of `AsyncSignal` is its built-in `.future` getter. Any part of your code can await
/// this future. It returns a standard `Future<T>` that resolves when the signal next receives a data value,
/// or throws if the signal next receives an error state.
///
/// ```dart
/// final loginSignal = asyncSignal<User>(AsyncState.loading());
///
/// // Task A: Start background operation
/// Future.delayed(Duration(seconds: 2), () {
///   loginSignal.setValue(User(name: 'Charlie'));
/// });
///
/// // Task B: Wait for the signal to resolve!
/// final user = await loginSignal.future; // Suspends execution until Task A completes!
/// print(user.name); // 'Charlie'
/// ```
///
/// ### 3. Rendering in Flutter using `Watch` and `AsyncState` Pattern matching
/// In your Flutter widgets, you can seamlessly watch the signal and use Dart's native pattern matching
/// on [AsyncState] to render different widgets corresponding to the current asynchronous lifecycle:
///
/// ```dart
/// Widget build(BuildContext context) {
///   final state = authState.watch(context);
///
///   return state.map(
///     data: (user) => HomeScreen(user: user),
///     error: (error, stackTrace) => ErrorWidget(error),
///     loading: () => const CircularProgressIndicator(),
///   );
/// }
/// ```
///
/// ### 4. Bridging callback/event-driven systems via `EventSink`
/// `AsyncSignal` implements Dart's standard [EventSink] interface. This allows it to act directly as an event sink
/// for streams, websockets, or callback listeners:
///
/// ```dart
/// final messageLog = asyncSignal<String>(AsyncState.loading());
/// final chatStream = webSocket.stream.map((event) => event.toString());
///
/// // Automatically push all incoming messages and errors from the stream into the signal:
/// chatStream.listen(
///   (msg) => messageLog.add(msg),
///   onError: (err) => messageLog.addError(err),
///   onDone: () => messageLog.close(),
/// );
/// ```
///
/// <Info>
///   Favor `AsyncSignal` when you need manual, callback-driven, or button-press-triggered state mutations.
///   For auto-triggering, declarative, or read-only asynchronous data dependencies (like pulling data when an ID changes),
///   favor [futureSignal] or [computedAsync] instead.
/// </Info>
///
/// @link https://dartsignals.dev/async/signal
/// {@endtemplate}
class AsyncSignal<T> extends Signal<AsyncState<T>>
    with EventSinkSignalMixin<T> {
  /// A [Signal] that stores value in [AsyncState]
  AsyncSignal(
    super.value, {
    super.options,
  }) : _initialValue = value;

  final AsyncState<T> _initialValue;
  bool _initialized = false;

  /// Internal Completer for values
  @internal
  Completer<T> completer = Completer<T>();

  /// The future of the signal completer
  Future<T> get future async {
    untracked(() => value);
    return completer.future;
  }

  /// Returns true if the signal is completed an error or data
  bool get isCompleted {
    value;
    return completer.isCompleted;
  }

  /// Set the error with optional stackTrace to [AsyncError]
  void setError(Object error, [StackTrace? stackTrace]) {
    batch(() {
      value = AsyncState.error(error, stackTrace);
      if (completer.isCompleted) completer = Completer<T>();
      completer.completeError(error, stackTrace);
      completer.future.then<void>((_) {}, onError: (_) {});
    });
  }

  /// Set the value to [AsyncData]
  void setValue(T value) {
    batch(() {
      this.value = AsyncState.data(value);
      if (completer.isCompleted) completer = Completer<T>();
      completer.complete(value);
    });
  }

  /// Set the loading state to [AsyncLoading]
  void setLoading([AsyncState<T>? state]) {
    batch(() {
      value = state ?? AsyncState.loading();
      completer = Completer<T>();
    });
  }

  /// Reset the signal to the initial value
  void reset([AsyncState<T>? value]) {
    batch(() {
      final val = value ?? _initialValue;
      this.value = val;
      _initialized = false;
      if (completer.isCompleted) completer = Completer<T>();
    });
  }

  /// Initialize the signal
  void init() async {
    if (_initialized) return;
    _initialized = true;
  }

  /// Reload the future
  Future<void> reload() async {
    value = switch (value) {
      AsyncData<T> data => AsyncDataReloading<T>(data.value),
      AsyncError<T> err => AsyncErrorReloading<T>(err.error, err.stackTrace),
      AsyncLoading<T>() => AsyncLoading<T>(),
    };
  }

  /// Refresh the future
  Future<void> refresh() async {
    value = switch (value) {
      AsyncData<T> data => AsyncDataRefreshing<T>(data.value),
      AsyncError<T> err => AsyncErrorRefreshing<T>(err.error, err.stackTrace),
      AsyncLoading<T>() => AsyncLoading<T>(),
    };
  }

  @override
  AsyncState<T> get value {
    init();
    return super.value;
  }

  /// Returns the value of the signal
  T get requireValue => super.value.requireValue;
}

/// Helper function to create an [AsyncSignal] initialized with an [AsyncState].
///
/// ### Example
/// ```dart
/// // Create an AsyncSignal initialized to a loading state
/// final counter = asyncSignal<int>(AsyncState.loading());
///
/// // Create an AsyncSignal initialized with initial data
/// final status = asyncSignal<String>(AsyncState.data('Active'));
/// ```
///
/// @link https://dartsignals.dev/async/signal
AsyncSignal<T> asyncSignal<T>(
  AsyncState<T> value, {
  AsyncSignalOptions<T>? options,
  @Deprecated('Use options: AsyncSignalOptions(name: ...) instead')
  String? debugLabel,
  @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
}) {
  return AsyncSignal<T>(
    value,
    options: options ??
        AsyncSignalOptions<T>(
          name: debugLabel,
          autoDispose: autoDispose ?? false,
        ),
  );
}

/// Configuration options for an [AsyncSignal].
class AsyncSignalOptions<T> extends SignalOptions<AsyncState<T>> {
  /// The initial value of the async signal.
  final T? initialValue;

  /// The list of dependencies to watch/listen to.
  final List<ReadonlySignal<dynamic>> dependencies;

  /// Optional function called when a stream completes.
  final void Function()? onDone;

  /// Whether to cancel the stream subscription on error.
  final bool? cancelOnError;

  /// Whether the execution is lazy.
  final bool lazy;

  /// Creates a new [AsyncSignalOptions] instance.
  const AsyncSignalOptions({
    this.initialValue,
    this.dependencies = const [],
    this.onDone,
    this.cancelOnError,
    this.lazy = true,
    super.name,
    super.autoDispose,
    super.watched,
    super.unwatched,
  });

  /// Creates a copy of this options with custom overrides.
  @override
  AsyncSignalOptions<T> copyWith({
    T? initialValue,
    List<ReadonlySignal<dynamic>>? dependencies,
    void Function()? onDone,
    bool? cancelOnError,
    bool? lazy,
    bool? autoDispose,
    String? name,
    void Function()? watched,
    void Function()? unwatched,
  }) {
    return AsyncSignalOptions<T>(
      initialValue: initialValue ?? this.initialValue,
      dependencies: dependencies ?? this.dependencies,
      onDone: onDone ?? this.onDone,
      cancelOnError: cancelOnError ?? this.cancelOnError,
      lazy: lazy ?? this.lazy,
      autoDispose: autoDispose ?? this.autoDispose,
      name: name ?? this.name,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AsyncSignalOptions<T>) return false;
    if (other.name != name ||
        other.autoDispose != autoDispose ||
        other.watched != watched ||
        other.unwatched != unwatched ||
        other.initialValue != initialValue ||
        other.onDone != onDone ||
        other.cancelOnError != cancelOnError ||
        other.lazy != lazy) {
      return false;
    }
    if (other.dependencies.length != dependencies.length) return false;
    for (var i = 0; i < dependencies.length; i++) {
      if (other.dependencies[i] != dependencies[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode {
    var depHash = 0;
    for (final dep in dependencies) {
      depHash = Object.hash(depHash, dep);
    }
    return Object.hash(
      name,
      autoDispose,
      watched,
      unwatched,
      initialValue,
      onDone,
      cancelOnError,
      lazy,
      depHash,
    );
  }
}
