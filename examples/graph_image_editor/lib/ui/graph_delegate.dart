import 'package:flutter/material.dart';

import 'nodes/base.dart';
import 'nodes/source.dart';

class GraphDelegate extends MultiChildLayoutDelegate {
  final SourceImage source;
  final List<GraphNode> nodes;

  GraphDelegate(this.source, this.nodes);

  @override
  void performLayout(Size size) {
    for (final node in nodes) {
      final nodeRect = node.offset.value & source.imageSize.value;
      layoutChild(node.id, BoxConstraints.tight(source.imageSize.value));
      positionChild(node.id, nodeRect.topLeft);
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
