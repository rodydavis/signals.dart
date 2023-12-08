import 'package:flutter/material.dart';
import 'package:force_directed_graphview/force_directed_graphview.dart';
import 'package:signals/signals_flutter.dart';

import '../nodes_state.dart';

class NodeView extends StatelessWidget {
  const NodeView({
    required this.node,
    super.key,
  });

  final Node<int> node;

  @override
  Widget build(BuildContext context) {
    final items = nodes.watch(context);
    final item = items.firstWhere((e) => e.id == node.data);
    return SizedBox.square(
      dimension: node.size,
      child: Center(
        child: Chip(
          avatar: SizedBox.square(
            dimension: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: item.type == 'signal'
                    ? Colors.blue
                    : item.type == 'computed'
                        ? Colors.purple
                        : Colors.grey,
                border: Border.all(
                  color: node.pinned ? Colors.red : Colors.black,
                  width: 2,
                ),
              ),
            ),
          ),
          label: Text(item.value ?? ''),
        ),
      ),
    );
  }
}
