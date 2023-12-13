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
    final idx = items.indexWhere((e) => e.id == nodeId);
    if (idx == -1) return const SizedBox.shrink();
    final item = items[idx];
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
            ),
          ),
        ),
        label: Builder(builder: (context) {
          final sb = StringBuffer();
          sb.write(item.value ?? '');
          if (item.label != null && item.label!.isNotEmpty) {
            sb.write(' ');
            sb.write('(${item.label})');
          }
          return Text(sb.toString());
        }),
      ),
    );
  }
}
