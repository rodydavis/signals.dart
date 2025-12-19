import 'dart:async';

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
    super.debugLabel,
    super.autoDispose,
  })  : _initialValue = value,
        _completion = _AsyncCompletionSignal<T>(
          initialValue: value,
          debugLabel: debugLabel != null ? '${debugLabel}_completion' : null,
        );

  @override
  void dispose() {
    _completion.dispose();
    super.dispose();
  }

  final AsyncState<T> _initialValue;
  bool _initialized = false;

  final _AsyncCompletionSignal<T> _completion;

  /// Tracks the async completion of this signal.
  ///
  /// Notifies if the value of this signal changes to [AsyncData] or [AsyncError],
  /// but not if it changes to [AsyncLoading].
  ///
  /// Intended to be used for tracking dependencies across async gaps,
  /// when awaiting the [future] of this signal.
  ///
  /// ```dart
  /// computedFrom([someAsyncSignal.completion], (_) async {
  ///   await Future.delayed(const Duration(seconds: 1));
  ///   return await someAsyncSignal.future;
  /// });
  /// ```
  ReadonlySignal<Future<T>> get completion => _completion;

  /// The future of the signal completer
  Future<T> get future => completion.value;

  /// Returns true if the signal is completed an error or data
  bool get isCompleted {
    future;
    return _completion.isCompleted;
  }

  @override
  bool set(AsyncState<T> val, {bool force = false}) {
    return batch(() {
      _completion.setValue(val);
      return super.set(val, force: force);
    });
  }

  /// Set the error with optional stackTrace to [AsyncError]
  void setError(Object error, [StackTrace? stackTrace]) {
    set(AsyncState.error(error, stackTrace));
  }

  /// Set the value to [AsyncData]
  void setValue(T value) {
    set(AsyncState.data(value));
  }

  /// Set the loading state to [AsyncLoading]
  void setLoading([AsyncState<T>? state]) {
    set(state ?? AsyncState.loading());
  }

  /// Reset the signal to the initial value
  void reset([AsyncState<T>? value]) {
    batch(() {
      super.value = value ?? _initialValue;
      _initialized = false;
      _completion.setValue(const AsyncLoading());
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
  String? debugLabel,
  bool autoDispose = false,
}) {
  return AsyncSignal<T>(
    value,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}

class _AsyncCompletionSignal<T> extends Signal<Future<T>> {
  _AsyncCompletionSignal._(
    Completer<T> completer, {
    required super.debugLabel,
  })  : _completer = completer,
        super(_ignoreUncaughtErrors(completer.future));

  factory _AsyncCompletionSignal({
    required AsyncState<T> initialValue,
    required String? debugLabel,
  }) {
    final completer = Completer<T>();

    switch (initialValue) {
      case AsyncLoading():
        break;

      case AsyncData(:final value):
        completer.complete(value);
        break;

      case AsyncError(:final error, :final stackTrace):
        completer.completeError(error, stackTrace);
        break;
    }

    return _AsyncCompletionSignal._(completer, debugLabel: debugLabel);
  }

  Completer<T> _completer;

  bool _initialized = false;
  bool get isCompleted => _initialized && _completer.isCompleted;

  void setValue(AsyncState<T> value) {
    if (_completer.isCompleted) {
      _completer = Completer<T>();
      this.value = _ignoreUncaughtErrors(_completer.future);
    }

    switch (value) {
      case AsyncLoading():
        return;

      case AsyncData(:final value):
        _initialized = true;
        _completer.complete(value);
        return;

      case AsyncError(:final error, :final stackTrace):
        _initialized = true;
        _completer.completeError(error, stackTrace);
        return;
    }
  }

  static Future<T> _ignoreUncaughtErrors<T>(Future<T> future) {
    // Makes sure the future never reports an uncaught error to
    // the current zone. Seems to be necessary to avoid uncaught
    // errors to be reported when async signals are being used
    // synchronously, i.e. when their .future is not used.
    future.ignore();
    return future;
  }
}
