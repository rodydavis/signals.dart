import 'package:flutter/material.dart';

import 'nodes/base.dart';
import 'nodes/operation.dart';
import 'nodes/source.dart';

class GraphBackgroundPainter extends CustomPainter {
  final SourceImage source;
  final List<GraphNode> nodes;
  final Color color;

  GraphBackgroundPainter(this.source, this.nodes, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    for (final node in nodes) {
      final start = (node.offset.value & source.imageSize.value).center;
      if (node is ImageOperation) {
        for (final item in node.sources) {
          final end = (item.offset.value & source.imageSize.value).center;
          final paint = Paint()
            ..color = color
            ..strokeWidth = 1;
          canvas.drawLine(start, end, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
