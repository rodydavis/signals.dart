import 'dart:async';

import '../core/signals.dart';
import 'async_signal_state.dart';

/// Builder on a successful [AsyncSignal] value
typedef AsyncSignalValueBuilder<R, T> = R Function(T value);

/// Builder on a [AsyncSignal] error
typedef AsyncSignalErrorBuilder<R> = R Function(Object? error);

/// Builder on a [AsyncSignal] callback
typedef AsyncSignalBuilder<R> = R Function();

/// A compound [Signal] that wraps a [Stream] or [Future]
class AsyncSignal<T> extends ValueSignal<AsyncSignalState<T>> {
  AsyncSignal(
    super.value, {
    super.debugLabel,
  }) : _initialValue = value;

  final AsyncSignalState<T> _initialValue;
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
    value = AsyncSignalState.error((error, stackTrace));
    if (_completer.isCompleted) _completer = Completer<T>();
    _completer.completeError(error, stackTrace);
  }

  void setValue(T value) {
    this.value = AsyncSignalState.data(value);
    if (_completer.isCompleted) _completer = Completer<T>();
    _completer.complete(value);
  }

  void setLoading({bool refresh = false}) {
    if (refresh) {
      value = switch (value) {
        AsyncSignalStateData<T> data => data.toLoading(),
        AsyncSignalStateError<T> err => err.toLoading(),
        AsyncSignalStateLoading<T>() => AsyncSignalStateLoading<T>(),
      };
    } else {
      value = AsyncSignalState.loading();
    }
    _completer = Completer<T>();
  }

  void reset() {
    value = _initialValue;
    _initialized = false;
  }

  void init() async {
    if (_initialized) return;
    _initialized = true;
  }

  void dispose() {}

  @override
  AsyncSignalState<T> get value {
    init();
    return super.value;
  }

  T get requireValue {
    return super.value.requireValue;
  }
}
