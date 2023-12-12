import 'dart:async';

import '../core/signals.dart';

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
@Deprecated('Use [AsyncSignal.fromStream] instead')
class StreamSignal<T> extends ReadonlySignal<T?> {
  /// Cancel the stream on error
  final bool? cancelOnError;

  /// If true then the future will be called immediately
  final bool fireImmediately;

  // Before first data is collected, state is in [_StreamState.loading]
  final Signal<(_StreamState, T?, Object?)> _state;

  /// Creates a [StreamSignal] that wraps a [Stream]
  /// Defining an `initial` value will skip the [_StreamState.loading]
  StreamSignal(
    this._compute, {
    this.cancelOnError,
    this.fireImmediately = false,
    this.debugLabel,
    T? initial,
  }) : _state = signal<(_StreamState, T?, Object?)>((
          initial != null ? _StreamState.value : _StreamState.loading,
          initial,
          null,
        )) {
    _stale = true;

    if (fireImmediately) _execute();
  }

  final Stream<T> Function() _compute;
  bool _stale = false;

  StreamSubscription<T>? _subscription;

  /// Resets the signal by calling the [Stream] again
  void reset() {
    cancel();
    _stale = true;
    _state.value = (_StreamState.loading, null, null);
    if (fireImmediately) _execute();
  }

  void reload() {
    cancel();
    _stale = true;
    final (_, val, err) = _state.value;
    _state.value = (_StreamState.reloading, val, err);
    if (fireImmediately) _execute();
  }

  void _execute() {
    if (!_stale) return;
    _stale = false;
    _subscription = _compute().listen(
      (data) {
        final (_, val, _) = _state.value;
        previousValue = val;
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
  T? previousValue;

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

  /// Returns true if the future signal has a value
  bool get hasValue => isSuccess || isReloading;

  /// Returns true if the future signal has an error
  bool get isError => _state.peek().$1 == _StreamState.error;

  /// Returns true if the future signal has an error
  bool get hasError => isError;

  /// Returns true if the future signal is loading
  bool get isLoading => _state.peek().$1 == _StreamState.loading;

  /// Returns true if the future signal is reloading
  bool get isReloading => _state.peek().$1 == _StreamState.reloading;

  /// Returns the value of the signal or throws an error if not a value
  /// This method uses peek() to get the value and will not subscribe to the
  /// signal.
  T get requireValue {
    final (state, val, err) = _state.peek();
    if (state == _StreamState.value) return val as T;
    throw err ?? {};
  }

  /// Returns the value of the signal or null if not a value
  E map<E>({
    required StreamSignalValueBuilder<E, T> value,
    required StreamSignalBuilder<E> loading,
    required StreamSignalErrorBuilder<E> error,
    StreamSignalValueBuilder<E, T>? reloading,
  }) {
    _execute();
    final (state, val, err) = _state.value;
    switch (state) {
      case _StreamState.value:
        return value(val as T);
      case _StreamState.reloading:
        if (reloading != null) return reloading(val as T);
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
    StreamSignalValueBuilder<E, T>? reloading,
    StreamSignalErrorBuilder<E>? error,
    required StreamSignalBuilder<E> orElse,
  }) {
    _execute();
    final (state, val, err) = _state.value;
    switch (state) {
      case _StreamState.reloading:
        if (reloading != null) return reloading(val as T);
        if (value != null) return value(val as T);
        break;
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
  T? get() => value;

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
  reloading,
}

/// Create a [StreamSignal] from a [Stream]
@Deprecated('Use [asyncSignalFromStream] instead')
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
