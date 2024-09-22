import 'package:signals/signals.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';

abstract class ValueNode<T, K extends Knob<T>> extends GraphNode {
  final K source;
  final String type$;
  final bool optional;

  ValueNode(this.source, this.type$, this.optional);

  @override
  late ReadonlySignal<String> label$ = signal(
    'Variable (${type$}${optional ? '?' : ''})',
  );

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(source, type$, optional),
    ];
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput(source.label, source.source, type$, optional),
      NodeWidgetOutput('toString', source.toString$, 'String', false),
      NodeWidgetOutput('isNull', source.isNull$, 'bool', false),
    ];
  });
}

class ObjectValueNode extends ValueNode<Object, Knob<Object>> {
  ObjectValueNode(Object val)
      : super(ObjectKnob('Value', val), 'Object', false);
}

class OptionalObjectValueNode extends ValueNode<Object?, Knob<Object?>> {
  OptionalObjectValueNode(Object? val)
      : super(OptionalObjectKnob('Value', val), 'Object', true);
}

class StringValueNode extends ValueNode<String, Knob<String>> {
  StringValueNode(String val)
      : super(StringKnob('Value', val), 'String', false);
}

class OptionalStringValueNode extends ValueNode<String?, Knob<String?>> {
  OptionalStringValueNode(String? val)
      : super(OptionalStringKnob('Value', val), 'String', true);
}

class BoolValueNode extends ValueNode<bool, Knob<bool>> {
  BoolValueNode(bool val) : super(BoolKnob('Value', val), 'bool', false);

  late final ReadonlySignal<int> toInt = source.source.select((val) {
    return val.value ? 1 : 0;
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('toInt', toInt, 'int', false),
    ];
  });
}

class OptionalBoolValueNode extends ValueNode<bool?, Knob<bool?>> {
  OptionalBoolValueNode(bool? val)
      : super(OptionalBoolKnob('Value', val), 'bool', true);

  late final ReadonlySignal<int?> toInt = source.source.select((val) {
    if (val.value != null) return val.value! ? 1 : 0;
    return null;
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('toInt', toInt, 'int', true),
    ];
  });
}

class NumValueNode<T extends num> extends ValueNode<T, Knob<T>> {
  NumValueNode(T val, {Knob<T>? knob, String? type, bool? optional})
      : super(knob ?? NumKnob('Value', val), type ?? 'num', optional ?? false);

  late final toInt = computed(() => source.value.toInt());
  late final toDouble = computed(() => source.value.toDouble());

  late final ReadonlySignal<bool> toBool = source.source.select((val) {
    return (toInt() & 1) == 1;
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('toInt', toInt, 'int', false),
      NodeWidgetOutput('toDouble', toDouble, 'double', false),
      NodeWidgetOutput('toBool', toBool, 'bool', false),
    ];
  });
}

class OptionalNumValueNode<T extends num> extends ValueNode<T?, Knob<T?>> {
  OptionalNumValueNode(T? val, {Knob<T?>? knob, String? type, bool? optional})
      : super(knob ?? OptionalNumKnob('Value', val), type ?? 'num',
            optional ?? true);

  late final toInt = computed(() => source.value?.toInt());
  late final toDouble = computed(() => source.value?.toDouble());

  late final ReadonlySignal<bool?> toBool = source.source.select((val) {
    final value = toInt();
    if (value != null) return (value & 1) == 1;
    return null;
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('toInt', toInt, 'int', true),
      NodeWidgetOutput('toDouble', toDouble, 'double', true),
      NodeWidgetOutput('toBool', toBool, 'bool', true),
    ];
  });
}

class IntValueNode extends NumValueNode<int> {
  IntValueNode(super.val)
      : super(knob: IntKnob('Value', val), type: 'int', optional: false);
}

class OptionalIntValueNode extends OptionalNumValueNode<int> {
  OptionalIntValueNode(super.val)
      : super(knob: OptionalIntKnob('Value', val), type: 'int', optional: true);
}

class DoubleValueNode extends NumValueNode<double> {
  DoubleValueNode(super.val)
      : super(knob: DoubleKnob('Value', val), type: 'double', optional: false);
}

class OptionalDoubleValueNode extends OptionalNumValueNode<double> {
  OptionalDoubleValueNode(super.val)
      : super(
            knob: OptionalDoubleKnob('Value', val),
            type: 'double',
            optional: true);
}

class EnumValueNode<T extends Enum> extends ValueNode<T, Knob<T>> {
  EnumValueNode(T val, List<T> values, String type)
      : super(EnumKnob('Value', val, values), type, false);

  late final name = computed(() => source.value.name);
  late final index = computed(() => source.value.index);

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('name', name, 'String', false),
      NodeWidgetOutput('index', index, 'int', false),
    ];
  });
}

class OptionalEnumValueNode<T extends Enum> extends ValueNode<T?, Knob<T?>> {
  OptionalEnumValueNode(T? val, List<T> values, String type)
      : super(OptionalEnumKnob('Value', val, values), type, true);

  late final name = computed(() => source.value?.name);
  late final index = computed(() => source.value?.index);

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('name', name, 'String', true),
      NodeWidgetOutput('index', index, 'int', true),
    ];
  });
}
