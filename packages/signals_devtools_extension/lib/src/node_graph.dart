import 'package:flutter/material.dart';
import 'package:force_directed_graphview/force_directed_graphview.dart';
import 'package:signals/signals_flutter.dart';

import 'nodes_state.dart';
import 'widget/node_view.dart';

class NodeGraph extends StatefulWidget {
  const NodeGraph({super.key});

  @override
  State<NodeGraph> createState() => _NodeGraphState();
}

class _NodeGraphState extends State<NodeGraph> {
  final _controller = GraphController<Node<int>, Edge<Node<int>, int>>();

  Set<Node<int>> get _nodes => _controller.nodes;
  Set<Edge<Node<int>, int>> get _edges => _controller.edges;

  VoidCallback? _cleanup;
  static const nodeSize = 150;

  @override
  void initState() {
    super.initState();
    _cleanup = effect(() {
      _controller.mutate((mutator) {
        for (var i = 0; i < nodes.length; i++) {
          final n = nodes[i];
          final node = Node(
            data: n.id,
            size: nodeSize.toDouble(),
          );
          if (!_nodes.any((e) => e.data == n.id)) {
            mutator.addNode(node);
          }
        }
        for (var i = 0; i < nodes.length; i++) {
          final n = nodes[i];
          if (n.sources != null && n.sources!.isNotEmpty) {
            final items = n.sources!.split(',');
            for (final s in items) {
              final targets = nodes.where((e) => e.id.toString() == s);
              if (targets.isNotEmpty) {
                for (final target in targets) {
                  final edge = Edge(
                    source: _nodes.firstWhere((e) => e.data == n.id),
                    destination: _nodes.firstWhere((e) => e.data == target.id),
                    data: 1,
                  );
                  if (!_edges.any((e) =>
                      e.source.data == edge.source.data &&
                      e.destination.data == edge.destination.data)) {
                    mutator.addEdge(edge);
                  }
                }
              }
            }
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _cleanup?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GraphView<Node<int>, Edge<Node<int>, int>>(
      controller: _controller,
      canvasSize: const GraphCanvasSize.proportional(50),
      edgePainter: _CustomEdgePainter(Theme.of(context).colorScheme.onSurface),
      layoutAlgorithm: FruchtermanReingoldAlgorithm(
        iterations: 500,
        relayoutIterationsMultiplier: 0.2,
        optimalDistance: nodeSize.toDouble(),
        initialPositionExtractor: (node, canvasSize) {
          return FruchtermanReingoldAlgorithm.defaultInitialPositionExtractor(
            node,
            canvasSize,
          );
        },
      ),
      nodeBuilder: (context, node) => _ContextMenuNode(
        controller: _controller,
        node: node,
      ),
      labelBuilder: BottomLabelBuilder(
        builder: (context, node) {
          final items = nodes.watch(context);
          final n = items.firstWhere((e) => e.id == node.data);
          return Text(
            n.label ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
            ),
          );
        },
        labelSize: Size(nodeSize.toDouble(), nodeSize.toDouble() * 0.3),
      ),
      canvasBackgroundBuilder: (context) => const GridPaper(),
    );
  }
}

class _CustomEdgePainter
    implements EdgePainter<Node<int>, Edge<Node<int>, int>> {
  const _CustomEdgePainter(this.color);

  final Color color;

  @override
  void paint(
    Canvas canvas,
    Edge<Node<int>, int> edge,
    Offset sourcePosition,
    Offset destinationPosition,
  ) {
    canvas.drawLine(
      sourcePosition,
      destinationPosition,
      Paint()
        ..color = color
        ..strokeWidth = 2,
    );
  }
}

enum _ContextMenuAction {
  pinUnpin,
  jumpTo,
  delete,
}

class _ContextMenuNode extends StatelessWidget {
  const _ContextMenuNode({
    required this.controller,
    required this.node,
  });

  final GraphController<Node<int>, Edge<Node<int>, int>> controller;
  final Node<int> node;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: _performAction,
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: _ContextMenuAction.pinUnpin,
          child: Text('Pin/Unpin'),
        ),
        PopupMenuItem(
          value: _ContextMenuAction.jumpTo,
          child: Text('Jump To'),
        ),
        PopupMenuItem(
          value: _ContextMenuAction.delete,
          child: Text('Delete'),
        ),
      ],
      child: NodeView(node: node),
    );
  }

  void _performAction(_ContextMenuAction value) {
    switch (value) {
      case _ContextMenuAction.pinUnpin:
        controller.setPinned(node, !node.pinned);
      case _ContextMenuAction.jumpTo:
        controller.jumpToNode(node);
      case _ContextMenuAction.delete:
        controller.mutate(
          (mutator) => mutator.removeNode(node),
        );
    }
  }
}
