import 'dart:async';

import '../connect.dart';
import '../signals.dart';

/// A compound [Signal] that wraps a [Stream] or [Future]
class AsyncSignal<T> implements ReadonlySignal<T> {
  final T _initialValue;
  late final _result = signal<T>(_initialValue);
  final _completed = signal(false);
  final _error = signal<Object?>(null);
  late Connect<T> _connector = connect<T>(_result);
  EffectCleanup? _cleanup;
  Completer<T> _completer = Completer<T>();

  /// Future of the completer
  Future<T> get future => _completer.future;

  /// Returns true if the completer is done
  bool get isCompleted => _completer.isCompleted;

  @override
  final String? debugLabel;

  AsyncSignal._(this._initialValue, {this.debugLabel});

  /// Creates a [AsyncSignal] that wraps a [Stream]
  factory AsyncSignal.fromStream(
    Stream<T> Function() stream, {
    required T initialValue,
    bool? cancelOnError,
    String? debugLabel,
  }) {
    final signal = AsyncSignal<T>._(initialValue, debugLabel: debugLabel);
    signal._stream(() => stream(), cancelOnError: cancelOnError);
    return signal;
  }

  /// Creates a [AsyncSignal] that wraps a [Future]
  factory AsyncSignal.fromFuture(
    Future<T> Function() future, {
    required T initialValue,
    String? debugLabel,
  }) {
    final signal = AsyncSignal<T>._(initialValue, debugLabel: debugLabel);
    signal._future(() => future());
    return signal;
  }

  void _stream(Stream<T> Function() stream, {bool? cancelOnError}) {
    _cleanup = effect(() {
      if (_completed()) return;
      _connector.from(
        stream(),
        cancelOnError: cancelOnError,
        onError: (err, trace) {
          _error.value = err;
          _completer = Completer<T>();
          _completer.completeError(err, trace);
        },
        onValue: (val) {
          _completer = Completer<T>();
          _completer.complete(val);
        },
      );
      _completed.value = true;
    });
  }

  void _future(Future<T> Function() future) {
    _stream(() => future().asStream(), cancelOnError: true);
  }

  void resetFuture(Future<T> Function() future) {
    dispose();
    _completed.value = false;
    _future(future);
  }

  void resetStream(
    Stream<T> Function() stream, {
    bool? cancelOnError,
  }) {
    dispose();
    _completed.value = false;
    _stream(stream, cancelOnError: cancelOnError);
  }

  void dispose() {
    _cleanup?.call();
    _cleanup = null;
    _connector.dispose();
    _completer = Completer<T>();
  }

  void refresh() {
    _connector.dispose();
    _connector = connect<T>(_result);
    _completed.value = false;
  }

  @override
  T get value => _result.value;

  bool get completed => _completed.value;

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
