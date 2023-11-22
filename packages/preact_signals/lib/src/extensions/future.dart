import 'package:preact_signals/preact_signals.dart';

/// Returns a [ReadonlySignal] that uses [SignalState] for the value.
///
/// Starts with [SignalLoading] for the default
/// state until the future completes.
///
/// When an error occurs [SignalError] is returned with the value
/// being the [Object] of the exception
///
/// If a [Duration] is added for the timeout and the
/// timeout is reached [SignalTimeout] will return and
/// extends [SignalError]
///
/// If success then the result will be [SignalValue]
ReadonlySignal<SignalState> signalFromFuture<T>(
  Future<T> future, {
  Duration? timeout,
}) {
  final s = signal<SignalState>(SignalLoading());
  bool started = false;

  Future<SignalState> execute() async {
    var f = future.then<SignalState>((val) {
      return SignalValue(val);
    }).catchError((err) {
      return SignalError(err);
    });
    if (timeout != null) {
      f = f.timeout(timeout, onTimeout: () {
        return SignalTimeout();
      });
    }
    return await f;
  }

  s.subscribe((value) {
    if (!started) {
      started = true;
      execute().then((value) => s.value = value);
    }
  });

  return s;
}

/// Extension on future to provide helpful methods for signals
extension SignalFutureUtils on Future {
  /// Convert an existing future to [ReadonlySignal]
  ReadonlySignal toSignal() => signalFromFuture(this);
}
