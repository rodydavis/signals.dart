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
    void Function()? onPause,
    void Function()? onResume,
    FutureOr<void> Function()? onCancel,
  })  : _controller = StreamController<T>(
          sync: sync,
          onListen: onListen,
          onPause: onPause,
          onResume: onResume,
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
    bool reset = true,
  }) {
    if (reset) {
      _subscription?.cancel();
      _subscription = _controller.stream.listen(
        setValue,
        onError: setError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );
    }
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

  /// Called when the stream is done
  void onDone() {}

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

@Deprecated('Use [streamSignal] instead')
StreamSignal<T> asyncSignalFromStream<T>(
  Stream<T> Function() stream, {
  T? initialValue,
  bool? cancelOnError,
  String? debugLabel,
}) {
  return streamSignal(
    stream,
    initialValue: initialValue,
    cancelOnError: cancelOnError,
    debugLabel: debugLabel,
  );
}
