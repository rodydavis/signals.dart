import '../async/future.dart';
import '../async/stream.dart';

/// Extension on future to provide helpful methods for signals
extension SignalFutureUtils<T> on Future<T> {
  /// Convert an existing future to [FutureSignal]
  ///
  /// ```dart
  /// import 'package:signals/signals.dart';
  ///
  /// final future = Future(() => 1);
  /// final signal = future.toSignal();
  /// ```
  FutureSignal<T> toFutureSignal({
    Duration? timeout,
    StreamSignalOptions<T>? options,
  }) {
    return futureSignal(
      () => timeout != null ? this.timeout(timeout) : this,
      options: options,
    );
  }
}
