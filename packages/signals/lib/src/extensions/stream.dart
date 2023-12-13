import 'package:signals/src/async/stream_signal.dart';

/// Extension on stream to provide helpful methods for signals
extension SignalStreamUtils<T> on Stream<T> {
  /// Convert a stream to a signal
  ///
  /// ```dart
  /// import 'package:signals/signals.dart';
  ///
  /// Stream<int> createStream() async* {
  ///     yield 1;
  ///     yield 2;
  ///     yield 3;
  /// }
  /// final stream = createStream();
  /// final signal = stream.toSignal();
  /// ```
  StreamSignal<T> toSignal({
    bool? cancelOnError,
    String? debugLabel,
    T? initialValue,
  }) {
    return asyncSignalFromStream<T>(
      () => this,
      cancelOnError: cancelOnError,
      debugLabel: debugLabel,
      initialValue: initialValue,
    );
  }

  @Deprecated('Use [toSignal] instead')
  StreamSignal<T> toSignalWithDefault(
    T initialValue, {
    String? debugLabel,
    bool? cancelOnError,
  }) {
    return toSignal(
      cancelOnError: cancelOnError,
      debugLabel: debugLabel,
      initialValue: initialValue,
    );
  }
}
