import 'package:flutter/material.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';

class GraphDelegate extends MultiChildLayoutDelegate {
  final List<GraphNode> nodes;
  final Rect viewport;
  final Matrix4 transform;

  GraphDelegate({
    required this.transform,
    required this.nodes,
    required this.viewport,
  });

  static const String backgroundKey = 'background';

  @override
  void performLayout(Size size) {
    // layoutChild(backgroundKey, BoxConstraints.tight(viewport.size));
    // positionChild(backgroundKey, Offset.zero);

    for (final node in nodes) {
      var nodeRect = node.offset$.value & node.preferredSize$.value;
      nodeRect = MatrixUtils.transformRect(transform, nodeRect);
      layoutChild(node.id, BoxConstraints.tight(nodeRect.size));
      positionChild(node.id, nodeRect.topLeft);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
