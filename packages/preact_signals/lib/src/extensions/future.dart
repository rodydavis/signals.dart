import 'package:preact_signals/src/future_signal.dart';

/// Extension on future to provide helpful methods for signals
extension SignalFutureUtils<T> on Future<T> {
  /// Convert an existing future to [FutureSignal]
  FutureSignal<T> toSignal({Duration? timeout}) {
    return FutureSignal<T>(
      () => this,
      timeout: timeout,
    );
  }
}
