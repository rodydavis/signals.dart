import 'package:signals/signals.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';

import 'base.dart';

class GroupNode extends BaseNode {
  final ReadonlySignal<List<BaseNode>> nodes$;
  // TODO: Hidden inputs/outputs labels

  GroupNode(List<BaseNode> list)
      : nodes$ = listSignal<BaseNode>(list),
        super('Group');

  factory GroupNode.fromJson(
    Map<String, dynamic> json,
    BaseNode Function(Map<String, dynamic> data) parse,
  ) {
    return GroupNode(
      (json['nodes'] as List).cast<Map<String, dynamic>>().map(parse).toList(),
    );
  }

  Iterable<BaseNode> getNodesWithoutInputs() sync* {
    for (final item in nodes$()) {
      final valid = item.inputsMetadata.value.every(
        (input) {
          if (input.port.knob.readonly.value) {
            // Check to see if the input is external only
            final source = input.port.knob.target.value;
            // Find output node
            bool internal = false;
            for (final item in nodes$()) {
              for (final output in item.outputsMetadata.value) {
                if (output.port.source == source) {
                  internal = true;
                  continue;
                }
              }
            }
            return !internal;
          }
          return true;
        },
      );
      if (valid) yield item;
    }
  }

  Iterable<BaseNode> getNodesWithoutOutputs() sync* {
    for (final item in nodes$()) {
      for (final output in item.outputsMetadata.value) {
        final inputs = getInputsForPort(item, output.port).toList();
        if (inputs.isEmpty) {
          final valid = item.inputsMetadata.value.any((input) {
            return input.port.knob.readonly.value;
          });
          if (valid) yield item;
        }
      }
    }
  }

  Iterable<(BaseNode, NodeWidgetInput)> getInputsForPort(
    BaseNode node,
    NodeWidgetOutput output,
  ) sync* {
    for (final item in nodes$()) {
      if (item == node) continue;
      for (final input in item.inputsMetadata.value) {
        if (input.port.knob.target.value == output.source) {
          yield (item, input.port);
        }
      }
    }
  }

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      for (final item in getNodesWithoutInputs()) ...item.inputs.value,
    ];
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      for (final item in getNodesWithoutOutputs()) ...item.outputs.value,
    ];
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'nodes': nodes$.value.map((e) => e.toJson()).toList(),
    };
  }
}
