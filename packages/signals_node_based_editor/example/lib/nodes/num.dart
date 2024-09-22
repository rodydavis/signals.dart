import 'package:signals/signals.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';

import 'base.dart';

class NumNode extends BaseNode {
  final Knob data;
  final bool optional;

  NumNode({
    num? data,
    this.optional = false,
  })  : data = optional
            ? OptionalNumKnob('data', data ?? 0)
            : NumKnob('data', data ?? 0),
        super('num${optional ? '?' : ''}');

  factory NumNode.fromJson(Map<String, dynamic> json, bool optional) {
    return NumNode(
      data: json['data'],
      optional: optional,
    );
  }

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(data, 'num', optional),
    ];
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('value', data.source, 'num', false),
    ];
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data.value,
    };
  }
}
