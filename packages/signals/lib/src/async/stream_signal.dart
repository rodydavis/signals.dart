import 'dart:async';

import 'async_signal.dart';
import 'async_signal_state.dart';

class StreamSignal<T> extends AsyncSignal<T> {
  StreamSignal({
    Stream<T>? stream,
    T? initialValue,
    this.cancelOnError,
    super.debugLabel,
    bool sync = false,
    void Function()? onListen,
    FutureOr<void> Function()? onCancel,
  })  : _controller = StreamController<T>.broadcast(
          sync: sync,
          onListen: onListen,
          onCancel: onCancel,
        ),
        super(initialValue != null
            ? AsyncSignalState.data(initialValue)
            : AsyncSignalState.loading()) {
    _subscription = _controller.stream.listen(
      setValue,
      onError: setError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
    if (stream != null) addStream(stream);
  }

  late final StreamController<T> _controller;
  StreamSubscription<T>? _subscription;
  bool? cancelOnError;

  Future<void> addStream(
    Stream<T> stream, {
    bool? cancelOnError,
  }) {
    return _controller.addStream(
      stream,
      cancelOnError: cancelOnError ?? this.cancelOnError,
    );
  }

  void addError(Object error, [StackTrace? stackTrace]) {
    _controller.addError(error, stackTrace);
  }

  /// Add a value to the stream
  void add(T value) {
    _controller.add(value);
  }

  @override
  void reset() {
    super.reset();
    _subscription?.cancel();
    _subscription = _controller.stream.listen(
      setValue,
      onError: setError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  /// Called when the stream is done
  void onDone() {}

  void resetStream(Stream<T> Function() stream) {
    reset();
    addStream(stream());
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

StreamSignal<T> streamSignal<T>(
  Stream<T> Function() stream, {
  T? initialValue,
  bool? cancelOnError,
  String? debugLabel,
}) {
  return StreamSignal(
    stream: stream(),
    initialValue: initialValue,
    cancelOnError: cancelOnError,
    debugLabel: debugLabel,
  );
}
