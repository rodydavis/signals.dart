import 'package:preact_signals/preact_signals.dart';

/// A [Signal] that wraps a [Future]
///
/// The [FutureSignal] will return [SignalState] for the value. To react to
/// the various states you can use a switch statement:
///
/// ```dart
/// final s = FutureSignal(...);
/// final result = (switch(s.value) {
///   SignalValue result => print('value: ${result.value}'),
///   SignalTimeout _ => print('timeout error'),
///   SignalError result => print('error: ${result.error}'),
///   SignalLoading _ => print('loading'),
/// });
/// ```
class FutureSignal<T> extends Signal<T?> {
  /// Future [Duration] to wait before timing out
  final Duration? timeout;

  /// If true then the future will be called immediately
  final bool fireImmediately;

  /// Creates a [FutureSignal] that wraps a [Future]
  FutureSignal(
    this._getFuture, {
    this.timeout,
    this.fireImmediately = false,
  }) : super(null) {
    _stale = true;
    if (fireImmediately) _execute();
  }

  final Future<T> Function() _getFuture;
  bool _stale = false;
  Object? _error;
  var _state = _FutureState.loading;

  /// Resets the signal by calling the [Future] again
  void reset() {
    _stale = true;
    _state = _FutureState.loading;
    if (fireImmediately) _execute();
  }

  Future<T> _future() {
    if (timeout != null) {
      return _getFuture().timeout(timeout!, onTimeout: () {
        throw FutureSignalTimeoutException();
      });
    } else {
      return _getFuture();
    }
  }

  void _execute() async {
    if (!_stale) return;
    _stale = false;
    try {
      value = await _future();
      _state = _FutureState.value;
    } catch (e) {
      value = null;
      if (e is FutureSignalTimeoutException) {
        _error = null;
        _state = _FutureState.timeout;
      } else {
        _error = e;
        _state = _FutureState.error;
      }
    }
  }

  @override
  T? get value {
    _execute();
    return super.value;
  }

  /// Returns the error of the signal if present
  Object? get error {
    _execute();
    return _error;
  }

  /// Returns true if the future signal is done loading
  bool get isSuccess => _state == _FutureState.value;

  /// Returns true if the future signal has an error
  bool get isError => _state == _FutureState.error || isTimeout;

  /// Returns true if the future signal has timed out
  bool get isTimeout => _state == _FutureState.timeout;

  /// Returns true if the future signal has timed out
  bool get isLoading => _state == _FutureState.loading;

  /// Returns the value of the signal or null if not a value
  E when<E>(
    E Function(T value) value,
    E Function(Object? error) error,
    E Function() timeout,
    E Function() loading,
  ) {
    switch (_state) {
      case _FutureState.value:
        return value(this.value as T);
      case _FutureState.error:
        return error(_error);
      case _FutureState.timeout:
        return timeout();
      case _FutureState.loading:
        return loading();
    }
  }

  /// Returns the value of the signal or null if not a value
  E maybeWhen<E>(
    E Function(T value)? value,
    E Function(Object? error)? error,
    E Function()? timeout,
    E Function()? loading,
    E Function() orElse,
  ) {
    switch (_state) {
      case _FutureState.value:
        if (value != null) return value(this.value as T);
        break;
      case _FutureState.error:
        if (error != null) return error(_error);
        break;
      case _FutureState.timeout:
        if (timeout != null) return timeout();
        break;
      case _FutureState.loading:
        if (loading != null) return loading();
        break;
    }
    return orElse();
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
}) {
  return FutureSignal<T>(
    compute,
    timeout: timeout,
    fireImmediately: fireImmediately,
  );
}
