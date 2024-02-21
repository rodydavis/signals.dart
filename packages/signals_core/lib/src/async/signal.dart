import 'dart:async';

import '../core/signals.dart';
import 'state.dart';

/// A [Signal] that stores value in [AsyncState]
class AsyncSignal<T> extends ValueSignal<AsyncState<T>> {
  /// A [Signal] that stores value in [AsyncState]
  AsyncSignal(
    super.value, {
    super.debugLabel,
    super.equality,
    super.autoDispose,
  }) : _initialValue = value;
  final AsyncState<T> _initialValue;
  bool _initialized = false;
  Completer<bool> _completer = Completer<bool>();

  /// The future of the signal completer
  Future<T> get future async {
    value;
    await _completer.future;
    return value.requireValue;
  }

  /// Returns true if the signal is completed an error or data
  bool get isCompleted {
    value;
    return _completer.isCompleted;
  }

  /// Set the error with optional stackTrace to [AsyncError]
  void setError(Object error, [StackTrace? stackTrace]) {
    value = AsyncState.error(error, stackTrace);
    if (_completer.isCompleted) _completer = Completer<bool>();
    _completer.complete(true);
  }

  /// Set the value to [AsyncData]
  void setValue(T value) {
    this.value = AsyncState.data(value);
    if (_completer.isCompleted) _completer = Completer<bool>();
    _completer.complete(true);
  }

  /// Set the loading state to [AsyncLoading]
  void setLoading([AsyncState<T>? state]) {
    value = state ?? AsyncState.loading();
    _completer = Completer<bool>();
  }

  /// Reset the signal to the initial value
  void reset([AsyncState<T>? value]) {
    this.value = value ?? _initialValue;
    _initialized = false;
    if (_completer.isCompleted) _completer = Completer<bool>();
  }

  /// Initialize the signal
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

  /// Returns the value of the signal
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
