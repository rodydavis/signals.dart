import '../value/future_signal.dart';

/// Extension on future to provide helpful methods for signals
extension SignalFutureUtils<T> on Future<T> {
  /// Convert an existing future to [FutureSignal]
  ///
  /// ```dart
  /// import 'package:preact_signals/preact_signals.dart';
  ///
  /// final future = Future(() => 1);
  /// final signal = future.toSignal();
  /// ```
  ///
  /// The [FutureSignal] will return [SignalState] for the value. To react to
  /// the various states you can use a switch statement:
  ///
  /// ```dart
  /// final s = FutureSignal(...);
  /// final result = (switch(s.value) {
  ///   SignalValue result => print('value: ${result.value}'),
  ///   SignalTimeout _ => print('timeout error'),
  ///   SignalError result => print('error: ${result.error}'),
  ///   SignalLoading _ => print('loading'),
  /// });
  /// ```
  FutureSignal<T> toSignal({Duration? timeout, String? debugLabel}) {
    return FutureSignal<T>(
      () => this,
      debugLabel: debugLabel,
      timeout: timeout,
    );
  }
}
