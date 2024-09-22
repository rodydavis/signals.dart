import 'package:graphs/graphs.dart' as graphs;

import '../graph.dart';
import '../node.dart';

extension GraphUtils<Node extends GraphNode> on GraphData<Node> {
  bool connectionWillCauseCycle(
    (Node, NodeWidgetOutput) output,
    (Node, NodeWidgetInput) input,
  ) {
    final path = graphs.shortestPath<Node>(
      output.$1,
      input.$1,
      (node) => this[node] ?? [],
    );
    return path != null;
  }
}
