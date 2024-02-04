import 'dart:async';

import '../core/signals.dart';
import 'state.dart';

/// A [Signal] that stores value in [AsyncState]
class AsyncSignal<T> extends ValueSignal<AsyncState<T>> {
  AsyncSignal(
    super.value, {
    super.debugLabel,
    super.equality,
    super.autoDispose,
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

  /// Reload the future
  Future<void> reload() async {
    value = switch (value) {
      AsyncData<T> data => AsyncLoading<T>(
          value: data.value,
          hasValue: true,
          isLoading: false,
        ),
      AsyncError<T> err => AsyncLoading<T>(
          error: (err.error, err.stackTrace),
          hasError: true,
          isLoading: false,
        ),
      AsyncLoading<T>() => AsyncLoading<T>(),
    };
  }

  /// Refresh the future
  Future<void> refresh() async {
    value = switch (value) {
      AsyncData<T> data => AsyncData<T>(
          data.value,
          isLoading: true,
        ),
      AsyncError<T> err => AsyncError<T>(
          err.error,
          err.stackTrace,
          isLoading: true,
        ),
      AsyncLoading<T>() => AsyncLoading<T>(),
    };
  }

  @override
  AsyncState<T> get value {
    init();
    return super.value;
  }

  T get requireValue => super.value.requireValue;
}

/// A [Signal] that stores value in [AsyncState]
AsyncSignal<T> asyncSignal<T>(
  AsyncState<T> value, {
  String? debugLabel,
  SignalEquality<AsyncState<T>>? equality,
  bool autoDispose = false,
}) {
  return AsyncSignal<T>(
    value,
    debugLabel: debugLabel,
    equality: equality,
    autoDispose: autoDispose,
  );
}
