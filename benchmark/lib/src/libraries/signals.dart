import 'package:signals/signals.dart';

import '../benchmark.dart';

class SignalsBenchmark extends Benchmark {
  @override
  String get name => 'signals';

  @override
  ValueContainer<T, dynamic> createValue<T>(T value) {
    return _Value<T>(value);
  }

  @override
  ComputedValueContainer<T, dynamic> createComputed<T>(T Function() cb) {
    return _Computed<T>(cb);
  }
}

class _Value<T> extends ValueContainer<T, Signal<T>> {
  _Value(T val) : super(signal(val));

  @override
  set value(T val) => instance.value = val;

  @override
  T get value => instance.value;
}

class _Computed<T> extends ComputedValueContainer<T, Computed<T>> {
  _Computed(this.compute) : super(computed(compute));

  @override
  final T Function() compute;

  @override
  T get value => instance.value;
}
