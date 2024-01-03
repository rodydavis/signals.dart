import 'package:flutter/material.dart';

import '../nodes/base.dart';

class NodeEdges extends CustomPainter {
  final Map<Node, Offset> nodes;
  final Set<Node> selected;
  NodeEdges(this.nodes, this.selected);

  @override
  void paint(Canvas canvas, Size size) {
    for (final nodeEntry in nodes.entries) {
      if (nodeEntry.key.inputs.isEmpty) continue;
      final source = nodeEntry.value;
      final sourceSize = nodeEntry.key.size();
      final sourceOffset = source.translate(
        sourceSize.width / 2,
        sourceSize.height / 2,
      );
      final paint = Paint()
        ..color = selected.contains(nodeEntry.key) ? Colors.blue : Colors.grey
        ..strokeWidth = 1;
      for (final input in nodeEntry.key.inputs) {
        final target = nodes[input]!;
        final targetSize = input.size();
        final targetOffset = target.translate(
          targetSize.width / 2,
          targetSize.height / 2,
        );
        canvas.drawLine(sourceOffset, targetOffset, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
