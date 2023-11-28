import 'dart:async';

import 'package:preact_signals/preact_signals.dart';

/// A [Signal] that wraps a [Stream]
///
/// The [StreamSignal] will return [SignalState] for the value. To react to
/// the various states you can use a switch statement:
///
/// ```dart
/// final s = StreamSignal(...);
/// final result = (switch(s.value) {
///   SignalValue result => print('value: ${result.value}'),
///   SignalTimeout _ => print('timeout error'),
///   SignalError result => print('error: ${result.error}'),
///   SignalLoading _ => print('loading'),
/// });
/// ```
class StreamSignal<T> extends Signal<T?> {
  /// Cancel the stream on error
  final bool? cancelOnError;

  /// If true then the future will be called immediately
  final bool fireImmediately;

  /// Creates a [StreamSignal] that wraps a [Stream]
  StreamSignal(
    this._getStream, {
    this.cancelOnError,
    this.fireImmediately = true,
  }) : super(null) {
    _stale = true;
    if (fireImmediately) _execute();
  }

  final Stream<T> Function() _getStream;
  bool _stale = false;
  Object? _error;
  var _state = _StreamState.loading;
  StreamSubscription<T>? _subscription;

  /// Resets the signal by calling the [Stream] again
  void reset() {
    _subscription?.cancel();
    _stale = true;
    _state = _StreamState.loading;
    if (fireImmediately) _execute();
  }

  Stream<void> _execute() async* {
    if (!_stale) return;
    _stale = false;
    _subscription = _getStream().listen(
      (data) {
        value = data;
        _state = _StreamState.value;
      },
      onError: (data) {
        _error = data;
        _state = _StreamState.error;
      },
      cancelOnError: cancelOnError,
    );
  }

  /// Cancel the stream subscription
  void cancel() {
    _subscription?.cancel();
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
  bool get isSuccess => _state == _StreamState.value;

  /// Returns true if the future signal has an error
  bool get isError => _state == _StreamState.error;

  /// Returns true if the future signal has timed out
  bool get isLoading => _state == _StreamState.loading;

  /// Returns the value of the signal or null if not a value
  E when<E>(
    E Function(T value) value,
    E Function(Object? error) error,
    E Function() loading,
  ) {
    switch (_state) {
      case _StreamState.value:
        return value(this.value as T);
      case _StreamState.error:
        return error(_error);
      case _StreamState.loading:
        return loading();
    }
  }

  /// Returns the value of the signal or null if not a value
  E maybeWhen<E>(
    E Function(T value)? value,
    E Function(Object? error)? error,
    E Function()? loading,
    E Function() orElse,
  ) {
    switch (_state) {
      case _StreamState.value:
        if (value != null) return value(this.value as T);
        break;
      case _StreamState.error:
        if (error != null) return error(_error);
        break;
      case _StreamState.loading:
        if (loading != null) return loading();
        break;
    }
    return orElse();
  }
}

enum _StreamState {
  error,
  value,
  loading,
}

/// Create a [StreamSignal] from a [Stream]
StreamSignal<T> streamSignal<T>(
  Stream<T> Function() stream, {
  bool? cancelOnError,
  bool fireImmediately = true,
}) {
  return StreamSignal<T>(
    stream,
    cancelOnError: cancelOnError,
    fireImmediately: fireImmediately,
  );
}
