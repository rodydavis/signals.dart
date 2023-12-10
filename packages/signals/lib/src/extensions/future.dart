import '../value/async_signal.dart';
import '../value/future_signal.dart';

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
  @Deprecated('Use [toSignalWithDefault] instead')
  FutureSignal<T> toSignal({
    Duration? timeout,
    String? debugLabel,
    bool fireImmediately = false,
  }) {
    return FutureSignal<T>(
      () => this,
      debugLabel: debugLabel,
      timeout: timeout,
      fireImmediately: fireImmediately,
    );
  }

  AsyncSignal<T> toSignalWithDefault(
    T initialValue, {
    String? debugLabel,
  }) {
    return AsyncSignal.fromFuture(
      () => this,
      initialValue: initialValue,
      debugLabel: debugLabel,
    );
  }

  AsyncSignal<T?> toAsyncSignal({
    String? debugLabel,
    T? initialValue,
  }) {
    return AsyncSignal.fromFuture(
      () => this,
      initialValue: initialValue,
      debugLabel: debugLabel,
    );
  }
}
