import 'readonly.dart';

abstract class Signal<T> extends ReadonlySignal<T> {
  @override
  SignalOptions<T> get options;

  set value(T value);

  void set(T value) => this.value = value;
}

class SignalOptions<T> extends ReadonlySignalOptions<T> {
  final bool Function(T a, T b) equalityCheck;

  const SignalOptions({
    super.debugLabel,
    this.equalityCheck = identical,
  });
}
