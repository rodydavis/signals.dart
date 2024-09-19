import 'dart:convert';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:signals/signals.dart';

import '../graph.dart';
import '../node.dart';

mixin JsonInteropMixin<Node extends GraphNode> on Graph<Node> {
  Map<String, dynamic> nodeToJson(Node node) {
    return {
      '@id': node.id,
      '@type': node.type$,
      '@label': node.label$.value,
      '@collapsed': node.collapsed$.value,
      '@offset': {
        'x': node.offset$.value.dx,
        'y': node.offset$.value.dy,
      },
    };
  }

  Map<String, Node Function(Map<String, dynamic> json)> get nodesMapper;

  Node nodeFromJson(Map<String, dynamic> json) {
    final type = json['@type'];
    if (type == null) {
      throw JsonInteropParseError('Missing node type');
    }
    final node = nodesMapper[type];
    if (node == null) {
      throw JsonInteropParseError('Unknown node type: $type');
    }
    final val = node(json);
    // Update core properties
    if (json case {'@label': String label}) {
      if (val.label$ is Signal<String>) {
        (val.label$ as Signal<String>).value = label;
      }
    }
    if (json case {'@collapsed': bool collapsed}) {
      val.collapsed$.value = collapsed;
    }
    if (json case {'@offset': {'x': num dx, 'y': num dy}}) {
      val.offset$.value = Offset(
        dx.toDouble(),
        dy.toDouble(),
      );
    }
    return val;
  }

  Map<String, dynamic> toJson() {
    return {
      '@nodes': nodes.map(nodeToJson).toList(),
      '@edges': [
        for (final connector in connectors.value)
          {
            'source': {
              'id': connector.output.node.id,
              'label': connector.output.meta.port.label,
            },
            'target': {
              'id': connector.input.node.id,
              'label': connector.input.meta.port.label,
            },
          }
      ],
      '@transform': jsonEncode(transform.value.storage.toList()),
      '@date': DateTime.now().toIso8601String(),
    };
  }

  (bool, String) validateJson(Map<String, dynamic> json) {
    if (json['@nodes'] == null) {
      return (false, 'Missing nodes');
    }
    // Check if all nodes have a mapper type
    final nodes = json['@nodes'] as List;
    for (final node in nodes) {
      if (node['@type'] == null) {
        return (false, 'Missing node type');
      }
      if (nodesMapper[node['@type']] == null) {
        return (false, 'Unknown node type: ${node['@type']}');
      }
    }
    if (json['@edges'] == null) {
      return (false, 'Missing edges');
    }
    // Check for missing nodes
    final edges = json['@edges'] as List;
    for (final edge in edges) {
      final source = edge['source'];
      final target = edge['target'];
      if (source == null) {
        return (false, 'Missing source node');
      }
      if (target == null) {
        return (false, 'Missing target node');
      }

      final sourceId = source['id'];
      final sourceLabel = source['label'];
      final targetId = target['id'];
      final targetLabel = target['label'];
      if (sourceId == null) {
        return (false, 'Missing source node id');
      }
      if (sourceLabel == null) {
        return (false, 'Missing source node label');
      }
      if (targetId == null) {
        return (false, 'Missing target node id');
      }
      if (targetLabel == null) {
        return (false, 'Missing target node label');
      }
    }
    return (true, '');
  }

  void fromJson(Map<String, dynamic> json) {
    final (valid, msg) = validateJson(json);
    if (!valid) {
      throw JsonInteropParseError('Invalid JSON: $msg');
    }

    final localNodes = <String, Node>{};
    for (final node in json['@nodes'] as List) {
      final id = node['@id'];
      final n = nodeFromJson(node);
      localNodes[id] = n;
    }
    for (final edge in json['@edges'] as List) {
      final source = edge['source'];
      final target = edge['target'];
      final sourceNode = localNodes[source['id']];
      final targetNode = localNodes[target['id']];
      if (sourceNode == null) {
        throw JsonInteropParseError('Missing source node: ${source['id']}');
      }
      if (targetNode == null) {
        throw JsonInteropParseError('Missing target node: ${target['id']}');
      }
      final sourcePort = sourceNode.outputs.value.firstWhereOrNull(
        (port) => port.label == source['label'],
      );
      final targetPort = targetNode.inputs.value.firstWhereOrNull(
        (port) => port.label == target['label'],
      );
      if (sourcePort == null) {
        throw JsonInteropParseError('Missing source port: ${source['label']}');
      }
      if (targetPort == null) {
        throw JsonInteropParseError('Missing target port: ${target['label']}');
      }
      targetPort.knob.source = sourcePort.source;
    }
    batch(() {
      nodes.value = localNodes.values.toList();
      // @transform
      if (json case {'@transform': String transformJson}) {
        final list = (jsonDecode(transformJson) as List).cast<double>();
        transform.value = Matrix4.fromList(list);
      }
    });
  }
}

class JsonInteropParseError extends Error {
  final String message;
  JsonInteropParseError(this.message);
}
