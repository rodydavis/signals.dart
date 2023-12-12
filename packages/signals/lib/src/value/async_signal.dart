import 'dart:async';

import '../core/signals.dart';

/// Builder on a successful [AsyncSignal] value
typedef AsyncSignalValueBuilder<R, T> = R Function(T value);

/// Builder on a [AsyncSignal] error
typedef AsyncSignalErrorBuilder<R> = R Function(Object? error);

/// Builder on a [AsyncSignal] callback
typedef AsyncSignalBuilder<R> = R Function();

/// A compound [Signal] that wraps a [Stream] or [Future]
class AsyncSignal<T> implements ReadonlySignal<T> {
  late final Signal<T> _result;
  final _init = signal(false);
  final _reload = signal(false);
  final _error = signal<Object?>(null);
  final _cleanup = <EffectCleanup>[];
  Completer<T> _completer = Completer<T>();
  Stream<T> Function()? _lastStream;
  bool? _lastCancelOnError;

  /// Future of the completer
  Future<T> get future => _completer.future;

  /// Returns true if the completer is done
  bool get isCompleted => _completer.isCompleted;

  @override
  final String? debugLabel;

  /// Creates a [AsyncSignal] that wraps a [Stream]
  AsyncSignal.fromStream(
    Stream<T> Function() stream, {
    required T initialValue,
    bool? cancelOnError,
    this.debugLabel,
  }) : _result = signal<T>(initialValue, debugLabel: debugLabel) {
    _stream(() => stream(), cancelOnError: cancelOnError);
  }

  /// Creates a [AsyncSignal] that wraps a [Future]
  AsyncSignal.fromFuture(
    Future<T> Function() future, {
    required T initialValue,
    this.debugLabel,
  }) : _result = signal<T>(initialValue, debugLabel: debugLabel) {
    _future(() => future());
  }

  void _stream(Stream<T> Function() stream, {bool? cancelOnError}) {
    final dispose = effect(() {
      if (_init.value) return;
      _lastStream = stream;
      _lastCancelOnError = cancelOnError;
      final subscription = _lastStream!().listen(
        (val) {
          if (_completer.isCompleted) {
            _completer = Completer<T>();
          }
          _result.value = val;
          _reload.value = false;
          _completer.complete(val);
        },
        onError: (err, trace) {
          _error.value = err;
          if (_completer.isCompleted) {
            _completer = Completer<T>();
          }
          _completer.completeError(err, trace);
          _reload.value = false;
        },
        cancelOnError: cancelOnError,
      );
      _init.value = true;
      _cleanup.add(subscription.cancel);
    });
    _cleanup.add(dispose);
  }

  void _future(Future<T> Function() future) {
    _stream(() => future().asStream(), cancelOnError: true);
  }

  void resetFuture(Future<T> Function() future) {
    dispose();
    _init.value = false;
    _future(future);
  }

  void resetStream(
    Stream<T> Function() stream, {
    bool? cancelOnError,
  }) {
    dispose();
    _init.value = false;
    _stream(stream, cancelOnError: cancelOnError);
  }

  void dispose() {
    for (final cleanup in _cleanup) {
      cleanup();
    }
    _cleanup.clear();
    _completer = Completer<T>();
  }

  void refresh() {
    if (_lastStream != null) {
      dispose();
      resetStream(_lastStream!, cancelOnError: _lastCancelOnError);
    }
  }

  void reload() {
    refresh();
    _reload.value = true;
  }

  @override
  T get value => _result.value;

  Object? get error => _error.value;

  @override
  T call() => value;

  @override
  T get() => value;

  @override
  int get globalId => _result.globalId;

  @override
  T peek() => _result.peek();

  @override
  T get previousValue => _result.previousValue;

  @override
  T toJson() => value;

  @override
  String toString() => '$value';

  @override
  EffectCleanup subscribe(void Function(T value) fn) {
    return _result.subscribe(fn);
  }

  _AsyncState get _state {
    if (_reload.value) {
      return _AsyncState.reloading;
    }
    if (isCompleted && _error.value != null) {
      return _AsyncState.error;
    }
    if (isCompleted || _result.value != null) {
      return _AsyncState.value;
    }
    return _AsyncState.loading;
  }

  /// Returns the value of the signal or null if not a value
  E map<E>({
    required AsyncSignalValueBuilder<E, T> value,
    required AsyncSignalErrorBuilder<E> error,
    required AsyncSignalBuilder<E> loading,
    AsyncSignalValueBuilder<E, T>? reloading,
  }) {
    final val = _result.value;
    final err = _error.value;
    switch (_state) {
      case _AsyncState.value:
        return value(val);
      case _AsyncState.reloading:
        if (reloading != null) return reloading(val);
        return value(val);
      case _AsyncState.error:
        return error(err);
      case _AsyncState.loading:
        return loading();
    }
  }

  /// Returns the value of the signal or null if not a value
  E maybeMap<E>({
    AsyncSignalValueBuilder<E, T>? value,
    AsyncSignalErrorBuilder<E>? error,
    AsyncSignalBuilder<E>? loading,
    AsyncSignalValueBuilder<E, T>? reloading,
    required AsyncSignalBuilder<E> orElse,
  }) {
    final val = _result.value;
    final err = _error.value;
    switch (_state) {
      case _AsyncState.reloading:
        if (reloading != null) return reloading(val);
        if (value != null) return value(val);
        break;
      case _AsyncState.value:
        if (value != null) return value(val);
        break;
      case _AsyncState.error:
        if (error != null) return error(err);
        break;
      case _AsyncState.loading:
        if (loading != null) return loading();
        break;
    }
    return orElse();
  }
}

AsyncSignal<T> asyncSignalFromFuture<T>(
  Future<T> Function() future, {
  required T initialValue,
  String? debugLabel,
}) {
  return AsyncSignal.fromFuture(
    future,
    initialValue: initialValue,
    debugLabel: debugLabel,
  );
}

AsyncSignal<T> asyncSignalFromStream<T>(
  Stream<T> Function() stream, {
  required T initialValue,
  bool? cancelOnError,
  String? debugLabel,
}) {
  return AsyncSignal.fromStream(
    stream,
    initialValue: initialValue,
    cancelOnError: cancelOnError,
    debugLabel: debugLabel,
  );
}

enum _AsyncState {
  error,
  value,
  loading,
  reloading,
}
