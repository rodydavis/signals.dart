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
    String? label,
    bool fireImmediately = false,
  }) {
    return StreamSignal<T>(
      () => this,
      cancelOnError: cancelOnError,
      label: label,
      fireImmediately: fireImmediately,
    );
  }

  AsyncSignal<T> toSignalWithDefault(
    T initialValue, {
    String? label,
    bool? cancelOnError,
  }) {
    return AsyncSignal.fromStream(
      () => this,
      initialValue: initialValue,
      label: label,
      cancelOnError: cancelOnError,
    );
  }

  AsyncSignal<T?> toAsyncSignal({
    String? label,
    T? initialValue,
    bool? cancelOnError,
  }) {
    return AsyncSignal.fromStream(
      () => this,
      initialValue: initialValue,
      label: label,
      cancelOnError: cancelOnError,
    );
  }
}
