import 'package:preact_signals/preact_signals.dart';

/// Returns a [ReadonlySignal] that uses [SignalState] for the value.
///
/// Starts with [SignalLoading] for the default
/// state until the stream first emits.
///
/// When an error occurs [SignalError] is returned with the value
/// being the [Object] of the exception
///
/// If success then the result will be [SignalValue]
ReadonlySignal<SignalState> signalFromStream<T>(Stream<T> stream) {
  final s = signal<SignalState>(SignalLoading());
  stream.listen((event) {
    s.value = SignalValue(event);
  }).onError((err) {
    s.value = SignalError(err);
  });
  return s;
}

/// Extension on stream to provide helpful methods for signals
extension SignalStreamUtils on Stream {
  /// Return [ReadonlySignal] from an existing stream
  ReadonlySignal toSignal() => signalFromStream(this);
}
