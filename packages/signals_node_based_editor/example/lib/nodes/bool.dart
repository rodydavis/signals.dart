import 'package:signals/signals.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';

import 'base.dart';

class BoolNode extends BaseNode {
  final Knob data;
  final bool optional;

  BoolNode({
    bool? data,
    this.optional = false,
  })  : data = optional
            ? OptionalBoolKnob('data', data ?? false)
            : BoolKnob('data', data ?? false),
        super('bool${optional ? '?' : ''}');

  factory BoolNode.fromJson(Map<String, dynamic> json, bool optional) {
    return BoolNode(
      data: json['data'],
      optional: optional,
    );
  }

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(data, 'bool', optional),
    ];
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('value', data.source, 'bool', false),
    ];
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data.value,
    };
  }
}
