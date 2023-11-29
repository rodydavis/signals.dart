import 'dart:async';

import 'signals.dart';

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
class FutureSignal<T> extends Signal<T?> {
  /// Future [Duration] to wait before timing out
  final Duration? timeout;

  /// If true then the future will be called immediately
  final bool fireImmediately;

  /// Creates a [FutureSignal] that wraps a [Future]
  FutureSignal(
    this._compute, {
    this.timeout,
    this.fireImmediately = false,
    super.debugLabel,
  }) : super(null) {
    _stale = true;
    if (fireImmediately) _execute().ignore();
  }

  final Future<T> Function() _compute;
  bool _stale = false;
  Object? _error;
  var _state = _FutureState.loading;

  /// Resets the signal by calling the [Future] again
  Future<void> reset() async {
    _stale = true;
    _state = _FutureState.loading;
    if (fireImmediately) await _execute();
  }

  Future<T> _future() {
    if (timeout != null) {
      return _compute().timeout(timeout!, onTimeout: () {
        throw FutureSignalTimeoutException();
      });
    } else {
      return _compute();
    }
  }

  Future<void> _execute() async {
    if (!_stale) return;
    _stale = false;
    try {
      final result = await _future();
      _state = _FutureState.value;
      value = result;
    } catch (e) {
      value = null;
      if (e is FutureSignalTimeoutException) {
        _state = _FutureState.timeout;
        _error = null;
      } else {
        _state = _FutureState.error;
        _error = e;
      }
    }
  }

  @override
  T? get value {
    _execute().ignore();
    return super.value;
  }

  /// Returns the error of the signal if present
  Object? get error {
    _execute().ignore();
    return _error;
  }

  /// Returns true if the future signal is done loading
  bool get isSuccess => _state == _FutureState.value;

  /// Returns true if the future signal has an error
  bool get isError => _state == _FutureState.error || isTimeout;

  /// Returns true if the future signal has timed out
  bool get isTimeout => _state == _FutureState.timeout;

  /// Returns true if the future signal is loading
  bool get isLoading => _state == _FutureState.loading;

  /// Returns the value of the signal or null if not a value
  E map<E>({
    required FutureSignalValueBuilder<E, T> value,
    required FutureSignalBuilder<E> loading,
    required FutureSignalErrorBuilder<E> error,
    FutureSignalBuilder<E>? timeout,
  }) {
    this.value;
    switch (_state) {
      case _FutureState.value:
        return value(peek() as T);
      case _FutureState.error:
        return error(_error);
      case _FutureState.timeout:
        if (timeout != null) return timeout();
        return error(null);
      case _FutureState.loading:
        return loading();
    }
  }

  /// Returns the value of the signal or null if not a value
  E maybeMap<E>({
    FutureSignalValueBuilder<E, T>? value,
    FutureSignalBuilder<E>? loading,
    FutureSignalErrorBuilder<E>? error,
    FutureSignalBuilder<E>? timeout,
    required FutureSignalBuilder<E> orElse,
  }) {
    this.value;
    switch (_state) {
      case _FutureState.value:
        if (value != null) return value(peek() as T);
        break;
      case _FutureState.error:
        if (error != null) return error(_error);
        break;
      case _FutureState.timeout:
        if (timeout != null) return timeout();
        if (error != null) return error(null);
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
    if (isError) {
      return (null, _error);
    } else {
      return (peek()!, null);
    }
  }
}

/// Timeout exception for a signal
class FutureSignalTimeoutException extends Error {}

enum _FutureState {
  timeout,
  error,
  value,
  loading,
}

/// Create a [FutureSignal] from a [Future]
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
