import 'dart:async';

import '../core/signals.dart';

/// Builder on a successful [FutureSignal] value
typedef FutureSignalValueBuilder<R, T> = R Function(T value);

/// Builder on a [FutureSignal] error
typedef FutureSignalErrorBuilder<R> = R Function(Object? error);

/// Builder on a [FutureSignal] callback
typedef FutureSignalBuilder<R> = R Function();

/// A [Signal] that wraps a [Future]
///
/// The [FutureSignal] will return [SignalState] for the value. To react to
/// the various states you can use a switch statement:
///
/// ```dart
/// final s = futureSignal(Future(() => 1));
/// final mapped = s.map(
///     value: (value) => 'value: $value',
///     error: (error) => 'error: $error',
///     loading: () => 'loading',
///     timeout: () => 'timeout',
/// );
/// ```
@Deprecated('Use [AsyncSignal.fromFuture] instead')
class FutureSignal<T> implements ReadonlySignal<T?> {
  /// Future [Duration] to wait before timing out
  final Duration? timeout;

  /// If true then the future will be called immediately
  final bool fireImmediately;

  /// Creates a [FutureSignal] that wraps a [Future]
  FutureSignal(
    this._compute, {
    this.timeout,
    this.fireImmediately = false,
    this.debugLabel,
  }) {
    _stale = true;
    if (fireImmediately) _execute().ignore();
  }

  final _state = signal<(_FutureState, T?, Object?)>((
    _FutureState.loading,
    null,
    null,
  ));

  final Future<T> Function() _compute;
  bool _stale = false;

  /// Resets the signal by calling the [Future] again
  Future<void> reset() async {
    _stale = true;
    _state.value = (_FutureState.loading, null, null);
    if (fireImmediately) await _execute();
  }

  Future<void> reload() async {
    _stale = true;
    final (_, val, err) = _state.value;
    _state.value = (_FutureState.reloading, val, err);
    if (fireImmediately) await _execute();
  }

  Future<void> _execute() async {
    if (!_stale) return;
    _stale = false;
    try {
      T result;
      if (timeout != null) {
        result = await _compute().timeout(timeout!, onTimeout: () {
          throw FutureSignalTimeoutException();
        });
      } else {
        result = await _compute();
      }
      final (_, val, _) = _state.value;
      previousValue = val;
      _state.value = (_FutureState.value, result, null);
    } catch (e) {
      if (e is FutureSignalTimeoutException) {
        _state.value = (_FutureState.timeout, null, null);
      } else {
        _state.value = (_FutureState.error, null, e);
      }
    }
  }

  @override
  T? previousValue;

  @override
  T? get value {
    _execute().ignore();
    final (state, val, _) = _state.value;
    if (state == _FutureState.value || state == _FutureState.reloading) {
      return val;
    }
    return null;
  }

  /// Returns the error of the signal if present
  Object? get error {
    _execute().ignore();
    final (state, _, err) = _state.value;
    if (state == _FutureState.error || state == _FutureState.reloading) {
      return err;
    }
    return null;
  }

  /// Returns true if the future signal is done loading
  bool get isSuccess => _state.peek().$1 == _FutureState.value;

  /// Returns true if the future signal is done loading
  bool get hasValue => isSuccess || isReloading;

  /// Returns true if the future signal has an error
  bool get isError => _state.peek().$1 == _FutureState.error || isTimeout;

  /// Returns true if the future signal has an error
  bool get hasError => isError;

  /// Returns true if the future signal has timed out
  bool get isTimeout => _state.peek().$1 == _FutureState.timeout;

  /// Returns true if the future signal is loading
  bool get isLoading => _state.peek().$1 == _FutureState.loading;

  /// Returns true if the future signal is reloading
  bool get isReloading => _state.peek().$1 == _FutureState.reloading;

  @override
  T? get() => value;

  /// Returns the value of the signal or throws an error if not a value
  /// This method uses peek() to get the value and will not subscribe to the
  /// signal.
  T get requireValue {
    final (state, val, err) = _state.peek();
    if (state == _FutureState.value) return val as T;
    throw err ?? {};
  }

  /// Returns the value of the signal or null if not a value
  E map<E>({
    required FutureSignalValueBuilder<E, T> value,
    required FutureSignalBuilder<E> loading,
    required FutureSignalErrorBuilder<E> error,
    FutureSignalBuilder<E>? timeout,
    FutureSignalValueBuilder<E, T>? reloading,
  }) {
    _execute().ignore();
    final (state, val, err) = _state.value;
    switch (state) {
      case _FutureState.value:
        return value(val as T);
      case _FutureState.error:
        return error(err);
      case _FutureState.timeout:
        if (timeout != null) return timeout();
        return error(null);
      case _FutureState.reloading:
        if (reloading != null) return reloading(val as T);
        return value(val as T);
      case _FutureState.loading:
        return loading();
    }
  }

  /// Returns the value of the signal or null if not a value
  E maybeMap<E>({
    FutureSignalValueBuilder<E, T>? value,
    FutureSignalBuilder<E>? loading,
    FutureSignalValueBuilder<E, T>? reloading,
    FutureSignalErrorBuilder<E>? error,
    FutureSignalBuilder<E>? timeout,
    required FutureSignalBuilder<E> orElse,
  }) {
    _execute().ignore();
    final (state, val, err) = _state.value;
    switch (state) {
      case _FutureState.value:
        if (value != null) return value(val as T);
        break;
      case _FutureState.error:
        if (error != null) return error(err);
        break;
      case _FutureState.timeout:
        if (timeout != null) return timeout();
        if (error != null) return error(null);
        break;
      case _FutureState.reloading:
        if (reloading != null) return reloading(val as T);
        if (value != null) return value(val as T);
        break;
      case _FutureState.loading:
        if (loading != null) return loading();
        break;
    }
    return orElse();
  }

  /// Future result of the signal with value and error pair
  FutureOr<(T?, Object?)> get result async {
    await _execute();
    final (state, val, err) = _state.value;
    if (state == _FutureState.error) {
      return (null, err);
    } else {
      return (val, null);
    }
  }

  @override
  T? call() => value;

  @override
  final String? debugLabel;

  @override
  int get globalId => _state.globalId;

  @override
  T? peek() {
    final (_, value, _) = _state.peek();
    return value;
  }

  @override
  EffectCleanup subscribe(void Function(T? value) fn) {
    return _state.subscribe((event) {
      final (_, value, _) = event;
      fn(value);
    });
  }

  @override
  T? toJson() => value;
}

/// Timeout exception for a signal
class FutureSignalTimeoutException extends Error {}

enum _FutureState {
  timeout,
  error,
  value,
  loading,
  reloading,
}

/// Create a [FutureSignal] from a [Future]
@Deprecated('Use [asyncSignalFromFuture] instead')
FutureSignal<T> futureSignal<T>(
  Future<T> Function() compute, {
  Duration? timeout,
  bool fireImmediately = false,
  String? debugLabel,
}) {
  return FutureSignal<T>(
    compute,
    timeout: timeout,
    fireImmediately: fireImmediately,
    debugLabel: debugLabel,
  );
}
