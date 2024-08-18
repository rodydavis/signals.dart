import 'package:flutter/material.dart';

/// Background grid for the [InfiniteCanvas].
class GridBackgroundBuilder extends StatelessWidget {
  const GridBackgroundBuilder({
    super.key,
    required this.cellWidth,
    required this.cellHeight,
    required this.viewport,
    this.width = 3,
  });

  final double cellWidth;
  final double cellHeight;
  final Rect viewport;
  final double width;

  @override
  Widget build(BuildContext context) {
    final int firstRow = (viewport.top / cellHeight).floor();
    final int lastRow = (viewport.bottom / cellHeight).ceil();
    final int firstCol = (viewport.left / cellWidth).floor();
    final int lastCol = (viewport.right / cellWidth).ceil();
    final colors = Theme.of(context).colorScheme;
    final color = colors.outlineVariant.withOpacity(0.6);
    return Material(
      color: colors.surface,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          for (int row = firstRow; row < lastRow; row++)
            for (int col = firstCol; col < lastCol; col++)
              Positioned(
                left: col * cellWidth,
                top: row * cellHeight,
                child: Container(
                  width: width,
                  height: width,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
