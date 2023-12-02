import '../value/stream_signal.dart';

/// Extension on stream to provide helpful methods for signals
extension SignalStreamUtils<T> on Stream<T> {
  /// Convert a stream to a signal
  ///
  /// ```dart
  /// import 'package:preact_signals/preact_signals.dart';
  ///
  /// Stream<int> createStream() async* {
  ///     yield 1;
  ///     yield 2;
  ///     yield 3;
  /// }
  /// final stream = createStream();
  /// final signal = stream.toSignal();
  /// ```
  ///
  /// The [StreamSignal] will return [SignalState] for the value. To react to
  /// the various states you can use a switch statement:
  ///
  /// ```dart
  /// final s = StreamSignal(...);
  /// final result = (switch(s.value) {
  ///   SignalValue result => print('value: ${result.value}'),
  ///   SignalError result => print('error: ${result.error}'),
  ///   SignalLoading _ => print('loading'),
  /// });
  /// ```
  StreamSignal<T> toSignal({bool? cancelOnError, String? debugLabel}) {
    return StreamSignal<T>(
      () => this,
      cancelOnError: cancelOnError,
      debugLabel: debugLabel,
    );
  }
}
