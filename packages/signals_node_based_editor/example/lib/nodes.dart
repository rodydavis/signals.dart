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
  ReadonlySignal<String> get label$ =>
      signal('Variable ($type${optional ? '?' : ''})');

  @override
  void linkNodes(Map<String, Object?> data, List<GraphNode> nodes) {}

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
    ];
  });
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

class NumVariableNode extends VariableNode<num> {
  NumVariableNode(num val) : super(NumKnob('Value', val), 'num', false);

  late final toInt = computed(() => source.value.toInt());
  late final toDouble = computed(() => source.value.toDouble());
}

class OptionalNumVariableNode extends VariableNode<num?> {
  OptionalNumVariableNode(num? val)
      : super(OptionalNumKnob('Value', val), 'num', true);

  late final toInt = computed(() => source.value?.toInt());
  late final toDouble = computed(() => source.value?.toDouble());
}

class IntVariableNode extends VariableNode<int> {
  IntVariableNode(int val) : super(IntKnob('Value', val), 'int', false);

  late final toInt = computed(() => source.value.toInt());
  late final toDouble = computed(() => source.value.toDouble());
}

class OptionalIntVariableNode extends VariableNode<int?> {
  OptionalIntVariableNode(int? val)
      : super(OptionalIntKnob('Value', val), 'int', true);

  late final toInt = computed(() => source.value?.toInt());
  late final toDouble = computed(() => source.value?.toDouble());
}

class DoubleVariableNode extends VariableNode<double> {
  DoubleVariableNode(double val)
      : super(DoubleKnob('Value', val), 'double', false);

  late final toInt = computed(() => source.value.toInt());
  late final toDouble = computed(() => source.value.toDouble());
}

class OptionalDoubleVariableNode extends VariableNode<double?> {
  OptionalDoubleVariableNode(double? val)
      : super(OptionalDoubleKnob('Value', val), 'double', true);

  late final toInt = computed(() => source.value?.toInt());
  late final toDouble = computed(() => source.value?.toDouble());
}

class EnumVariableNode<T extends Enum> extends VariableNode<T> {
  EnumVariableNode(T val, List<T> values, String type)
      : super(EnumKnob('Value', val, values), type, false);

  late final name = computed(() => source.value.name);
  late final index = computed(() => source.value.index);
}

class OptionalEnumVariableNode<T extends Enum> extends VariableNode<T?> {
  OptionalEnumVariableNode(T? val, List<T> values, String type)
      : super(OptionalEnumKnob('Value', val, values), type, true);

  late final name = computed(() => source.value?.name);
  late final index = computed(() => source.value?.index);
}
