abstract class Benchmark {
  String get name;

  ValueContainer<T, dynamic> createValue<T>(T value);
  ComputedValueContainer<T, dynamic> createComputed<T>(T Function() cb);
}

abstract class ReadonlyValueContainer<T, O> {
  final O instance;
  ReadonlyValueContainer(this.instance);

  T get value;
}

abstract class ValueContainer<T, O> extends ReadonlyValueContainer<T, O> {
  ValueContainer(super.instance);

  set value(T val);
}

abstract class ComputedValueContainer<T, O>
    extends ReadonlyValueContainer<T, O> {
  ComputedValueContainer(super.instance);

  T Function() get compute;
}
