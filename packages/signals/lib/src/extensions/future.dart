import '../async/future_signal.dart';

/// Extension on future to provide helpful methods for signals
extension SignalFutureUtils<T> on Future<T> {
  /// Convert an existing future to [FutureAsyncSignal]
  ///
  /// ```dart
  /// import 'package:signals/signals.dart';
  ///
  /// final future = Future(() => 1);
  /// final signal = future.toSignal();
  /// ```
  FutureSignal<T> toSignal({
    Duration? timeout,
    String? debugLabel,
    bool fireImmediately = false,
    T? initialValue,
  }) {
    return futureSignal(
      () => timeout != null ? this.timeout(timeout) : this,
      debugLabel: debugLabel,
      fireImmediately: fireImmediately,
      initialValue: initialValue,
    );
  }
}
