import '../value/async_signal.dart';
import '../value/stream_signal.dart';

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
  @Deprecated('Use [toSignalWithDefault] instead')
  StreamSignal<T> toSignal({
    bool? cancelOnError,
    String? debugLabel,
    bool fireImmediately = false,
  }) {
    return StreamSignal<T>(
      () => this,
      cancelOnError: cancelOnError,
      debugLabel: debugLabel,
      fireImmediately: fireImmediately,
    );
  }

  AsyncSignal<T> toSignalWithDefault(
    T initialValue, {
    String? debugLabel,
    bool? cancelOnError,
  }) {
    return AsyncSignal.fromStream(
      () => this,
      initialValue: initialValue,
      debugLabel: debugLabel,
      cancelOnError: cancelOnError,
    );
  }

  AsyncSignal<T?> toAsyncSignal({
    String? debugLabel,
    T? initialValue,
    bool? cancelOnError,
  }) {
    return AsyncSignal.fromStream(
      () => this,
      initialValue: initialValue,
      debugLabel: debugLabel,
      cancelOnError: cancelOnError,
    );
  }
}
