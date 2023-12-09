import 'package:flutter/material.dart';

class BackgroundGrid extends StatelessWidget {
  const BackgroundGrid({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final Color backgroundColor, foregroundColor;

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _GridBackgroundPainter(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
      );
}

class _GridBackgroundPainter extends CustomPainter {
  final Color backgroundColor, foregroundColor;

  const _GridBackgroundPainter({
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw a dotted grid
    const dotSpacing = 20.0;
    const dotSize = 2.0;
    const dotOffset = dotSpacing / 2;
    final dotPaint = Paint()
      ..color = foregroundColor
      ..strokeWidth = dotSize;
    final dotPath = Path();
    for (var x = dotOffset; x < size.width; x += dotSpacing) {
      for (var y = dotOffset; y < size.height; y += dotSpacing) {
        dotPath.moveTo(x, y);
        dotPath.lineTo(x + dotSize, y + dotSize);
      }
    }
    canvas.drawPath(dotPath, dotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
