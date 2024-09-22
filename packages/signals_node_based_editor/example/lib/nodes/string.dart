import 'package:signals/signals.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';

import 'base.dart';

class StringNode extends BaseNode {
  final Knob data;
  final bool optional;

  StringNode({
    String? data,
    this.optional = false,
  })  : data = optional
            ? OptionalStringKnob('data', data ?? '')
            : StringKnob('data', data ?? ''),
        super('String${optional ? '?' : ''}');

  factory StringNode.fromJson(Map<String, dynamic> json, bool optional) {
    return StringNode(
      data: json['data'],
      optional: optional,
    );
  }

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(data, 'String', optional),
    ];
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('value', data.source, 'String', false),
    ];
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data.value,
    };
  }
}
