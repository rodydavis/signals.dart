import 'dart:math';

import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'nodes/base.dart';
import 'nodes/bitmap.dart';
import 'nodes/color.dart';
import 'nodes/compare.dart';
import 'nodes/datetime.dart';
import 'nodes/logic.dart';
import 'nodes/number.dart';
import 'nodes/reduce.dart';
import 'nodes/slider.dart';
import 'nodes/stepper.dart';
import 'nodes/switch.dart';
import 'nodes/text.dart';
import 'nodes/time.dart';
import 'widgets/node_edges.dart';
import 'widgets/node_layout.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  final nodes = mapSignal<Node, Offset>({});
  final selection = setSignal<Node>({});
  final matrix = ValueSignal(Matrix4.identity());
  final toolbox = signal(true);
  final draggableOffset = signal<Offset?>(null);
  final dragAccept = signal(false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    const toolboxHeight = 200.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Node Based Editor'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_in),
            tooltip: 'Zoom In',
            onPressed: () => matrix.forceUpdate(matrix.value
              ..translate(size.width / 2, size.height / 2)
              ..scale(1.1, 1.1)
              ..translate(-(size.width / 2), -(size.height / 2))),
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            tooltip: 'Zoom Out',
            onPressed: () => matrix.forceUpdate(matrix.value
              ..translate(size.width / 2, size.height / 2)
              ..scale(0.9, 0.9)
              ..translate(-(size.width / 2), -(size.height / 2))),
          ),
          Watch((context) {
            return IconButton(
              onPressed: () => toolbox.set(!toolbox()),
              icon: Icon(toolbox() ? Icons.visibility_off : Icons.visibility),
              tooltip: toolbox() ? 'Hide Toolbox' : 'Show Toolbox',
            );
          }),
        ],
      ),
      body: Watch.builder(
        builder: (context) => Stack(
          children: [
            Positioned.fill(
              child: SizedBox.expand(
                child: CustomPaint(
                  painter: NodeEdges(matrix(), nodes, selection),
                  child: CustomMultiChildLayout(
                    delegate: NodeLayout(matrix(), nodes),
                    children: [
                      for (final node in nodes.keys)
                        LayoutId(
                          id: node.id,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: renderNode(node, const TextStyle(), true),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: kThemeAnimationDuration,
              bottom: (toolbox() ? toolboxHeight : 0) + 10,
              right: 10,
              child: Text(
                'Nodes: ${nodes.length}',
                textAlign: TextAlign.end,
              ),
            ),
            AnimatedPositioned(
              duration: kThemeAnimationDuration,
              bottom: toolbox() ? 0 : -toolboxHeight,
              height: toolboxHeight,
              width: size.width,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    top: 40,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      nodePreview(size, () => NumberNode(0)),
                      nodePreview(size, () => StepperNode(0)),
                      nodePreview(size, () => ColorNode(Colors.blue.value)),
                      nodePreview(size, () => SliderNode(0.5)),
                      nodePreview(size, () => SwitchNode(true)),
                      nodePreview(size, () => TextNode('Hello World')),
                      nodePreview(size, () => DateTimeNode(DateTime.now())),
                      nodePreview(size, () => TimeOfDayNode(TimeOfDay.now())),
                      nodePreview(size, () => BitmapNode()),
                      if (selection.length > 1) ...[
                        if (selection.length == 2 &&
                            selection
                                .toList()
                                .every((e) => e is Node<dynamic, bool>)) ...[
                          nodePreview(size, () {
                            final list =
                                selection.toList().cast<Node<dynamic, bool>>();
                            return LogicNode(
                              BitwiseOperator.and,
                              list[0],
                              list[1],
                            );
                          }),
                        ],
                        if (selection
                            .toList()
                            .every((e) => e is Node<dynamic, num>)) ...[
                          nodePreview(size, () {
                            final list =
                                selection.toList().cast<Node<dynamic, num>>();
                            final node = ReduceNode(Reducer.add, list);
                            return node;
                          }),
                          if (selection.length == 2) ...[
                            nodePreview(size, () {
                              final list = selection.cast<Node<dynamic, num>>();
                              final node = CompareNode(
                                Operator.equalTo,
                                list.first,
                                list.last,
                              );
                              return node;
                            }),
                          ],
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ),
            if (draggableOffset.value != null)
              Positioned.fill(
                bottom: toolbox() ? toolboxHeight : 0,
                child: SizedBox.expand(
                  child: DragTarget<Node>(
                    builder: (context, candidateData, rejectedData) =>
                        Container(
                      color: () {
                        final colors = Theme.of(context).colorScheme;
                        final color =
                            dragAccept() ? colors.primary : colors.background;
                        return color.withOpacity(0.1);
                      }(),
                    ),
                    onWillAccept: (data) {
                      dragAccept.value = data != null;
                      return dragAccept();
                    },
                    onLeave: (_) {
                      dragAccept.value = false;
                    },
                    onAccept: (data) {
                      nodes[data] = draggableOffset()!;
                      selection.clear();
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget nodePreview(
    Size size,
    Node Function() cb, {
    Offset Function()? offset,
  }) {
    final data = cb();
    final child = Material(
      color: Colors.transparent,
      child: AbsorbPointer(
        child: Builder(builder: (context) {
          return renderNode(
            data,
            TextStyle(
              color: Theme.of(context).colorScheme.onInverseSurface,
            ),
            false,
          );
        }),
      ),
    );
    return Tooltip(
      message: data.name,
      child: Draggable<Node>(
        feedback: child,
        data: cb(),
        onDragStarted: () {
          draggableOffset.set(null);
        },
        onDraggableCanceled: (velocity, details) {
          draggableOffset.set(null);
        },
        onDragUpdate: (details) {
          draggableOffset.set(details.localPosition);
        },
        onDragEnd: (details) {
          draggableOffset.set(details.offset);
        },
        onDragCompleted: () {
          draggableOffset.set(null);
        },
        child: child,
      ),
    );
  }

  Widget renderNode(
    Node node,
    TextStyle style,
    bool circles,
  ) {
    return SizedBox.fromSize(
      size: node.size(),
      child: Container(
        decoration: BoxDecoration(
          color: selection.contains(node)
              ? Colors.lightBlue.shade100
              : Colors.grey.shade300,
          border: Border.all(
            color: selection.contains(node) ? Colors.lightBlue : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanUpdate: (details) {
            nodes[node] = nodes[node]! + details.delta;
          },
          onTap: () {
            if (selection.contains(node)) {
              selection.remove(node);
            } else {
              selection.add(node);
            }
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: circles ? node.buildWithNodes() : node.build(),
              ),
              Positioned(
                top: -25,
                left: 0,
                child: Text(node.name, style: style),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Rect _biggestRect(List<Rect> rects) {
  if (rects.isEmpty) return Rect.zero;
  var rect = rects.first;
  for (var i = 1; i < rects.length; i++) {
    rect = Rect.fromLTRB(
      min(rect.left, rects[i].left),
      min(rect.top, rects[i].top),
      max(rect.right, rects[i].right),
      max(rect.bottom, rects[i].bottom),
    );
  }
  return rect;
}
