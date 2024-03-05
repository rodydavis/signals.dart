import 'package:flutter/material.dart';

import '../../generated/nodes/base_node.dart';

class ConnectorPainter extends CustomPainter {
  ConnectorPainter({
    required this.matrix4,
    required this.nodes,
    required this.connectStart,
    required this.connectEnd,
    required this.colors,
  });

  final Matrix4 matrix4;
  final List<BaseNode> nodes;
  final Offset? connectStart, connectEnd;
  final ColorScheme colors;

  @override
  void paint(Canvas canvas, Size size) {
    if (connectStart != null && connectEnd != null) {
      final paint = Paint()
        ..color = colors.outline
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;
      canvas.drawLine(connectStart!, connectEnd!, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
