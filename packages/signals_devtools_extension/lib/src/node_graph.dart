import 'dart:math';

import 'package:flutter/material.dart';
import 'package:force_directed_graphview/force_directed_graphview.dart';
import 'package:signals/signals_flutter.dart';

import 'nodes_state.dart';
import 'widget/background_grid.dart';
import 'widget/node_view.dart';

class NodeGraph extends StatefulWidget {
  const NodeGraph({super.key});

  @override
  State<NodeGraph> createState() => _NodeGraphState();
}

class _NodeGraphState extends State<NodeGraph>
    with SingleTickerProviderStateMixin {
  final _controller = GraphController<Node<int>, Edge<Node<int>, int>>();
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  )..repeat();
  final List<VoidCallback> _cleanup = [];

  Set<Node<int>> get _nodes => _controller.nodes;
  Set<Edge<Node<int>, int>> get _edges => _controller.edges;

  static const nodeSize = 150;
  final _random = Random(0);

  @override
  void initState() {
    super.initState();
    _controller.mutate((mutator) {
      for (final node in nodes) {
        addNode(mutator, node, true);
      }
      for (final node in nodes) {
        addNode(mutator, node, false);
      }
      final sc = onSignalCreated().listen((node) {
        addNode(mutator, node, true);
      });
      _cleanup.add(sc.cancel);
      final su = onSignalUpdated().listen((node) {
        addNode(mutator, node, false);
      });
      _cleanup.add(su.cancel);
      final cc = onComputedCreated().listen((node) {
        addNode(mutator, node, true);
      });
      _cleanup.add(cc.cancel);
      final cu = onComputedUpdated().listen((node) {
        addNode(mutator, node, false);
      });
      _cleanup.add(cu.cancel);
      final ec = onEffectCreated().listen((node) {
        addNode(mutator, node, true);
      });
      _cleanup.add(ec.cancel);
      final eu = onEffectUpdated().listen((node) {
        addNode(mutator, node, false);
      });
      _cleanup.add(eu.cancel);
    });
  }

  void addNode(
    GraphMutator<Node<int>, Edge<Node<int>, int>> mutator,
    $Node n,
    bool fresh,
  ) {
    final node = Node(data: n.id, size: nodeSize.toDouble());
    if (fresh) {
      mutator.addNode(node);
      return;
    }

    final currentNodes = _nodes.toList();
    final currentEdges = _edges.toList();
    for (var i = 0; i < nodes.length; i++) {
      final n = nodes[i];
      final sources = n.sources?.split(',') ?? [];
      for (final s in sources) {
        final targets = nodes.where((e) => e.id.toString() == s);
        if (targets.isNotEmpty) {
          for (final target in targets) {
            final idx = currentNodes.indexWhere((e) => e.data == target.id);
            if (idx != -1) {
              final edge = Edge(
                source: currentNodes[idx],
                destination: node,
                data: 2,
              );
              if (!currentEdges.any((e) =>
                  e.source.data == edge.source.data &&
                  e.destination.data == edge.destination.data)) {
                mutator.addEdge(edge);
              }
            }
          }
        }
      }
    }
    final targets = n.targets?.split(',') ?? [];
    for (final s in targets) {
      final targets = nodes.where((e) => e.id.toString() == s);
      if (targets.isNotEmpty) {
        for (final target in targets) {
          final idx = currentNodes.indexWhere((e) => e.data == target.id);
          if (idx != -1) {
            final edge = Edge(
              source: node,
              destination: currentNodes[idx],
              data: 1,
            );
            if (!currentEdges.any((e) =>
                e.source.data == edge.source.data &&
                e.destination.data == edge.destination.data)) {
              mutator.addEdge(edge);
            }
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    for (var element in _cleanup) {
      element();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: GraphView<Node<int>, Edge<Node<int>, int>>(
        controller: _controller,
        canvasSize: const GraphCanvasSize.proportional(50),
        edgePainter: AnimatedDashEdgePainter(
          thickness: 2,
          animation: _animationController,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        layoutAlgorithm: FruchtermanReingoldAlgorithm(
          iterations: 1000,
          showIterations: true,
          relayoutIterationsMultiplier: 0.3,
          optimalDistance: nodeSize.toDouble() * 2,
          initialPositionExtractor: (node, canvasSize) {
            if (node.pinned) {
              return Offset(
                _random.nextDouble() * canvasSize.width,
                _random.nextDouble() * canvasSize.height,
              );
            }
            return FruchtermanReingoldAlgorithm.defaultInitialPositionExtractor(
              node,
              canvasSize,
            );
          },
        ),
        nodeBuilder: (context, node) => NodeView(node: node),
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
        canvasBackgroundBuilder: (context) => BackgroundGrid(
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
