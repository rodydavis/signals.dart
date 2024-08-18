import 'package:flutter/material.dart';

class GraphForegroundPainter extends CustomPainter {
  final bool straightLines;
  final ColorScheme colors;
  final TextTheme fonts;
  final (Offset, Offset)? connection;

  GraphForegroundPainter(
    this.connection, {
    required this.colors,
    required this.fonts,
    this.straightLines = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (connection != null) {
      final paint = Paint()
        ..color = colors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawLine(connection!.$1, connection!.$2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawEdge(
    Canvas canvas,
    Offset fromOffset,
    Offset toOffset,
    Paint brush, {
    String? label,
  }) {
    // Draw line from fromRect.center to toRect.center
    final path = Path();
    path.moveTo(fromOffset.dx, fromOffset.dy);

    if (straightLines) {
      path.moveTo(toOffset.dx, toOffset.dy);
    } else {
      path.cubicTo(
        fromOffset.dx,
        fromOffset.dy,
        fromOffset.dx,
        toOffset.dy,
        toOffset.dx,
        toOffset.dy,
      );
    }
    canvas.drawPath(path, brush);
    if (label != null) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: label,
          style: fonts.bodySmall?.copyWith(
            color: colors.onSurface,
            shadows: [
              Shadow(
                offset: const Offset(0.8, 0.8),
                blurRadius: 3,
                color: colors.surface,
              ),
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      // Render label on line
      Offset textOffset = Offset(
        (fromOffset.dx + toOffset.dx) / 2,
        (fromOffset.dy + toOffset.dy) / 2,
      );
      // Center on curve, if used
      final pathMetrics = path.computeMetrics();
      final pathMetric = pathMetrics.first;
      final pathLength = pathMetric.length;
      final middle = pathMetric.getTangentForOffset(pathLength / 2);
      textOffset = middle?.position ?? textOffset;
      // Offset to top left
      textOffset = textOffset.translate(
        -textPainter.width / 2,
        -textPainter.height / 2,
      );
      textPainter.paint(canvas, textOffset);
    }
  }
}
