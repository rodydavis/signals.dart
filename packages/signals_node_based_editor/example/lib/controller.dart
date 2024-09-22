import 'dart:convert';

import 'package:signals/signals.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';

import 'nodes/base.dart';
import 'nodes/bool.dart';
import 'nodes/group.dart';
import 'nodes/list.dart';
import 'nodes/num.dart';
import 'nodes/string.dart';

class GraphController extends Graph<BaseNode>
    with JsonInteropMixin, UndoRedoMixin<BaseNode, String> {
  @override
  late Map<String, BaseNode Function(Map<String, dynamic> json)> nodesMapper = {
    'String': (json) => StringNode.fromJson(json, false),
    'String?': (json) => StringNode.fromJson(json, true),
    'bool': (json) => BoolNode.fromJson(json, false),
    'bool?': (json) => BoolNode.fromJson(json, true),
    'num': (json) => NumNode.fromJson(json, false),
    'num?': (json) => NumNode.fromJson(json, true),
    'List<String>': (json) => StringList.fromJson(json, false),
    'List<String>?': (json) => StringList.fromJson(json, true),
    'Group': (json) => GroupNode.fromJson(json, nodeFromJson),
  };

  @override
  Map<String, dynamic> nodeToJson(BaseNode node) {
    return {
      ...super.nodeToJson(node),
      ...node.toJson(),
    };
  }

  @override
  void connectKnobToSource(
    (BaseNode, NodeWidgetInput) input,
    (BaseNode, NodeWidgetOutput) output,
  ) {
    if (input.$1 is ListNode) {
      final list = input.$1 as ListNode;
      // Add new item to list
      if (list.addKnob != null && input.$2.knob == list.addKnob!) {
        final index = list.items.length;
        batch(() {
          final Knob<dynamic> knob = StringKnob('$index', '');
          list.items.add(knob);
          knob.source = output.$2.source;
        });
        return;
      }
    }
    // input.$2.knob.source = output.$2.source;
    super.connectKnobToSource(input, output);
  }

  @override
  void disconnectKnobFromSource(BaseNode node, NodeWidgetInput input) {
    if (node is ListNode) {
      if (!node.canRemove) return;
      node.items.remove(input.knob);
    }
    super.disconnectKnobFromSource(node, input);
  }

  late Computed<bool> canGroup = computed(() {
    var selection = this
        .selection
        .value
        .whereType<NodeSelection<BaseNode>>()
        .map((e) => e.node)
        .toList();
    if (selection.length < 2) return false;
    final inputs = getNodesWithoutInputs(selection);
    if (inputs.isEmpty) return false;
    final outputs = getNodesWithoutOutputs(selection);
    if (outputs.isEmpty) return false;
    // final difference = inputs.toSet().union(outputs.toSet());
    // selection.removeWhere((e) => difference.contains(e));
    // if (selection.isEmpty) return false;
    return true;
  });

  void groupNodes() {
    if (!canGroup()) return;
    // Edges?
    final selection = this
        .selection
        .value
        .whereType<NodeSelection<BaseNode>>()
        .map((e) => e.node)
        .toList();

    // Translate offsets to relative
    batch(() {
      final root = selection.first;
      final offset = root.offset$.value;
      for (final node in selection) {
        node.offset$.value -= offset;
      }
      final group = GroupNode(selection);
      group.offset$.value = offset;
      final list = nodes.value.toList();
      list.removeWhere((e) => selection.contains(e));
      list.add(group);
      nodes.value = list;
      connectors.recompute();
    });
  }

  void unGroup(GroupNode group) {
    final selection = group.nodes$.value.toList();

    batch(() {
      final list = nodes.value.toList();
      list.remove(group);
      final offset = group.offset$.value;
      for (final node in selection) {
        node.offset$.value += offset;
      }
      list.addAll(selection);
      nodes.value = list;
      connectors.recompute();
    });
  }

  @override
  void loadSnapshot(String state) {
    final json = jsonDecode(state);
    fromJson(json);
  }

  @override
  String saveSnapshot() {
    const encoder = JsonEncoder.withIndent('  ');
    final json = toJson();
    json.remove('@date');
    final str = encoder.convert(json);
    return str;
  }
}
