import '../async/future.dart';
import '../async/state.dart';
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
  FutureSignal<T> toSignal({
    T? initialValue,
    SignalOptions<AsyncState<T>>? options,
  }) {
    return futureSignal(
      () => this,
      initialValue: initialValue,
      options: options,
    );
  }
}
