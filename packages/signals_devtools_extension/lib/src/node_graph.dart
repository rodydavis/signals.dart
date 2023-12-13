import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphview/graphview.dart';
import 'package:signals/signals.dart';

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

  void init() {
    builder
      ..siblingSeparation = 100
      ..levelSeparation = 150
      ..subtreeSeparation = 150
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;

    _cleanup.add(effect(() {
      final node = nodeAdd.value;
      if (node != null) {
        setNode(graph, node);
      }
    }));
    _cleanup.add(effect(() {
      final node = nodeUpdate.value;
      if (node != null) {
        setNode(graph, node);
      }
    }));
    _cleanup.add(effect(() {
      final node = nodeRemove.value;
      if (node != null) {
        removeNode(graph, node);
      }
    }));
    _cleanup.add(effect(() {
      reassembleCount.value;
      graph.nodes.clear();
      graph.edges.clear();
      for (final node in nodes.peek()) {
        setNode(graph, node);
      }
    }));
  }

  void removeNode(Graph mutator, $Node n) {
    graph.nodes.removeWhere(
      (e) => e.key?.value == n.id,
    );
    graph.edges.removeWhere(
      (e) => e.source.key?.value == n.id || e.destination.key?.value == n.id,
    );
    if (mounted) setState(() {});
  }

  Node addNode(int val) {
    final idx = graph.nodes.indexWhere((e) => e.key?.value == val);
    if (idx == -1) {
      final node = Node.Id(val);
      graph.addNode(node);
      return node;
    } else {
      return graph.nodes[idx];
    }
  }

  void setNode(Graph mutator, $Node n) {
    addNode(n.id);
    setNodeSources(mutator, n);
    setNodeTargets(mutator, n);
    if (mounted) setState(() {});
  }

  void setNodeSources(Graph mutator, $Node n) {
    final sources = n.sources?.split(',') ?? [];
    final items = sources.map((e) => int.parse(e)).toList();
    for (final item in items) {
      addEdge(mutator, item, n.id, Colors.orange);
    }
  }

  void setNodeTargets(Graph mutator, $Node n) {
    final sources = n.targets?.split(',') ?? [];
    final items = sources.map((e) => int.parse(e)).toList();
    for (final item in items) {
      addEdge(mutator, n.id, item, Colors.green);
    }
  }

  void addEdge(Graph mutator, int from, int to, Color color) {
    final idx = graph.edges.indexWhere(
      (e) => e.source.key?.value == from && e.destination.key?.value == to,
    );
    if (idx == -1) {
      mutator.addEdge(
        addNode(from),
        addNode(to),
        paint: Paint()..color = color,
      );
    }
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
