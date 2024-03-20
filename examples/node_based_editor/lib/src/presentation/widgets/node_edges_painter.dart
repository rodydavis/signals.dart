import 'package:flutter/material.dart';
import 'package:node_based_editor/src/presentation/widgets/render_node.dart';

import '../../generated/nodes/base_node.dart';

class NodeEdgesPainter extends CustomPainter {
  NodeEdgesPainter({
    required this.matrix4,
    required this.nodes,
    required this.selected,
    required this.colors,
  });

  final Matrix4 matrix4;
  final List<BaseNode> nodes;
  final Set<BaseNode> selected;
  final ColorScheme colors;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.transform(matrix4.storage);
    // TODO: Color gradient for connections
    // TODO: Colors for input type
    for (final node in nodes) {
      final nodeOffset = node.toOffset();
      for (final input in node.inputs.entries) {
        if (input.value.link == null) continue;
        final inputOffset = node.getOffsetForInput(
          input.key,
        );
        if (inputOffset == null) continue;
        final link = input.value.link!;
        final target = node.getNode(link.nodeId);
        if (target == null) continue;
        final outputOffset = target.getOffsetForOutput(
          link.outputKey,
        );
        if (outputOffset == null) continue;
        final targetOffset = target.toOffset();
        final end = nodeOffset + inputOffset;
        final start = targetOffset + outputOffset;
        final path = Path()
          ..moveTo(start.dx, start.dy)
          ..cubicTo(
            start.dx + 100,
            start.dy,
            end.dx - 100,
            end.dy,
            end.dx,
            end.dy,
          );
        final isSelected = selected.contains(node) || selected.contains(target);
        final paint = Paint()
          ..color = isSelected ? colors.primary : colors.outline
          ..strokeWidth = isSelected ? 2 : 1;
        paint.style = PaintingStyle.stroke;
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
