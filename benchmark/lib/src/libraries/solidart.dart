import 'package:solidart/solidart.dart';

import '../benchmark.dart';

class SolidartBenchmark extends Benchmark {
  @override
  String get name => 'solidart';

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
  _Value(T val) : super(Signal(val));

  @override
  set value(T val) => instance.value = val;

  @override
  T get value => instance.value;

  @override
  Function subscribe(Function(T) cb) {
    final effect = Effect((_) {
      final value = this.value;
      cb(value);
    });
    return effect.dispose;
  }
}

class _Computed<T> extends ComputedValueContainer<T, Computed<T>> {
  _Computed(this.compute) : super(Computed(compute));

  @override
  final T Function() compute;

  @override
  T get value => instance.value;

  @override
  Function subscribe(Function(T) cb) {
    final effect = Effect((_) {
      final value = this.value;
      cb(value);
    });
    return effect.dispose;
  }
}
