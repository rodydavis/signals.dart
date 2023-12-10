import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../nodes_state.dart';

class NodeView extends StatelessWidget {
  const NodeView({
    required this.nodeId,
    super.key,
  });

  final int nodeId;

  @override
  Widget build(BuildContext context) {
    final items = nodes.watch(context);
    final item = items.firstWhere((e) => e.id == nodeId);
    return Tooltip(
      message: item.type,
      child: Chip(
        avatar: SizedBox.square(
          dimension: 50,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: switch (item.type) {
                'signal' => Colors.blue,
                'computed' => Colors.purple,
                'effect' => Colors.red,
                (_) => Colors.grey,
              },
              // border: Border.all(
              //   color: node.pinned ? Colors.red : Colors.black,
              //   width: 2,
              // ),
            ),
          ),
        ),
        label: Text(item.value ?? ''),
      ),
    );
  }
}
