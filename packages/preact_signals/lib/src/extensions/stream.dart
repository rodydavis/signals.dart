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
  bool started = false;

  Stream<SignalState> execute() async* {
    var s = stream.map<SignalState>((val) {
      return SignalValue(val);
    }).handleError((err) {
      return SignalError(err);
    });
    yield* s;
  }

  s.subscribe((value) {
    if (!started) {
      started = true;
      execute().listen((value) => s.value = value);
    }
  });

  return s;
}

/// Extension on stream to provide helpful methods for signals
extension SignalStreamUtils on Stream {
  /// Return [ReadonlySignal] from an existing stream
  ReadonlySignal toSignal() => signalFromStream(this);
}
