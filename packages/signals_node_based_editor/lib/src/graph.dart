import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signals/signals_flutter.dart';

import 'knobs.dart';
import 'node.dart';
import 'utils/get_distance.dart';
import 'widgets/background_painter.dart';
import 'package:graphs/graphs.dart' as graphs;

typedef ConnectorInput<Node extends GraphNode> = ({
  Node node,
  PortMetadata<NodeWidgetInput> meta,
});

typedef ConnectorOutput<Node extends GraphNode> = ({
  Node node,
  PortMetadata<NodeWidgetOutput> meta,
});

typedef ConnectorPair<Node extends GraphNode> = ({
  ConnectorInput<Node> input,
  ConnectorOutput<Node> output,
});

// TODO: Move forward / back
// TODO: Marquee
// TODO: Line connect

class Graph<Node extends GraphNode> {
  late final nodes = listSignal<Node>([]);
  final selection = setSignal<Selection>({});
  final target = signal<ActionTarget>(NoActionTarget());
  final mouse = signal<Offset?>(null);
  final viewport = signal<Size>(Size.zero);
  final controller = TransformationController(Matrix4.identity());
  late final transform = valueNotifierToSignal(controller);
  final minScale = signal<double>(0.4);
  final maxScale = signal<double>(4);
  final panEnabled = signal(true);
  final scaleEnabled = signal(true);
  final fromPort = signal<PortMetadata?>(null);
  final toPort = signal<PortMetadata?>(null);
  final connection = signal<(Offset, Offset)?>(null);
  final _scale = signal(0.0);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void removeConnector(ConnectorInput target) {
    selection.clear();
    batch(() {
      for (final node in nodes) {
        // Loop over inputs only to remove incoming sources
        for (final item in node.inputs.value) {
          if (target.meta.port.knob == item.knob) {
            // Reset source
            disconnectKnobFromSource(node, target.meta.port);
          }
        }
      }
    });
  }

  void removeNode(Node node) {
    selection.clear();
    batch(() {
      nodes.remove(node);

      for (final child in nodes) {
        for (final item in child.inputsMetadata.value) {
          for (final out in node.outputsMetadata.value) {
            if (item.port.knob.target.value == out.port.source) {
              disconnectKnobFromSource(child, item.port);
            }
          }
        }
      }
    });
  }

  late final Computed<List<ConnectorPair>> connectors = computed(() {
    final from = <(Node, PortMetadata<NodeWidgetOutput>)>[];
    // Get all outputs
    for (final node in nodes.value) {
      for (final output in node.outputsMetadata.value) {
        from.add((node, output));
      }
    }
    // Find connected inputs
    final results = <ConnectorPair>[];
    for (final node in nodes) {
      for (final input in node.inputsMetadata.value) {
        if (!input.port.knob.readonly.value) continue;
        final related =
            from.where((e) => e.$2.port.source == input.port.knob.target.value);
        for (final item in related) {
          results.add((
            input: (
              node: node,
              meta: input,
            ),
            output: (
              node: item.$1,
              meta: item.$2,
            ),
          ));
        }
      }
    }
    return results;
  });

  Iterable<Selection> hitTest(Offset offset) sync* {
    final point = offset & const Size.square(1);
    for (final conn in connectors.value) {
      final start = conn //
              .input
              .meta
              .connector
              .center +
          conn.input.node.offset$.value;
      final end = conn //
              .output
              .meta
              .connector
              .center +
          conn.output.node.offset$.value;
      final path = GraphBackgroundPainter.getPath(start, end);
      final distance = getShortestDistance(path, offset);
      if (distance != null && distance < 2) {
        yield ConnectorSelection(conn.input, conn.output);
      }
    }
    for (final node in nodes) {
      var nodeRect = node.offset$.value & node.preferredSize$.value;
      // nodeRect = MatrixUtils.transformRect(transform.value, nodeRect);
      if (nodeRect.overlaps(point)) {
        final offset = node.offset$.value;
        if ((offset & node.headerRect.size).overlaps(point)) {
          yield NodeSelection(node, NodeSelectionPart.header, null);
          continue;
        } else {
          yield NodeSelection(node, NodeSelectionPart.body, null);
          continue;
        }
      } else {
        final offset = node.offset$.value;
        for (final item in node.inputsMetadata.value) {
          final rect = item.connector.translate(offset.dx, offset.dy);
          if (rect.overlaps(point)) {
            yield NodeSelection(node, NodeSelectionPart.connector, item);
            continue;
          }
        }
        for (final item in node.outputsMetadata.value) {
          final rect = item.connector.translate(offset.dx, offset.dy);
          if (rect.overlaps(point)) {
            yield NodeSelection(node, NodeSelectionPart.connector, item);
            continue;
          }
        }
      }
    }
  }

  Offset toLocal(Offset offset) {
    return MatrixUtils.transformPoint(
      transform.value,
      offset,
    );
  }

  Offset fromLocal(Offset offset) {
    final point = MatrixUtils.inverseTransformRect(
      transform.value,
      offset & const Size.square(1),
    );
    return point.topLeft;
  }

  Size getSize() => viewport.value * getScale();

  Rect getRect() => getOffset() & getSize();

  Offset getCenter() => getRect().center;

  void add(Node node, {bool center = false}) {
    if (center) node.offset$.value = getCenter();
    nodes.add(node);
  }

  void onInteractionStart(ScaleStartDetails event) {
    // debugPrint(event.toString());
    // mouse.value = event.focalPoint;
    mouse.value = event.localFocalPoint;
    final local = fromLocal(event.localFocalPoint);
    final list = hitTest(local);
    batch(() {
      if (list.isEmpty || event.pointerCount == 2) {
        target.value = ActionViewTarget();
        selection.clear();
      } else {
        final top = list.last;
        selection.clear(); // TODO: Check for multi slect
        selection.add(top);
        if (top is NodeSelection) {
          if (top.part == NodeSelectionPart.connector) {
            fromPort.value = top.port;
            toPort.value = null;
            connection.value = (local, local);
          }
          target.value = ActionNodeTarget(top.node, top.part);
        }
        panEnabled.value = false;
        scaleEnabled.value = false;
      }
      mouse.value = local;
    });
  }

  void onInteractionUpdate(ScaleUpdateDetails event) {
    // debugPrint(event.toString());
    mouse.value = event.localFocalPoint;
    final local = fromLocal(event.localFocalPoint);
    _scale.value = event.scale;
    final target = this.target.value;
    if (connection.value != null) {
      connection.value = (connection.value!.$1, local);
    } else if (target is ActionNodeTarget) {
      if (event.pointerCount == 1) {
        if (target.part == NodeSelectionPart.header) {
          final top = target.node;
          top.offset$.value += event.focalPointDelta / getScale();
        }
      }
    }
  }

  void onInteractionEnd(ScaleEndDetails event) {
    // debugPrint(event.toString());
    // mouse.value = null;
    if (fromPort.value != null) {
      final local = fromLocal(mouse.value!);
      final list = hitTest(local);
      if (list.isNotEmpty) {
        final top = list.last;
        if (top is NodeSelection) {
          if (top.part == NodeSelectionPart.connector) {
            toPort.value = top.port;
          }
        }
      }
    }

    final from = fromPort.value;
    final to = toPort.value;

    batch(() {
      panEnabled.value = true;
      scaleEnabled.value = true;
      target.value = NoActionTarget();
      connection.value = null;
      fromPort.value = null;
      toPort.value = null;
    });

    if (from != null && to != null) {
      if (from == to) return;

      final fromNode = getNodeByPort(from);
      final toNode = getNodeByPort(to);

      if (fromNode != null && toNode != null) {
        if (fromNode.$1 == toNode.$1) {
          _toast('Cannot connect node to itself');
          return;
        }
        (Node, NodeWidgetInput)? input;
        (Node, NodeWidgetOutput)? output;
        if (fromNode.$2.port is NodeWidgetInput) {
          input = (fromNode.$1, fromNode.$2.port as NodeWidgetInput);
        }
        if (toNode.$2.port is NodeWidgetInput) {
          input = (toNode.$1, toNode.$2.port as NodeWidgetInput);
        }
        if (fromNode.$2.port is NodeWidgetOutput) {
          output = (fromNode.$1, fromNode.$2.port as NodeWidgetOutput);
        }
        if (toNode.$2.port is NodeWidgetOutput) {
          output = (toNode.$1, toNode.$2.port as NodeWidgetOutput);
        }
        if (input != null && output != null) {
          final prev = input.$2.knob.target.value;
          try {
            bool mismatch = false;
            if (input.$2.type != output.$2.type) {
              mismatch = true;
              for (final allowed in allowedConnections) {
                if ((output.$2.type == allowed.from || allowed.from == '*') &&
                    (input.$2.type == allowed.to || allowed.to == '*')) {
                  mismatch = false;
                  break;
                }
              }
              if (mismatch) {
                _toast('Type mismatch: ${output.$2.type} != ${input.$2.type}');
                return;
              }
            }
            if (!mismatch && output.$2.optional && !input.$2.optional) {
              _toast('Cannot connect nullable type to non-nullable type');
              return;
            }
            if (prev == output.$2.source) {
              return;
            }
            final cycle = _detectCycle(output, input);
            if (cycle) {
              _toast('Cycle detected');
              return;
            }
            connectKnobToSource(input, output);
            // input.$2.knob.source = prev;
          } catch (err) {
            if (err is StackOverflowError) {
              _toast('Cycle detected');
            } else {
              _toast('Error connecting types: $err');
            }
            return;
          }
        }
      }
    }
  }

  void connectKnobToSource(
    (Node, NodeWidgetInput) input,
    (Node, NodeWidgetOutput) output,
  ) {
    input.$2.knob.source = output.$2.source;
  }

  void disconnectKnobFromSource(
    Node node,
    NodeWidgetInput input,
  ) {
    input.knob.source = null;
  }

  static var allowedConnections = <({String from, String to})>[
    (from: '*', to: 'Object'),
    (from: 'int', to: 'num'),
    (from: 'double', to: 'num'),
    (from: 'String', to: 'Pattern'),
  ];

  bool _detectCycle(
    (Node, NodeWidgetOutput) output,
    (Node, NodeWidgetInput) input,
  ) {
    final graph = _graph();
    final path = graphs.shortestPath<Node>(
      output.$1,
      input.$1,
      (node) => graph[node] ?? [],
    );
    return path != null;
  }

  Map<Node, Iterable<Node>> _graph() {
    final graph = <Node, Iterable<Node>>{};
    for (final node in nodes) {
      graph.putIfAbsent(node, () {
        // Connected inputs
        final results = <Node>{};
        for (final item in node.inputsMetadata.value) {
          if (item.port.knob.readonly.value) {
            final result = nodes //
                .where((e) => e.outputs.value
                    .any((e) => e.source == item.port.knob.target.value));
            results.addAll(result);
          }
        }
        return results;
      });
    }
    return graph;
  }

  void _toast(String message) {
    final context = scaffoldKey.currentState!.context;
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(SnackBar(content: Text(message)));
  }

  Node? getNodeByKnob(Knob knob) {
    for (final node in nodes) {
      for (final input in node.inputs.value) {
        if (input.knob == knob) return node;
      }
    }
    return null;
  }

  (Node, PortMetadata)? getNodeByPort(PortMetadata port) {
    for (final node in nodes) {
      for (final input in node.inputsMetadata.value) {
        if (input.port == port.port) return (node, input);
      }
      for (final output in node.outputsMetadata.value) {
        if (output.port == port.port) return (node, output);
      }
    }
    return null;
  }

  void pan(Offset delta) {
    final matrix = transform.value.clone();
    matrix.translate(delta.dx, delta.dy);
    transform.value = matrix;
  }

  void panUp() => pan(const Offset(0, -10));
  void panDown() => pan(const Offset(0, 10));
  void panLeft() => pan(const Offset(-10, 0));
  void panRight() => pan(const Offset(10, 0));

  Offset getOffset() {
    final matrix = transform.value.clone();
    matrix.invert();
    final result = matrix.getTranslation();
    return Offset(result.x, result.y);
  }

  void zoom(double delta) {
    final matrix = transform.value.clone();
    final mouse = this.mouse.value;
    if (mouse != null) {
      final local = toLocal(mouse);
      matrix.translate(local.dx, local.dy);
    }
    matrix.scale(delta, delta);
    if (mouse != null) {
      final local = toLocal(mouse);
      matrix.translate(-local.dx, -local.dy);
    }
    transform.value = matrix;
  }

  void zoomIn() => zoom(1.1);
  void zoomOut() => zoom(0.9);

  double getScale() {
    final matrix = transform.value;
    final scaleX = matrix.getMaxScaleOnAxis();
    return scaleX;
  }

  late final maxSize = computed(() {
    Rect rect = Rect.zero;
    for (final child in nodes) {
      if (child is FallbackNode) continue;
      final childRect = child.rect$.value;
      if (childRect.isEmpty) continue;
      rect = Rect.fromLTRB(
        min(rect.left, childRect.left),
        min(rect.top, childRect.top),
        max(rect.right, childRect.right),
        max(rect.bottom, childRect.bottom),
      );
    }
    return rect;
  });

  void transformReset() => transform.value = Matrix4.identity();

  void onKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.shiftLeft ||
          event.logicalKey == LogicalKeyboardKey.shiftRight) {
        shiftPressed.value = true;
      }
      if (event.logicalKey == LogicalKeyboardKey.controlLeft ||
          event.logicalKey == LogicalKeyboardKey.controlRight) {
        controlPressed.value = true;
      }
      if (event.logicalKey == LogicalKeyboardKey.metaLeft ||
          event.logicalKey == LogicalKeyboardKey.metaRight) {
        metaPressed.value = true;
      }
      if (event.logicalKey == LogicalKeyboardKey.space) {
        spacePressed.value = true;
      }
    }
    if (event is KeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.shiftLeft ||
          event.logicalKey == LogicalKeyboardKey.shiftRight) {
        shiftPressed.value = false;
      }
      if (event.logicalKey == LogicalKeyboardKey.metaLeft ||
          event.logicalKey == LogicalKeyboardKey.metaRight) {
        metaPressed.value = false;
      }
      if (event.logicalKey == LogicalKeyboardKey.controlLeft ||
          event.logicalKey == LogicalKeyboardKey.controlRight) {
        controlPressed.value = false;
      }
      if (event.logicalKey == LogicalKeyboardKey.space) {
        spacePressed.value = false;
      }
      // if (event.logicalKey == LogicalKeyboardKey.delete ||
      //     event.logicalKey == LogicalKeyboardKey.backspace) {
      //   if (focusNode.hasFocus) {
      //     deleteSelection();
      //   }
      // }
    }
  }

  final controlPressed = signal(false);
  final metaPressed = signal(false);
  final spacePressed = signal(false);
  final shiftPressed = signal(false);
}

sealed class ActionTarget {}

class NoActionTarget extends ActionTarget {}

class ActionViewTarget extends ActionTarget {}

class ActionNodeTarget<Node extends GraphNode> extends ActionTarget {
  final Node node;
  final NodeSelectionPart part;
  ActionNodeTarget(this.node, this.part);
}

sealed class Selection {}

class NodeSelection<Node extends GraphNode> extends Selection {
  final Node node;
  final NodeSelectionPart part;
  final PortMetadata? port;
  NodeSelection(this.node, this.part, this.port);

  @override
  String toString() => 'NodeSelection($node, $part)';
}

enum NodeSelectionPart {
  header,
  body,
  connector,
}

class ConnectorSelection extends Selection {
  final ConnectorInput input;
  final ConnectorOutput output;
  ConnectorSelection(this.input, this.output);

  @override
  String toString() => 'ConnectorSelection($input, $output)';
}
