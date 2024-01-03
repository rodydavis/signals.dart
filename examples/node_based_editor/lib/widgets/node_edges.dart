import 'package:flutter/material.dart';

import '../nodes/base.dart';

class NodeEdges extends CustomPainter {
  final Matrix4 matrix4;
  final Map<Node, Offset> nodes;
  final Set<Node> selected;
  NodeEdges(this.matrix4, this.nodes, this.selected);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.transform(matrix4.storage);
    for (final nodeEntry in nodes.entries) {
      final sourceOffset = nodeEntry.value;
      if (nodeEntry.key.inputs.isNotEmpty) {
        final paint = Paint()
          ..color = selected.contains(nodeEntry.key) ? Colors.blue : Colors.grey
          ..strokeWidth = 1;
        final offsets = nodeEntry.key.inputOffsets;
        for (var i = 0; i < nodeEntry.key.inputs.length; i++) {
          final target = nodeEntry.key.inputs[i];
          final nodeOffset =
              nodes[target]! + target.outputOffset + circleCenter;
          final targetOffset = sourceOffset + offsets[i] + circleCenter;
          canvas.drawLine(nodeOffset, targetOffset, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
