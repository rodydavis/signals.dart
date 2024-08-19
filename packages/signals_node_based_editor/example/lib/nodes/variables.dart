import 'package:flutter/material.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';
import 'package:signals/signals_flutter.dart';

abstract class ValueNode<T, K extends Knob<T>> extends GraphNode {
  K get source;
  String get type;
  bool get optional;

  @override
  String get type$ => 'value_$type${optional ? '_optional' : ''}_node';

  @override
  late final label$ = signal('Value ($type${optional ? '?' : ''})');
}

mixin ReadableNode<T, K extends Knob<T>> on ValueNode<T, K> {
  ReadonlySignal<T> get result;

  @override
  String get type$ => '${super.type$}_readable';

  late ReadonlySignal<T> getter = computed(result.get);

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
      // NodeWidgetOutput(source.label, source.source, type, optional),
      // NodeWidgetOutput('toString', source.toString$, 'String', false),
      // NodeWidgetOutput('isNull', source.isNull$, 'bool', false),
      NodeWidgetOutput('value', result, type, optional),
      NodeWidgetOutput('get', getter, '$type Function()', optional),
    ];
  });
}

mixin WriteableNodeNode<T, K extends Knob<T>> on ReadableNode<T, K> {
  @override
  Signal<T> get result;

  @override
  String get type$ => '${super.type$}_writeable';

  late ReadonlySignal<void Function(T)> setter = computed(() {
    return this.result.set;
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('set', setter, 'void Function($type)', optional),
    ];
  });
}

class SetIntNode extends GraphNode {
  final IntKnob getter;
  final ObjectKnob<void Function(int)> setter;

  @override
  String get type$ => 'set_int_knob';

  @override
  late final label$ = signal('Set Int');

  SetIntNode(int val)
      : getter = IntKnob('getter', val),
        setter = ObjectKnob('setter', (val) {
          print('set: $val');
        });

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(getter, 'int', false),
      NodeWidgetInput(setter, 'void Function(int)', false),
    ];
  });

  late ReadonlySignal<void Function()> action = computed(() {
    final setter = this.setter.value;
    return () {
      print('set $setter $getter');
      return setter(getter.value + 1);
    };
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('action', action, 'void Function()', false),
    ];
  });
}

class SumIntNode extends GraphNode {
  final IntKnob a;
  final IntKnob b;

  @override
  String get type$ => 'sum_int_knob';

  @override
  late final label$ = signal('Sum Int');

  SumIntNode(int a, int b)
      : a = IntKnob('a', a),
        b = IntKnob('b', b);

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(a, 'int', false),
      NodeWidgetInput(b, 'int', false),
    ];
  });

  late ReadonlySignal<int> result = computed(() {
    return a.value + b.value;
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('Result', result, 'int', false),
    ];
  });
}

class IncrementNode extends ValueNode<int, IntKnob>
    with ReadableNode, WriteableNodeNode {
  @override
  final IntKnob source;

  @override
  final String type;

  @override
  final bool optional;

  @override
  late final label$ = signal('Increment');

  IncrementNode(int val)
      : source = IntKnob('Value', val),
        result = signal<int>(val),
        type = 'int',
        optional = false;

  @override
  final Signal<int> result;
}

abstract class VariableNode<T, K extends Knob<T>> extends GraphNode {
  final K source;
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

class VoidFunctionVariableKnob
    extends VariableNode<void Function(), VoidFunctionKnob> {
  VoidFunctionVariableKnob()
      : super(VoidFunctionKnob('Value'), 'void Function()', false);

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('calls', source.calls, 'int', false),
    ];
  });

  @override
  Computed<Size> previewSize$ =
      computed(() => const Size(double.infinity, 100));

  @override
  Widget preview(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: source.call,
        child: const Text('Click'),
      ),
    );
  }
}

// class OptionalVoidFunctionVariableKnob
//     extends VariableNode<void, OptionalVoidFunctionKnob> {
//   OptionalVoidFunctionVariableKnob()
//       : super(OptionalVoidFunctionKnob('Value'), 'void Function()', true);

//   @override
//   Computed<Size> previewSize = computed(() => const Size(double.infinity, 100));

//   @override
//   Widget preview(BuildContext context) {
//     return Center(
//       child: OutlinedButton(
//         onPressed: source.call,
//         child: const Text('Click'),
//       ),
//     );
//   }
// }

class ObjectVariableNode extends VariableNode<Object, Knob<Object>> {
  ObjectVariableNode(Object val)
      : super(ObjectKnob('Value', val), 'Object', false);
}

class OptionalObjectVariableNode extends VariableNode<Object?, Knob<Object?>> {
  OptionalObjectVariableNode(Object? val)
      : super(OptionalObjectKnob('Value', val), 'Object', true);
}

class StringVariableNode extends VariableNode<String, Knob<String>> {
  StringVariableNode(String val)
      : super(StringKnob('Value', val), 'String', false);
}

class OptionalStringVariableNode extends VariableNode<String?, Knob<String?>> {
  OptionalStringVariableNode(String? val)
      : super(OptionalStringKnob('Value', val), 'String', true);
}

class BoolVariableNode extends VariableNode<bool, Knob<bool>> {
  BoolVariableNode(bool val) : super(BoolKnob('Value', val), 'bool', false);
}

class OptionalBoolVariableNode extends VariableNode<bool?, Knob<bool?>> {
  OptionalBoolVariableNode(bool? val)
      : super(OptionalBoolKnob('Value', val), 'bool', true);
}

class NumVariableNode<T extends num> extends VariableNode<T, Knob<T>> {
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

class OptionalNumVariableNode<T extends num>
    extends VariableNode<T?, Knob<T?>> {
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

class EnumVariableNode<T extends Enum> extends VariableNode<T, Knob<T>> {
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

class OptionalEnumVariableNode<T extends Enum>
    extends VariableNode<T?, Knob<T?>> {
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
