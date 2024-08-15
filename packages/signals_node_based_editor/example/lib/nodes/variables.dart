import 'package:signals_node_based_editor/signals_node_based_editor.dart';
import 'package:signals/signals_flutter.dart';

abstract class VariableNode<T> extends GraphNode {
  final Knob<T> source;
  final String type;
  final bool optional;

  VariableNode(this.source, this.type, this.optional);

  @override
  String get type$ => 'variable_$type${optional ? '_optional' : ''}_node';

  @override
  late ReadonlySignal<String> label$ = signal(
    'Variable ($type${optional ? '?' : ''})',
  );

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(source, type, optional),
    ];
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput(source.label, source.source, type, optional),
      NodeWidgetOutput('toString', source.toString$, 'String', false),
      NodeWidgetOutput('isNull', source.isNull$, 'bool', false),
    ];
  });
}

class ObjectVariableNode extends VariableNode<Object> {
  ObjectVariableNode(Object val)
      : super(ObjectKnob('Value', val), 'Object', false);
}

class OptionalObjectVariableNode extends VariableNode<Object?> {
  OptionalObjectVariableNode(Object? val)
      : super(OptionalObjectKnob('Value', val), 'Object', true);
}

class StringVariableNode extends VariableNode<String> {
  StringVariableNode(String val)
      : super(StringKnob('Value', val), 'String', false);
}

class OptionalStringVariableNode extends VariableNode<String?> {
  OptionalStringVariableNode(String? val)
      : super(OptionalStringKnob('Value', val), 'String', true);
}

class BoolVariableNode extends VariableNode<bool> {
  BoolVariableNode(bool val) : super(BoolKnob('Value', val), 'bool', false);
}

class OptionalBoolVariableNode extends VariableNode<bool?> {
  OptionalBoolVariableNode(bool? val)
      : super(OptionalBoolKnob('Value', val), 'bool', true);
}

class NumVariableNode<T extends num> extends VariableNode<T> {
  NumVariableNode(T val, {Knob<T>? knob, String? type, bool? optional})
      : super(knob ?? NumKnob('Value', val), type ?? 'num', optional ?? false);

  late final toInt = computed(() => source.value.toInt());
  late final toDouble = computed(() => source.value.toDouble());

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('toInt', toInt, 'int', false),
      NodeWidgetOutput('toDouble', toDouble, 'double', false),
    ];
  });
}

class OptionalNumVariableNode<T extends num> extends VariableNode<T?> {
  OptionalNumVariableNode(T? val,
      {Knob<T?>? knob, String? type, bool? optional})
      : super(knob ?? OptionalNumKnob('Value', val), type ?? 'num',
            optional ?? true);

  late final toInt = computed(() => source.value?.toInt());
  late final toDouble = computed(() => source.value?.toDouble());

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('toInt', toInt, 'int', true),
      NodeWidgetOutput('toDouble', toDouble, 'double', true),
    ];
  });
}

class IntVariableNode extends NumVariableNode<int> {
  IntVariableNode(super.val)
      : super(knob: IntKnob('Value', val), type: 'int', optional: false);
}

class OptionalIntVariableNode extends OptionalNumVariableNode<int> {
  OptionalIntVariableNode(super.val)
      : super(knob: OptionalIntKnob('Value', val), type: 'int', optional: true);
}

class DoubleVariableNode extends NumVariableNode<double> {
  DoubleVariableNode(super.val)
      : super(knob: DoubleKnob('Value', val), type: 'double', optional: false);
}

class OptionalDoubleVariableNode extends OptionalNumVariableNode<double> {
  OptionalDoubleVariableNode(super.val)
      : super(
            knob: OptionalDoubleKnob('Value', val),
            type: 'double',
            optional: true);
}

class EnumVariableNode<T extends Enum> extends VariableNode<T> {
  EnumVariableNode(T val, List<T> values, String type)
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

class OptionalEnumVariableNode<T extends Enum> extends VariableNode<T?> {
  OptionalEnumVariableNode(T? val, List<T> values, String type)
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
