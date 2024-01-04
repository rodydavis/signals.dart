import 'package:flutter/material.dart';

import '../nodes/base.dart';

class NodeLayout extends MultiChildLayoutDelegate {
  final Matrix4 matrix;
  final Map<Node, Offset> nodes;
  NodeLayout(this.matrix, this.nodes);

  @override
  void performLayout(Size size) {
    for (final nodeEntry in nodes.entries) {
      final nodeRect = nodeEntry.value &  nodeEntry.key.size();
      final transformedRect = MatrixUtils.transformRect(matrix, nodeRect);
      layoutChild(nodeEntry.key.id, BoxConstraints.tight(transformedRect.size));
      positionChild(nodeEntry.key.id, transformedRect.topLeft);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
