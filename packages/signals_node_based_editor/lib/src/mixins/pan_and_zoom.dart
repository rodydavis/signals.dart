import 'package:flutter/widgets.dart';

import '../graph.dart';
import '../node.dart';

mixin PanAndZoomMixin<Node extends GraphNode> on BaseGraph<Node> {
  void zoomIn() => zoom(1.1);
  void zoomOut() => zoom(0.9);

  void panUp() => pan(const Offset(0, -10));
  void panDown() => pan(const Offset(0, 10));
  void panLeft() => pan(const Offset(-10, 0));
  void panRight() => pan(const Offset(10, 0));

  void pan(Offset delta) {
    final matrix = transform.value.clone();
    matrix.translate(delta.dx, delta.dy);
    transform.value = matrix;
  }

  void zoom(double delta) {
    final matrix = transform.value.clone();
    final mouse = this.mouse.value;
    if (mouse != null) {
      final local = toLocal(mouse);
      matrix.translate(local.dx, local.dy);
    }
    matrix.scale(delta, delta);
    if (mouse != null) {
      final local = toLocal(mouse);
      matrix.translate(-local.dx, -local.dy);
    }
    transform.value = matrix;
  }

  void resetView() {
    transform.value = Matrix4.identity();
  }
}
