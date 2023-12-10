import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphview/graphview.dart';

import 'nodes_state.dart';
import 'widget/node_view.dart';

class NodeGraph extends StatefulWidget {
  const NodeGraph({super.key});

  @override
  State<NodeGraph> createState() => _NodeGraphState();
}

class _NodeGraphState extends State<NodeGraph> {
  final List<VoidCallback> _cleanup = [];
  final r = Random();
  final graph = Graph();
  final builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void reassemble() {
    for (var element in _cleanup) {
      element();
    }
    _cleanup.clear();
    graph.nodes.clear();
    graph.edges.clear();
    init();
    super.reassemble();
  }

  void init() {
    final mutator = graph;

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

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
    final er = onEffectRemove().listen((node) {
      removeNode(mutator, node);
    });
    _cleanup.add(er.cancel);
  }

  void removeNode(Graph mutator, $Node n) {
    graph.nodes.removeWhere((e) => e.key?.value == n.id);
    graph.edges.removeWhere(
        (e) => e.source.key?.value == n.id || e.destination.key?.value == n.id);
    if (mounted) setState(() {});
  }

  void addNode(Graph mutator, $Node n, bool fresh) {
    final idx = graph.nodes.indexWhere((e) => e.key?.value == n.id);
    if (fresh) {
      if (idx == -1) {
        final node = Node.Id(n.id);
        mutator.addNode(node);
      }
      return;
    }

    final sources =
        (n.sources?.split(',') ?? []).map((e) => int.parse(e)).toList();
    for (final s in sources) {
      final targetIdx = graph.nodes.indexWhere(
        (e) => e.key?.value == s,
      );
      if (targetIdx != -1) {
        final edgeIdx = graph.edges.indexWhere(
          (e) => e.source.key?.value == s && e.destination.key?.value == n.id,
        );
        if (edgeIdx == -1) {
          mutator.addEdge(
            graph.nodes[targetIdx],
            graph.nodes[idx],
            paint: Paint()..color = Colors.orange,
          );
        }
      }
    }
    final targets =
        (n.targets?.split(',') ?? []).map((e) => int.parse(e)).toList();
    for (final s in targets) {
      final targetIdx = graph.nodes.indexWhere(
        (e) => e.key?.value == s,
      );
      if (targetIdx != -1) {
        final edgeIdx = graph.edges.indexWhere(
          (e) => e.destination.key?.value == s && e.source.key?.value == n.id,
        );
        if (edgeIdx == -1) {
          mutator.addEdge(
            graph.nodes[idx],
            graph.nodes[targetIdx],
            paint: Paint()..color = Colors.green,
          );
        }
      }
    }

    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    for (var element in _cleanup) {
      element();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: InteractiveViewer(
          constrained: false,
          boundaryMargin: const EdgeInsets.all(100),
          minScale: 0.01,
          maxScale: 5.6,
          child: GraphView(
            graph: graph,
            algorithm: FruchtermanReingoldAlgorithm(),
            paint: Paint()
              ..color = Theme.of(context).colorScheme.outline
              ..strokeWidth = 1
              ..style = PaintingStyle.stroke,
            builder: (node) {
              final id = node.key!.value as int;
              return NodeView(nodeId: id);
            },
          ),
        ),
      ),
    );
  }
}
