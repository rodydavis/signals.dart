import 'package:flutter/material.dart';

import '../../src/graph.dart';

class GraphBackgroundPainter extends CustomPainter {
  final Set<Selection> selection;
  final List<ConnectorPair> connectors;
  final Matrix4 transform;
  final ColorScheme colors;
  final TextTheme fonts;
  final Size cellSize;
  final Rect viewport;
  final double dotDimension;
  final Graph graph;

  GraphBackgroundPainter({
    required this.selection,
    required this.connectors,
    required this.colors,
    required this.fonts,
    required this.cellSize,
    required this.viewport,
    required this.dotDimension,
    required this.transform,
    required this.graph,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw grid background
    final Size(width: cW, height: cH) = cellSize;
    final int firstRow = (viewport.top / cH).floor();
    final int lastRow = (viewport.bottom / cH).ceil();
    final int firstCol = (viewport.left / cW).floor();
    final int lastCol = (viewport.right / cW).ceil();
    final bgPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = colors.surface;
    final fgPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = colors.outlineVariant.withOpacity(0.6);
    final cellRadius = Radius.circular(dotDimension);

    canvas.drawRect(viewport, bgPaint);

    for (int row = firstRow; row < lastRow; row++) {
      for (int col = firstCol; col < lastCol; col++) {
        final offset = Offset(col * cW, row * cH);
        var rect = offset & Size.square(dotDimension);
        rect = MatrixUtils.transformRect(transform, rect);
        final rrect = RRect.fromRectAndRadius(rect, cellRadius);
        canvas.drawRRect(rrect, fgPaint);
      }
    }

    // Draw viewport
    // final viewPaint = Paint()
    //   ..color = Colors.red
    //   ..style = PaintingStyle.stroke;
    // canvas.drawRect(graph.viewRect(), viewPaint);

    // Draw connectors
    for (final conn in connectors) {
      final selected = selection.any((e) {
        return e is ConnectorSelection &&
            e.input == conn.input &&
            e.output == conn.output;
      });
      if (graph.lazyRender &&
          !graph.nodeVisible(conn.input.node) &&
          !graph.nodeVisible(conn.output.node)) {
        continue;
      }
      final s = conn //
              .input
              .meta
              .connector
              .center +
          conn.input.node.offset$.value;
      final e = conn //
              .output
              .meta
              .connector
              .center +
          conn.output.node.offset$.value;
      final path = getPath(
        MatrixUtils.transformPoint(transform, s),
        MatrixUtils.transformPoint(transform, e),
      );
      final paint = Paint()
        ..color = selected ? colors.primary : colors.outlineVariant
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  static const bool straightLines = false;

  static Path getPath(Offset fromOffset, Offset toOffset) {
    // Draw line from fromRect.center to toRect.center
    final path = Path();
    path.moveTo(fromOffset.dx, fromOffset.dy);

    if (straightLines) {
      path.lineTo(toOffset.dx, toOffset.dy);
    } else {
      // Calculate control points for a smooth curve
      final controlPoint1 = Offset(
        fromOffset.dx + (toOffset.dx - fromOffset.dx) / 2,
        fromOffset.dy,
      );
      final controlPoint2 = Offset(
        fromOffset.dx + (toOffset.dx - fromOffset.dx) / 2,
        toOffset.dy,
      );

      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        toOffset.dx,
        toOffset.dy,
      );
    }
    return path;
  }

  void drawEdge(
    Canvas canvas,
    Offset fromOffset,
    Offset toOffset,
    Paint brush, {
    String? label,
  }) {
    // Draw line from fromRect.center to toRect.center
    final path = getPath(fromOffset, toOffset);
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
