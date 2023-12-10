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
    String? label,
    bool fireImmediately = false,
  }) {
    return FutureSignal<T>(
      () => this,
      label: label,
      timeout: timeout,
      fireImmediately: fireImmediately,
    );
  }

  AsyncSignal<T> toSignalWithDefault(
    T initialValue, {
    String? label,
  }) {
    return AsyncSignal.fromFuture(
      () => this,
      initialValue: initialValue,
      label: label,
    );
  }

  AsyncSignal<T?> toAsyncSignal({
    String? label,
    T? initialValue,
  }) {
    return AsyncSignal.fromFuture(
      () => this,
      initialValue: initialValue,
      label: label,
    );
  }
}
