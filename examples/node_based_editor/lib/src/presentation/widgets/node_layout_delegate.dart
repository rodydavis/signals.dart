import 'package:flutter/material.dart';

import '../../generated/nodes/base_node.dart';
import 'render_node.dart';

class NodeLayoutDelegate extends MultiChildLayoutDelegate {
  NodeLayoutDelegate({
    required this.matrix4,
    required this.nodes,
  });

  final Matrix4 matrix4;
  final List<BaseNode> nodes;

  @override
  void performLayout(Size size) {
    for (final node in nodes) {
      final transformedRect = MatrixUtils.transformRect(matrix4, node.rect());
      layoutChild(node.id, BoxConstraints.tight(transformedRect.size));
      positionChild(node.id, transformedRect.topLeft);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
