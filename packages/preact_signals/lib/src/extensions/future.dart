import 'package:preact_signals/preact_signals.dart';

ReadonlySignal<SignalState> futureToSignal<T>(
  Future<T> future, {
  Duration? timeout,
}) {
  final s = signal<SignalState>(SignalLoading());
  var f = future.then((val) {
    s.value = SignalValue(val);
  }).catchError((err) {
    s.value = SignalError(err);
  });
  if (timeout != null) {
    f = f.timeout(timeout, onTimeout: () {
      s.value = SignalTimeout();
    });
  }
  return s;
}

extension SignalFutureUtils on Future {
  ReadonlySignal toSignal() => futureToSignal(this);
}
