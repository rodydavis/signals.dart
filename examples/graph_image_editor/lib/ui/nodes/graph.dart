import 'package:signals/signals.dart';

import 'base.dart';
import 'operation.dart';
import 'source.dart';

class ImageGraph {
  late final nodes = listSignal<GraphNode>([source]);
  final selection = setSignal<GraphNode>({});
  final source = SourceImage();

  void removeNode(GraphNode node) {
    batch(() {
      selection.remove(node);
      nodes.remove(node);

      final toRemove = <GraphNode>{};

      for (final child in nodes) {
        if (child is ImageOperation) {
          for (final source in child.sources) {
            if (source == node) {
              toRemove.add(child);
            }
          }
        }
      }

      for (final child in toRemove) {
        removeNode(child);
      }
    });
  }
}
