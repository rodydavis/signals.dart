import 'package:flutter/material.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';

class GraphDelegate extends MultiChildLayoutDelegate {
  final List<GraphNode> nodes;

  GraphDelegate(this.nodes);

  @override
  void performLayout(Size size) {
    for (final node in nodes) {
      var nodeRect = node.offset$.value & node.preferredSize.value;
      // nodeRect = MatrixUtils.transformRect(transform, nodeRect);
      layoutChild(node.id, BoxConstraints.tight(nodeRect.size));
      positionChild(node.id, nodeRect.topLeft);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
