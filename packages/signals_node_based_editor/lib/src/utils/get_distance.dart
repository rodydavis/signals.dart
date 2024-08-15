import 'dart:math';
import 'dart:ui';

double? getShortestDistance(Path path, Offset clickedPoint) {
  PathMetrics pathMetrics = path.computeMetrics();

  double? minDistance;

  pathMetrics.toList().forEach((element) {
    for (var i = 0; i < element.length; i++) {
      Tangent? tangent = element.getTangentForOffset(i.toDouble());
      if (tangent == null) continue;
      Offset pos = tangent.position;

      double distance = getDistance(pos, clickedPoint);
      if (minDistance == null || distance < minDistance!) {
        minDistance = distance;
      }
    }
  });

  return minDistance;
}

double getDistance(Offset pos, Offset clickedPoint) {
  double dx = pos.dx - clickedPoint.dx;
  double dy = pos.dy - clickedPoint.dy;
  double distance = sqrt(dx * dx + dy * dy);
  return distance.abs();
}
