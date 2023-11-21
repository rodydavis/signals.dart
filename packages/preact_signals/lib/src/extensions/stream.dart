import 'package:preact_signals/preact_signals.dart';

ReadonlySignal<SignalState> streamToSignal<T>(Stream<T> stream) {
  final s = signal<SignalState>(SignalLoading());
  stream.listen((event) {
    s.value = SignalValue(event);
  }).onError((err) {
    s.value = SignalError(err);
  });
  return s;
}

extension SignalStreamUtils on Stream {
  ReadonlySignal toSignal() => streamToSignal(this);
}
