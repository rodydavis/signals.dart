import 'package:flutter/widgets.dart';
import 'package:signals/signals.dart';

import '../utils/graph.dart';
import '../graph.dart';
import '../node.dart';

mixin MutableGraphMixin<Node extends GraphNode> on BaseGraph<Node> {
  final fromPort = signal<PortMetadata?>(null);
  final toPort = signal<PortMetadata?>(null);
  final connection = signal<(Offset, Offset)?>(null);
  final target = signal<ActionTarget>(NoActionTarget());
  final mouse = signal<Offset?>(null);
  final _scale = signal(0.0);

  final _errorMessage = signal("");
  ReadonlySignal<String> get errorMessage => _errorMessage;

  final _selection = setSignal<Selection>({});
  ReadonlySignal<Set<Selection>> get selection => _selection;
  Iterable<Node> get _selectedNodes =>
      selection.value.whereType<NodeSelection<Node>>().map((e) => e.node);

  void clearSelection() {
    _selection.clear();
    keyboardFocusNode.requestFocus();
  }

  void setSelection(Iterable<Selection> items, {bool clear = true}) {
    if (clear) {
      _selection.value = items.toSet();
    } else {
      _selection.addAll(items);
    }
  }

  void add(Node node, {bool center = false}) {
    if (center) node.offset$.value = getCenter();
    nodes.add(node);
  }

  void removeConnector(ConnectorInput target) {
    clearSelection();
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
    clearSelection();
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

  void onInteractionStart(ScaleStartDetails event) {
    super.onInteractionStart(event);
    keyboardFocusNode.requestFocus();
    locked.value = true;
    final (local, list) = pointDetails(event.localFocalPoint);
    batch(() {
      if (list.isEmpty || event.pointerCount == 2) {
        target.value = ActionViewTarget();
        clearSelection();
      } else {
        final top = list.last;
        final multi = shiftPressed();
        setSelection([top], clear: !multi);
        if (top is NodeSelection) {
          if (multi) {
            target.value = ActionNodesTarget(_selectedNodes.toList());
          } else {
            if (top.part == NodeSelectionPart.connector) {
              fromPort.value = top.port;
              toPort.value = null;
              connection.value = (local, local);
            }
            target.value = ActionNodeTarget(top.node, top.part);
          }
        }
        panEnabled.value = false;
        scaleEnabled.value = false;
      }
      mouse.value = local;
    });
  }

  void onInteractionUpdate(ScaleUpdateDetails event) {
    super.onInteractionUpdate(event);
    // debugPrint(event.toString());
    mouse.value = event.localFocalPoint;
    final (local, _) = pointDetails(event.localFocalPoint);
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
    } else if (target is ActionNodesTarget) {
      batch(() {
        final delta = event.focalPointDelta / getScale();
        for (final item in target.nodes) {
          item.offset$.value += delta;
        }
      });
    }
  }

  void onInteractionEnd(ScaleEndDetails event) {
    super.onInteractionEnd(event);
    keyboardFocusNode.requestFocus();
    locked.value = false;
    // debugPrint(event.toString());
    // mouse.value = null;
    if (fromPort.value != null) {
      final (local, list) = pointDetails(mouse.value!);
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
          setError('Cannot connect node to itself');
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
                setError(
                    'Type mismatch: ${output.$2.type} != ${input.$2.type}');
                return;
              }
            }
            if (!mismatch && output.$2.optional && !input.$2.optional) {
              setError('Cannot connect nullable type to non-nullable type');
              return;
            }
            if (prev == output.$2.source) {
              return;
            }
            final graph = toGraph();
            final cycle = graph.connectionWillCauseCycle(output, input);
            if (cycle) {
              setError('Cycle detected');
              return;
            }
            connectKnobToSource(input, output);
            // input.$2.knob.source = prev;
          } catch (err) {
            if (err is StackOverflowError) {
              setError('Cycle detected');
            } else {
              setError('Error connecting types: $err');
            }
            return;
          }
        }
      }
    }
  }

  var allowedConnections = <({String from, String to})>[
    (from: '*', to: 'Object'),
    (from: 'int', to: 'num'),
    (from: 'double', to: 'num'),
    (from: 'String', to: 'Pattern'),
  ];

  void setError(String msg) {
    _errorMessage.value = msg;
  }
}
