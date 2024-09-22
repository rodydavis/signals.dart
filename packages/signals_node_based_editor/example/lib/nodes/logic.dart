import 'package:signals/signals.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';

class LogicNode extends GraphNode {
  final source = IntKnob('Source', 0);

  late final ReadonlySignal<int> result$ = source.source;

  late final ReadonlySignal<bool> boolResult$ =
      result$.select((val) => (val.value & 1) == 1);

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('result', result$, 'int', false),
      NodeWidgetOutput('truthy', boolResult$, 'bool', false),
    ];
  });

  @override
  String get type$ => 'logic';
}

class LogicCompareNode extends LogicNode {
  final IntKnob left, right;

  LogicCompareNode({
    int? left,
    int? right,
  })  : left = IntKnob('Left', left ?? 0),
        right = IntKnob('Right', right ?? 0);

  int compare(int a, int b) => a.compareTo(b);

  @override
  late ReadonlySignal<int> result$ = computed(() {
    return compare(left.value, right.value);
  });

  @override
  late ReadonlySignal<String> label$ = signal('Compare (Logic)');

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(left, 'int', false),
      NodeWidgetInput(right, 'int', false),
    ];
  });

  @override
  String get type$ => 'logic_compare';
}

class LogicAndNode extends LogicCompareNode {
  @override
  int compare(int a, int b) => a & b;

  @override
  late ReadonlySignal<String> label$ = signal('AND (Logic)');
}

@override
String get type$ => 'logic_and';

class LogicNandNode extends LogicCompareNode {
  @override
  int compare(int a, int b) => ~(a & b);

  @override
  late ReadonlySignal<String> label$ = signal('NAND (Logic)');

  @override
  String get type$ => 'logic_nand';
}

class LogicOrNode extends LogicCompareNode {
  @override
  int compare(int a, int b) => a | b;

  @override
  late ReadonlySignal<String> label$ = signal('OR (Logic)');

  @override
  String get type$ => 'logic_or';
}

class LogicXorNode extends LogicCompareNode {
  @override
  int compare(int a, int b) => a ^ b;

  @override
  late ReadonlySignal<String> label$ = signal('XOR (Logic)');

  @override
  String get type$ => 'logic_xor';
}

class LogicNorNode extends LogicCompareNode {
  @override
  int compare(int a, int b) => ~(a | b);

  @override
  late ReadonlySignal<String> label$ = signal('NOR (Logic)');

  @override
  String get type$ => 'logic_nor';
}

class LogicXnorNode extends LogicCompareNode {
  @override
  int compare(int a, int b) => ~(a ^ b);

  @override
  late ReadonlySignal<String> label$ = signal('XNOR (Logic)');

  @override
  String get type$ => 'logic_xnor';
}
