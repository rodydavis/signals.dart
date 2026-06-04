import '../async/future.dart';
import '../async/signal.dart';
import '../core/signals.dart';

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
    T? initialValue,
    bool lazy = true,
    List<ReadonlySignal<dynamic>> dependencies = const [],
    AsyncSignalOptions<T>? options,
  }) {
    return futureSignal(
      () => timeout != null ? this.timeout(timeout) : this,
      initialValue: initialValue,
      lazy: lazy,
      dependencies: dependencies,
      options: options,
    );
  }
}
