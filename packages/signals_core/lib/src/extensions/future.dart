import '../async/future.dart';
import '../async/state.dart';
import '../core/signals.dart';

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
    T? initialValue,
    bool autoDispose = false,
    bool lazy = true,
    SignalEquality<AsyncState<T>>? equality,
    List<ReadonlySignal<dynamic>> dependencies = const [],
  }) {
    return futureSignal(
      () => timeout != null ? this.timeout(timeout) : this,
      debugLabel: debugLabel,
      initialValue: initialValue,
      autoDispose: autoDispose,
      lazy: lazy,
      equality: equality,
      dependencies: dependencies,
    );
  }
}
