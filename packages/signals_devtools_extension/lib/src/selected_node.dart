import 'dart:async';

import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';

import 'nodes_state.dart';

class SelectedNode extends StatefulWidget {
  const SelectedNode({
    super.key,
    required this.selectedNode,
    required this.onIncrement,
    required this.onDecrement,
  });

  final Node selectedNode;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  State<SelectedNode> createState() => _SelectedNodeState();
}

class _SelectedNodeState extends State<SelectedNode> {
  late Node? node = widget.selectedNode;

  Future<void> _updateSelectedNode(int id) async {
    try {
      final response = await serviceManager.callServiceExtensionOnMainIsolate(
        'ext.signals.getNode',
        args: {'id': id},
      );
      setState(() {
        node = parseNode(response.json ?? {});
      });
    } catch (e) {
      print('error fetching node $id');
      setState(() {
        node = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    unawaited(_updateSelectedNode(widget.selectedNode.id));
  }

  @override
  void didUpdateWidget(SelectedNode oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedNode.id != widget.selectedNode.id) {
      unawaited(_updateSelectedNode(widget.selectedNode.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (node == null) {
      return const Center(child: Text('Error fetching node'));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('Global ID'),
          subtitle: Text(node!.id.toString()),
        ),
        ListTile(
          title: const Text('Type'),
          subtitle: Text(node!.type),
        ),
        ListTile(
          title: const Text('Debug Label'),
          subtitle: Text(node!.label ?? 'N/A'),
        ),
        if (node!.value != null)
          ListTile(
            title: const Text('Value'),
            subtitle: Text(node!.value!),
            trailing: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => _updateSelectedNode(node!.id),
            ),
          ),
      ],
    );
  }
}
