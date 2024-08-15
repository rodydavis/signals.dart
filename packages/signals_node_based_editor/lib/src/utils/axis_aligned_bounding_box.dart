import 'dart:ui';

import 'package:vector_math/vector_math_64.dart';

Rect axisAlignedBoundingBox(Quad quad) {
  double xMin = quad.point0.x;
  double xMax = quad.point0.x;
  double yMin = quad.point0.y;
  double yMax = quad.point0.y;

  for (final Vector3 point in <Vector3>[
    quad.point1,
    quad.point2,
    quad.point3,
  ]) {
    if (point.x < xMin) {
      xMin = point.x;
    } else if (point.x > xMax) {
      xMax = point.x;
    }

    if (point.y < yMin) {
      yMin = point.y;
    } else if (point.y > yMax) {
      yMax = point.y;
    }
  }

  return Rect.fromLTRB(xMin, yMin, xMax, yMax);
}
