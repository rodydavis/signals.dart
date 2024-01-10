import '../core/signals.dart';

typedef CallbackFunction<T> = Function(Function(T value));

extension CallbackFunctionNullableUtils<T> on CallbackFunction<T> {
  ReadonlySignal<T> toSignal(T initialValue) {
    final s = signal<T>(initialValue);
    this((val) => s.set(val));
    return s;
  }
}
