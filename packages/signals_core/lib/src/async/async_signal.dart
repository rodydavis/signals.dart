import 'dart:async';

import '../core/signals.dart';
import 'async_state.dart';

/// Builder on a successful [AsyncSignal] value
typedef AsyncSignalValueBuilder<R, T> = R Function(T value);

/// Builder on a [AsyncSignal] error
typedef AsyncSignalErrorBuilder<R> = R Function(Object? error);

/// Builder on a [AsyncSignal] callback
typedef AsyncSignalBuilder<R> = R Function();

/// A compound [Signal] that wraps a [Stream] or [Future]
class AsyncSignal<T> extends ValueSignal<AsyncState<T>> {
  AsyncSignal(
    super.value, {
    super.debugLabel,
  }) : _initialValue = value;

  final AsyncState<T> _initialValue;
  bool _initialized = false;
  Completer<T> _completer = Completer<T>();

  /// The future of the signal completer
  Future<T> get future {
    value;
    return _completer.future;
  }

  /// Returns true if the signal is completed an error or data
  bool get isCompleted {
    value;
    return _completer.isCompleted;
  }

  void setError(Object error, [StackTrace? stackTrace]) {
    value = AsyncState.error(error, stackTrace);
    if (_completer.isCompleted) _completer = Completer<T>();
    _completer.completeError(error, stackTrace);
  }

  void setValue(T value) {
    this.value = AsyncState.data(value);
    if (_completer.isCompleted) _completer = Completer<T>();
    _completer.complete(value);
  }

  void setLoading([AsyncState<T>? state]) {
    value = state ?? AsyncState.loading();
    _completer = Completer<T>();
  }

  void reset() {
    value = _initialValue;
    _initialized = false;
    _completer = Completer<T>();
  }

  void init() async {
    if (_initialized) return;
    _initialized = true;
  }

  @override
  AsyncState<T> get value {
    init();
    return super.value;
  }

  T get requireValue => super.value.requireValue;
}
