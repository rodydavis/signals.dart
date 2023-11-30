import 'dart:async';

import 'signals.dart';

/// Builder on a successful [StreamSignal] value
typedef StreamSignalValueBuilder<R, T> = R Function(T value);

/// Builder on a [StreamSignal] error
typedef StreamSignalErrorBuilder<R> = R Function(Object? error);

/// Builder on a [StreamSignal] callback
typedef StreamSignalBuilder<R> = R Function();

/// A [Signal] that wraps a [Stream]
///
/// The [StreamSignal] will return [SignalState] for the value. To react to
/// the various states you can use a switch statement:
///
/// ```dart
/// final s = streamSignal(() async* {
///     yield 1;
///     yield 2;
///     yield 3;
/// });
/// final mapped = s.map(
///     value: (value) => 'value: $value',
///     error: (error) => 'error: $error',
///     loading: () => 'loading',
/// );
/// ```
class StreamSignal<T> implements ReadonlySignal<T?> {
  /// Cancel the stream on error
  final bool? cancelOnError;

  /// If true then the future will be called immediately
  final bool fireImmediately;

  /// Creates a [StreamSignal] that wraps a [Stream]
  StreamSignal(
    this._compute, {
    this.cancelOnError,
    this.fireImmediately = false,
    this.debugLabel,
  }) {
    _stale = true;
    if (fireImmediately) _execute();
  }

  final Stream<T> Function() _compute;
  bool _stale = false;
  final _state = signal<(_StreamState, T?, Object?)>((
    _StreamState.loading,
    null,
    null,
  ));
  StreamSubscription<T>? _subscription;

  /// Resets the signal by calling the [Stream] again
  void reset() {
    _subscription?.cancel();
    _stale = true;
    _state.value = (_StreamState.loading, null, null);
    if (fireImmediately) _execute();
  }

  void _execute() {
    if (!_stale) return;
    _stale = false;
    _subscription = _compute().listen(
      (data) {
        _state.value = (_StreamState.value, data, null);
      },
      onError: (data) {
        _state.value = (_StreamState.error, null, data);
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
    final (state, val, _) = _state.value;
    if (state == _StreamState.value) return val;
    return null;
  }

  /// Returns the error of the signal if present
  Object? get error {
    _execute();
    final (state, _, err) = _state.value;
    if (state == _StreamState.error) return err;
    return null;
  }

  /// Returns true if the future signal is done loading
  bool get isSuccess => _state.peek().$1 == _StreamState.value;

  /// Returns true if the future signal has an error
  bool get isError => _state.peek().$1 == _StreamState.error;

  /// Returns true if the future signal is loading
  bool get isLoading => _state.peek().$1 == _StreamState.loading;

  /// Returns the value of the signal or null if not a value
  E map<E>({
    required StreamSignalValueBuilder<E, T> value,
    required StreamSignalBuilder<E> loading,
    required StreamSignalErrorBuilder<E> error,
  }) {
    _execute();
    final (state, val, err) = _state.value;
    switch (state) {
      case _StreamState.value:
        return value(val as T);
      case _StreamState.error:
        return error(err);
      case _StreamState.loading:
        return loading();
    }
  }

  /// Returns the value of the signal or null if not a value
  E maybeMap<E>({
    StreamSignalValueBuilder<E, T>? value,
    StreamSignalBuilder<E>? loading,
    StreamSignalErrorBuilder<E>? error,
    required StreamSignalBuilder<E> orElse,
  }) {
    _execute();
    final (state, val, err) = _state.value;
    switch (state) {
      case _StreamState.value:
        if (value != null) return value(val as T);
        break;
      case _StreamState.error:
        if (error != null) return error(err);
        break;
      case _StreamState.loading:
        if (loading != null) return loading();
        break;
    }
    return orElse();
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

enum _StreamState {
  error,
  value,
  loading,
}

/// Create a [StreamSignal] from a [Stream]
StreamSignal<T> streamSignal<T>(
  Stream<T> Function() stream, {
  bool? cancelOnError,
  bool fireImmediately = false,
  String? debugLabel,
}) {
  return StreamSignal<T>(
    stream,
    cancelOnError: cancelOnError,
    fireImmediately: fireImmediately,
    debugLabel: debugLabel,
  );
}
