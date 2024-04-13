import 'package:state_beacon/state_beacon.dart';

import '../benchmark.dart';

class StateBeaconBenchmark extends Benchmark {
  @override
  String get name => 'state_beacon';

  @override
  ValueContainer<T, dynamic> createValue<T>(T value) {
    return _Value<T>(value);
  }

  @override
  ComputedValueContainer<T, dynamic> createComputed<T>(T Function() cb) {
    return _Computed<T>(cb);
  }

  @override
  void setup() {
    super.setup();
    BeaconScheduler.setCustomScheduler(() {
      BeaconScheduler.flush();
    });
  }
}

class _Value<T> extends ValueContainer<T, WritableBeacon<T>> {
  _Value(T val) : super(Beacon.writable(val));

  @override
  set value(T val) => instance.value = val;

  @override
  T get value => instance.value;

  @override
  Function subscribe(Function(T) cb) {
    return instance.subscribe(cb, synchronous: true);
  }
}

class _Computed<T> extends ComputedValueContainer<T, ReadableBeacon<T>> {
  _Computed(this.compute) : super(Beacon.derived(compute));

  @override
  final T Function() compute;

  @override
  T get value => instance.value;

  @override
  Function subscribe(Function(T) cb) {
    return instance.subscribe(cb, synchronous: true);
  }
}
