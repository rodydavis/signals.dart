import 'dart:async';

import 'package:meta/meta.dart';

import '../core/signals.dart';
import '../mixins/event_sink.dart';
import 'state.dart';

/// {@template signal}
/// `AsyncState` is class commonly used with Future/Stream signals to represent the states the signal can be in.
///
/// ## AsyncSignal
///
/// `AsyncState` is the default state if you want to create a `AsyncSignal` directly:
///
/// ```dart
/// final s = asyncSignal(AsyncState.data(1));
/// s.value = AsyncState.loading(); // or AsyncLoading();
/// s.value = AsyncState.error('Error', null); // or AsyncError();
/// ```
///
/// ## AsyncState
///
/// `AsyncState` is a sealed union made up of `AsyncLoading`, `AsyncData` and `AsyncError`.
///
/// ### .future
///
/// Sometimes you need to await a signal value in a async function until a value is completed and in this case use the .future getter.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// s.value = AsyncState.data(1);
/// await s.future; // Waits until data or error is set
/// ```
///
/// ### .isCompleted
///
/// Returns true if the future has completed with an error or value:
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// s.value = AsyncState.data(1);
/// print(s.isCompleted); // true
/// ```
///
/// ### .hasValue
///
/// Returns true if a value has been set regardless of the state.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// print(s.hasValue); // false
/// s.value = AsyncState.data(1);
/// print(s.hasValue); // true
/// ```
///
/// ### .hasError
///
/// Returns true if a error has been set regardless of the state.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// print(s.hasError); // false
/// s.value = AsyncState.error('error', null);
/// print(s.hasError); // true
/// ```
///
/// ### .isRefreshing
///
/// Returns true if the state is refreshing with a loading flag, has a value or error and is not the loading state.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// print(s.isRefreshing); // false
/// s.value = AsyncState.error('error', null, isLoading: true);
/// print(s.isRefreshing); // true
/// s.value = AsyncData(1, isLoading: true);
/// print(s.isRefreshing); // true
/// ```
///
/// ### .isReloading
///
/// Returns true if the state is reloading with having a value or error, and is the loading state.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// print(s.isReloading); // false
/// s.value = AsyncState.loading(data: 1);
/// print(s.isReloading); // true
/// s.value = AsyncState.loading(error: ('error', null));
/// print(s.isReloading); // true
/// ```
///
/// ### .requireValue
///
/// Force unwrap the value of the state and throw an error if it has an error or is null.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.data(1));
/// print(s.requireValue); // 1
/// ```
///
/// ### .value
///
/// Return the current value if exists.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.data(1));
/// print(s.value); // 1 or null
/// ```
///
/// ### .error
///
/// Return the current error if exists.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.error('error', null));
/// print(s.error); // 'error' or null
/// ```
///
/// ### .stackTrace
///
/// Return the current stack trace if exists.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.error('error', StackTrace(...)));
/// print(s.stackTrace); // StackTrace(...) or null
/// ```
///
/// ### .map
///
/// If you want to handle the states of the signal `map` will enforce all branching.
///
/// ```dart
/// final signal = asyncSignal<int>(AsyncState.data(1));
/// signal.value.map(
///  data: (value) => 'Value: $value',
///  error: (error, stackTrace) => 'Error: $error',
///  loading: () => 'Loading...',
/// );
/// ```
///
/// ### .maybeMap
///
/// If you want to handle some of the states of the signal `maybeMap` will provide a default and optional overrides.
///
/// ```dart
/// final signal = asyncSignal<int>(AsyncState.data(1));
/// signal.value.maybeMap(
///  data: (value) => 'Value: $value',
///  orElse: () => 'Loading...',
/// );
/// ```
///
/// ### Pattern Matching
///
/// Instead of `map` and `maybeMap` it is also possible to use [dart switch expressions](https://dart.dev/language/patterns) to handle the branching.
///
/// ```dart
/// final signal = asyncSignal<int>(AsyncState.data(1));
/// final value = switch (signal.value) {
///     AsyncData<int> data => 'value: ${data.value}',
///     AsyncError<int> error => 'error: ${error.error}',
///     AsyncLoading<int>() => 'loading',
/// };
/// ```
/// @link https://dartsignals.dev/async/state
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
  Completer<bool> completer = Completer<bool>();

  /// The future of the signal completer
  Future<T> get future async {
    untracked(() => value);
    await completer.future;
    return super.value.requireValue;
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
      if (completer.isCompleted) completer = Completer<bool>();
      completer.complete(true);
    });
  }

  /// Set the value to [AsyncData]
  void setValue(T value) {
    batch(() {
      this.value = AsyncState.data(value);
      if (completer.isCompleted) completer = Completer<bool>();
      completer.complete(true);
    });
  }

  /// Set the loading state to [AsyncLoading]
  void setLoading([AsyncState<T>? state]) {
    batch(() {
      value = state ?? AsyncState.loading();
      completer = Completer<bool>();
    });
  }

  /// Reset the signal to the initial value
  void reset([AsyncState<T>? value]) {
    batch(() {
      this.value = value ?? _initialValue;
      _initialized = false;
      if (completer.isCompleted) completer = Completer<bool>();
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

/// {@template signal}
/// `AsyncState` is class commonly used with Future/Stream signals to represent the states the signal can be in.
///
/// ## AsyncSignal
///
/// `AsyncState` is the default state if you want to create a `AsyncSignal` directly:
///
/// ```dart
/// final s = asyncSignal(AsyncState.data(1));
/// s.value = AsyncState.loading(); // or AsyncLoading();
/// s.value = AsyncState.error('Error', null); // or AsyncError();
/// ```
///
/// ## AsyncState
///
/// `AsyncState` is a sealed union made up of `AsyncLoading`, `AsyncData` and `AsyncError`.
///
/// ### .future
///
/// Sometimes you need to await a signal value in a async function until a value is completed and in this case use the .future getter.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// s.value = AsyncState.data(1);
/// await s.future; // Waits until data or error is set
/// ```
///
/// ### .isCompleted
///
/// Returns true if the future has completed with an error or value:
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// s.value = AsyncState.data(1);
/// print(s.isCompleted); // true
/// ```
///
/// ### .hasValue
///
/// Returns true if a value has been set regardless of the state.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// print(s.hasValue); // false
/// s.value = AsyncState.data(1);
/// print(s.hasValue); // true
/// ```
///
/// ### .hasError
///
/// Returns true if a error has been set regardless of the state.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// print(s.hasError); // false
/// s.value = AsyncState.error('error', null);
/// print(s.hasError); // true
/// ```
///
/// ### .isRefreshing
///
/// Returns true if the state is refreshing with a loading flag, has a value or error and is not the loading state.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// print(s.isRefreshing); // false
/// s.value = AsyncState.error('error', null, isLoading: true);
/// print(s.isRefreshing); // true
/// s.value = AsyncData(1, isLoading: true);
/// print(s.isRefreshing); // true
/// ```
///
/// ### .isReloading
///
/// Returns true if the state is reloading with having a value or error, and is the loading state.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.loading());
/// print(s.isReloading); // false
/// s.value = AsyncState.loading(data: 1);
/// print(s.isReloading); // true
/// s.value = AsyncState.loading(error: ('error', null));
/// print(s.isReloading); // true
/// ```
///
/// ### .requireValue
///
/// Force unwrap the value of the state and throw an error if it has an error or is null.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.data(1));
/// print(s.requireValue); // 1
/// ```
///
/// ### .value
///
/// Return the current value if exists.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.data(1));
/// print(s.value); // 1 or null
/// ```
///
/// ### .error
///
/// Return the current error if exists.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.error('error', null));
/// print(s.error); // 'error' or null
/// ```
///
/// ### .stackTrace
///
/// Return the current stack trace if exists.
///
/// ```dart
/// final s = asyncSignal<int>(AsyncState.error('error', StackTrace(...)));
/// print(s.stackTrace); // StackTrace(...) or null
/// ```
///
/// ### .map
///
/// If you want to handle the states of the signal `map` will enforce all branching.
///
/// ```dart
/// final signal = asyncSignal<int>(AsyncState.data(1));
/// signal.value.map(
///  data: (value) => 'Value: $value',
///  error: (error, stackTrace) => 'Error: $error',
///  loading: () => 'Loading...',
/// );
/// ```
///
/// ### .maybeMap
///
/// If you want to handle some of the states of the signal `maybeMap` will provide a default and optional overrides.
///
/// ```dart
/// final signal = asyncSignal<int>(AsyncState.data(1));
/// signal.value.maybeMap(
///  data: (value) => 'Value: $value',
///  orElse: () => 'Loading...',
/// );
/// ```
///
/// ### Pattern Matching
///
/// Instead of `map` and `maybeMap` it is also possible to use [dart switch expressions](https://dart.dev/language/patterns) to handle the branching.
///
/// ```dart
/// final signal = asyncSignal<int>(AsyncState.data(1));
/// final value = switch (signal.value) {
///     AsyncData<int> data => 'value: ${data.value}',
///     AsyncError<int> error => 'error: ${error.error}',
///     AsyncLoading<int>() => 'loading',
/// };
/// ```
/// @link https://dartsignals.dev/async/state
/// {@endtemplate}
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
