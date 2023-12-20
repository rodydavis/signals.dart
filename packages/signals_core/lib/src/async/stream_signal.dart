import 'dart:async';

import 'async_signal.dart';
import 'async_state.dart';

class StreamSignal<T> extends AsyncSignal<T> {
  StreamSignal({
    Stream<T>? stream,
    T? initialValue,
    this.cancelOnError,
    super.debugLabel,
    void Function()? onDone,
  }) : super(initialValue != null
            ? AsyncState.data(initialValue)
            : AsyncState.loading()) {
    if (stream != null) {
      addStream(
        stream,
        cancelOnError: cancelOnError,
        onDone: onDone,
      );
    }
  }

  final _subscriptions = <(StreamSubscription<T>, void Function()?)>[];
  bool? cancelOnError;

  @override
  void reset() {
    super.reset();
    for (final (sub, cb) in _subscriptions) {
      sub.cancel();
      cb?.call();
    }
    _subscriptions.clear();
  }

  /// Add a stream to listen to for updating the signal.
  ///
  /// This will not cancel any previous streams and will continue to listen to
  /// all streams until the signal is disposed.
  void addStream(
    Stream<T> stream, {
    bool? cancelOnError,
    void Function()? onDone,
  }) {
    final subscription = stream.listen(
      setValue,
      onError: setError,
      cancelOnError: cancelOnError,
    );
    _subscriptions.add((subscription, onDone));
    subscription.onDone(() {
      onDone?.call();
      _subscriptions.removeWhere((e) => e.$1 == subscription);
    });
  }

  /// Reset the signal and add a new stream to listen to for
  /// updating the signal.
  ///
  /// This will cancel any previous streams and will continue to listen to
  /// the new stream until the signal is disposed.
  void resetStream(
    Stream<T> stream, {
    bool? cancelOnError,
    void Function()? onDone,
  }) {
    reset();
    addStream(
      stream,
      cancelOnError: cancelOnError,
      onDone: onDone,
    );
  }

  @override
  void dispose() {
    super.dispose();
    reset();
  }
}

StreamSignal<T> streamSignal<T>(
  Stream<T> Function() stream, {
  T? initialValue,
  bool? cancelOnError,
  String? debugLabel,
  void Function()? onDone,
}) {
  return StreamSignal(
    stream: stream(),
    initialValue: initialValue,
    cancelOnError: cancelOnError,
    debugLabel: debugLabel,
    onDone: onDone,
  );
}
