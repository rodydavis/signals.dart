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
///   SignalError result => print('error: ${result.error}'),
///   SignalLoading _ => print('loading'),
/// });
/// ```
class StreamSignal<T> extends Signal<SignalState<T>> {
  /// If true then the stream will be cancelled on error
  final bool? cancelOnError;

  /// If true then the future will be called immediately
  final bool fireImmediately;

  /// Creates a [StreamSignal] that wraps a [Stream]
  StreamSignal(
    this._getStream, {
    this.cancelOnError,
    this.fireImmediately = true,
  }) : super(SignalLoading<T>()) {
    if (fireImmediately) _init();
    _stale = !fireImmediately;
  }

  final Stream<T> Function() _getStream;
  StreamSubscription<T>? _subscription;
  bool _stale = false;

  /// Resets the signal by calling the [Stream] again
  void reset() {
    _subscription?.cancel();
    _stale = true;
    if (fireImmediately) _init();
  }

  /// Stop stream subscription
  void close() {
    _subscription?.cancel();
  }

  void _init() {
    if (!_stale) return;
    _stale = false;
    if (peek() is! SignalLoading<T>) {
      value = SignalLoading<T>();
    }
    var s = _getStream();
    _subscription = s.listen(
      (value) {
        this.value = SignalValue<T>(value);
      },
      onError: (error) {
        if (error is SignalTimeout<T>) {
          value = error;
        } else {
          value = SignalError<T, Object>(error);
        }
      },
      cancelOnError: cancelOnError,
    );
  }

  @override
  SignalState<T> get value {
    _init();
    return super.value;
  }
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
