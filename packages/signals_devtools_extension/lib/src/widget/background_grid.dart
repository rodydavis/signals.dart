import 'package:flutter/material.dart';

class BackgroundGrid extends StatelessWidget {
  const BackgroundGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _GridBackgroundPainter(),
      );
}

class _GridBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const cellSize = 250.0;

    final blackPaint = Paint()..color = Colors.black12;
    final whitePaint = Paint()..color = Colors.white;

    for (var i = 0; i < size.width / cellSize; i++) {
      for (var j = 0; j < size.height / cellSize; j++) {
        final left = i * cellSize;
        final top = j * cellSize;

        canvas.drawRect(
          Rect.fromLTWH(left, top, cellSize, cellSize),
          (i + j).isEven ? whitePaint : blackPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
