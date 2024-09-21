// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart' hide TransformationController;
import 'package:flutter/services.dart';
import 'package:signals/signals_flutter.dart';

import 'knobs.dart';
import 'mixins/mutable.dart';
import 'mixins/pan_and_zoom.dart';
import 'node.dart';
import 'utils/get_distance.dart';
import 'widgets/background_painter.dart';
import 'widgets/interactive_viewer.dart';

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

abstract class BaseGraph<Node extends GraphNode> {
  BaseGraph({
    List<Node>? nodes,
    TransformationController? controller,
    FocusNode? keyboardFocusNode,
    double minScale = 0.4,
    double maxScale = 4,
  })  : nodes = nodes = listSignal<Node>(nodes ?? []),
        keyboardFocusNode = keyboardFocusNode ?? FocusNode(),
        controller = controller ?? TransformationController(Matrix4.identity()),
        minScale = signal<double>(minScale),
        maxScale = signal<double>(maxScale);

  final FocusNode keyboardFocusNode;
  final ListSignal<Node> nodes;
  final TransformationController controller;
  late final transform = valueNotifierToSignal(controller);
  final Signal<double> minScale;
  final Signal<double> maxScale;
  final panEnabled = signal(true);
  final scaleEnabled = signal(true);
  final viewport = signal<Size>(Size.zero);
  final mouse = signal<Offset?>(null);
  final controlPressed = signal(false);
  final metaPressed = signal(false);
  final spacePressed = signal(false);
  final shiftPressed = signal(false);

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

  Size getSize() => viewport.value * getScale();
  Rect getRect() => getOffset() & getSize();
  Offset getCenter() => getRect().center;

  void onInteractionStart(ScaleStartDetails event) {}

  void onInteractionUpdate(ScaleUpdateDetails event) {}

  void onInteractionEnd(ScaleEndDetails event) {}

  Map<Node, Iterable<Node>> toGraph() {
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

  (Offset, Iterable<Selection>) pointDetails(Offset point) {
    final local = fromLocal(point);
    final list = hitTest(local);
    return (local, list);
  }

  double getScale() {
    final matrix = transform.value;
    final scaleX = matrix.getMaxScaleOnAxis();
    return scaleX;
  }

  Offset getOffset() {
    final matrix = transform.value.clone();
    matrix.invert();
    final result = matrix.getTranslation();
    return Offset(result.x, result.y);
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

  Node? getNodeByKnob(Knob knob) {
    for (final node in nodes) {
      for (final input in node.inputs.value) {
        if (input.knob == knob) return node;
      }
    }
    return null;
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

  late Computed<Rect> viewRect = computed(() {
    var viewRect = Offset.zero & viewport.value;
    // viewRect = MatrixUtils.transformRect(transform(), viewRect);
    // viewRect = MatrixUtils.inverseTransformRect(transform(), viewRect);
    return viewRect;
  });

  bool nodeVisible(Node node) {
    var viewRect = this.viewRect();
    var nodeRect = node.rect$.value;
    nodeRect = MatrixUtils.transformRect(transform(), nodeRect);
    // print('VIEW: ${viewRect.topLeft} ${viewRect.size}');
    // print('NODE: ${nodeRect.topLeft} ${nodeRect.size}');
    final visible = nodeRect.overlaps(viewRect);
    // print('VISIBLE: $visible');
    return visible;
  }
}

class Graph<Node extends GraphNode> extends BaseGraph<Node>
    with PanAndZoomMixin<Node>, MutableGraphMixin<Node> {
  bool lazyRender = true;
}

sealed class ActionTarget {}

class NoActionTarget extends ActionTarget {}

class ActionViewTarget extends ActionTarget {}

class ActionNodesTarget<Node extends GraphNode> extends ActionTarget {
  final List<Node> nodes;
  ActionNodesTarget(this.nodes);
}

class ActionNodeTarget<Node extends GraphNode> extends ActionTarget {
  final Node node;
  final NodeSelectionPart part;
  ActionNodeTarget(this.node, this.part);
}

sealed class Selection {}

// class MultiNodeSelection<Node extends GraphNode> extends Selection {
//   final List<Node> nodes;
//   MultiNodeSelection(this.nodes);

//   @override
//   String toString() => 'MultiNodeSelection($nodes)';
// }

class NodeSelection<Node extends GraphNode> extends Selection {
  final Node node;
  final NodeSelectionPart part;
  final PortMetadata? port;
  NodeSelection(this.node, this.part, this.port);

  @override
  String toString() => 'NodeSelection($node, $part)';

  @override
  bool operator ==(covariant NodeSelection<Node> other) {
    if (identical(this, other)) return true;

    return other.node == node && other.part == part && other.port == port;
  }

  @override
  int get hashCode => node.hashCode ^ part.hashCode ^ port.hashCode;
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

  @override
  bool operator ==(covariant ConnectorSelection other) {
    if (identical(this, other)) return true;

    return other.input == input && other.output == output;
  }

  @override
  int get hashCode => input.hashCode ^ output.hashCode;
}
