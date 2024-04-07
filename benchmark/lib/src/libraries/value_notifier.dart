import 'package:flutter/material.dart';

import '../benchmark.dart';

class ValueNotifierBenchmark extends Benchmark {
  @override
  String get name => 'ValueNotifier';

  @override
  ValueContainer<T, dynamic> createValue<T>(T value) {
    return _Value<T>(value);
  }

  @override
  ComputedValueContainer<T, dynamic> createComputed<T>(
    T Function() cb,
  ) {
    return _Computed<T>(cb);
  }
}

class _Value<T> extends ValueContainer<T, ValueNotifier<T>> {
  _Value(T val) : super(ValueNotifier(val));

  @override
  set value(T val) => instance.value = val;

  @override
  T get value => instance.value;

  @override
  Function subscribe(Function(T) cb) {
    void update() {
      cb(instance.value);
    }

    instance.addListener(update);
    return () => instance.removeListener(update);
  }
}

class _Computed<T> extends ComputedValueContainer<T, ComputedNotifier<T>> {
  _Computed(this.compute) : super(ComputedNotifier(compute));

  @override
  final T Function() compute;

  @override
  T get value => instance.value;

  @override
  Function subscribe(Function(T) cb) {
    void update() {
      cb(instance.value);
    }

    instance.addListener(update);
    return () => instance.removeListener(update);
  }
}

class ComputedNotifier<T> extends ChangeNotifier {
  final T Function() compute;

  ComputedNotifier(this.compute);

  T get value => compute();
}
