import 'package:flutter/material.dart';

import '../nodes/base.dart';

class NodeLayout extends MultiChildLayoutDelegate {
  final Map<Node, Offset> nodes;
  NodeLayout(this.nodes);

  @override
  void performLayout(Size size) {
    for (final nodeEntry in nodes.entries) {
      final nodeSize = BoxConstraints.tight(nodeEntry.key.size());
      layoutChild(nodeEntry.key.id, nodeSize);
      positionChild(nodeEntry.key.id, nodeEntry.value);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
