import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'code.dart';
import 'nodes/base.dart';
import 'nodes/bitmap.dart';
import 'nodes/boolean.dart';
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
import 'nodes/trigger.dart';
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
  final pressed = setSignal<Node>({});
  final matrix = Signal(Matrix4.identity());
  final toolbox = signal(true);
  final draggableOffset = signal<Offset?>(null);
  final dragAccept = signal(false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    const toolboxHeight = 200.0;
    return DropdownButtonHideUnderline(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Node Based Editor'),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.zoom_in),
              tooltip: 'Zoom In',
              onPressed: () => matrix.set(
                  force: true,
                  matrix.value
                    ..translate(size.width / 2, size.height / 2)
                    ..scale(1.1, 1.1)
                    ..translate(-(size.width / 2), -(size.height / 2))),
            ),
            IconButton(
              icon: const Icon(Icons.zoom_out),
              tooltip: 'Zoom Out',
              onPressed: () => matrix.set(
                  force: true,
                  matrix.value
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
            Watch((context) {
              if (selection.isEmpty) return const SizedBox.shrink();
              return IconButton(
                onPressed: () => selection.clear(),
                icon: const Icon(Icons.clear),
                tooltip: 'Clear selection',
              );
            }),
            Watch((context) {
              if (nodes.isEmpty) return const SizedBox.shrink();
              return IconButton(
                onPressed: () {
                  selection.clear();
                  nodes.clear();
                },
                icon: const Icon(Icons.clear_all),
                tooltip: 'Clear all nodes',
              );
            }),
          ],
        ),
        body: Watch.builder(
          builder: (context) => Stack(
            children: [
              Positioned.fill(
                child: CodeView(
                  nodes: nodes.keys.toList(),
                  selected: selection(),
                ),
              ),
              Positioned.fill(
                child: SizedBox.expand(
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      matrix.set(
                          force: true,
                          matrix.value
                            ..translate(details.delta.dx, details.delta.dy));
                    },
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
                                child: renderNode(
                                  node,
                                  const TextStyle(),
                                  true,
                                ),
                              ),
                            ),
                        ],
                      ),
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
                      spacing: 40,
                      runSpacing: 40,
                      children: [
                        if (selection.isNotEmpty) ...[
                          if (selection.length == 1) ...[
                            nodePreview(
                              size,
                              () => DynamicToText.fromSource(selection.first),
                            ),
                            if (selection.first is Node<dynamic, bool>) ...[
                              nodePreview(
                                size,
                                () => SwitchNode.fromSource(
                                    selection.first as Node<dynamic, bool>),
                              ),
                              nodePreview(
                                size,
                                () => NegatedBooleanNode.fromSource(
                                    selection.first as Node<dynamic, bool>),
                              ),
                              nodePreview(
                                size,
                                () => BitmapNode.fromSource(
                                  sources: [
                                    selection.first as Node<dynamic, bool>
                                  ],
                                  crossAxisCount: 1,
                                ),
                              ),
                            ],
                            if (selection.first is Node<dynamic, num>) ...[
                              nodePreview(
                                size,
                                () => NumberNode.fromSource(
                                    selection.first as Node<dynamic, num>),
                              ),
                              nodePreview(
                                size,
                                () => RoundNumberNode.fromSource(
                                    selection.first as Node<dynamic, num>),
                              ),
                              nodePreview(
                                size,
                                () => CeilNumberNode.fromSource(
                                    selection.first as Node<dynamic, num>),
                              ),
                              nodePreview(
                                size,
                                () => FloorNumberNode.fromSource(
                                    selection.first as Node<dynamic, num>),
                              ),
                              nodePreview(
                                size,
                                () => AbsNumberNode.fromSource(
                                    selection.first as Node<dynamic, num>),
                              ),
                              nodePreview(
                                size,
                                () => NumberToInt.fromSource(
                                    selection.first as Node<dynamic, num>),
                              ),
                              nodePreview(
                                size,
                                () => NumberToDouble.fromSource(
                                    selection.first as Node<dynamic, num>),
                              ),
                            ],
                            if (selection.first is Node<dynamic, int>) ...[
                              nodePreview(
                                size,
                                () => IntNode.fromSource(
                                    selection.first as Node<dynamic, int>),
                              ),
                              nodePreview(
                                size,
                                () => IntToBoolean.fromSource(
                                    selection.first as Node<dynamic, int>),
                              ),
                              nodePreview(
                                size,
                                () => BitLengthNumberNode.fromSource(
                                    selection.first as Node<dynamic, int>),
                              ),
                            ],
                            if (selection.first is Node<dynamic, double>) ...[
                              nodePreview(
                                size,
                                () => DoubleNode.fromSource(
                                    selection.first as Node<dynamic, double>),
                              ),
                            ],
                            if (selection.first is Node<dynamic, double>) ...[
                              if ((selection.first as Node<dynamic, double>)
                                          .output
                                          .value >=
                                      0 &&
                                  (selection.first as Node<dynamic, double>)
                                          .output
                                          .value <=
                                      1)
                                nodePreview(
                                  size,
                                  () => SliderNode.fromSource(
                                      selection.first as Node<dynamic, double>),
                                ),
                            ],
                            if (selection.first is Node<dynamic, String>) ...[
                              nodePreview(
                                size,
                                () => TextNode.fromSource(
                                    selection.first as Node<dynamic, String>),
                              ),
                            ],
                          ],
                          if (selection.length > 1) ...[
                            if (selection.length == 2 &&
                                () {
                                  final list = selection.toList();
                                  final trigger =
                                      list[1] is Node<dynamic, Object>;
                                  return trigger;
                                }()) ...[
                              nodePreview(size, () {
                                final list = selection.toList();
                                final val = list[0];
                                final trigger =
                                    list[1] as Node<dynamic, Object>;
                                return DynamicToTextOnTrigger.fromSource(
                                  val,
                                  trigger,
                                );
                              }),
                            ],
                            if (selection.length == 2 &&
                                () {
                                  final list = selection.toList();
                                  final inc = list[0] is Node<dynamic, Object>;
                                  final dec = list[1] is Node<dynamic, Object>;
                                  return inc && dec;
                                }()) ...[
                              nodePreview(size, () {
                                final list = selection.toList();
                                final inc = list[0] as Node<dynamic, Object>;
                                final dec = list[1] as Node<dynamic, Object>;
                                return StepperNode.fromTriggers(
                                  0,
                                  increment: inc,
                                  decrement: dec,
                                );
                              }),
                            ],
                            if (selection.length == 3 &&
                                () {
                                  final list = selection.toList();
                                  final val = list[0] is Node<dynamic, bool>;
                                  final off = list[1] is Node<dynamic, Color>;
                                  final on = list[2] is Node<dynamic, Color>;
                                  return val && off && on;
                                }()) ...[
                              nodePreview(size, () {
                                final list = selection.toList();
                                final val = list[0] as Node<dynamic, bool>;
                                final off = list[1] as Node<dynamic, Color>;
                                final on = list[2] as Node<dynamic, Color>;
                                return BitmapNode.fromSource(
                                  sources: [val],
                                  crossAxisCount: 1,
                                  offColor: off,
                                  onColor: on,
                                );
                              }),
                            ],
                            if (selection.length == 4 &&
                                () {
                                  final list = selection.toList();
                                  final r = list[0] is Node<dynamic, int>;
                                  final g = list[1] is Node<dynamic, int>;
                                  final b = list[2] is Node<dynamic, int>;
                                  final o = list[3] is Node<dynamic, double>;
                                  return r && g && b && o;
                                }()) ...[
                              nodePreview(size, () {
                                final list = selection.toList();
                                final r = list[0] as Node<dynamic, int>;
                                final g = list[1] as Node<dynamic, int>;
                                final b = list[2] as Node<dynamic, int>;
                                final o = list[3] as Node<dynamic, double>;
                                return ColorNode.fromRGBO(r, g, b, o);
                              }),
                            ],
                            if (selection.length == 2 &&
                                selection.toList().every(
                                    (e) => e is Node<dynamic, bool>)) ...[
                              nodePreview(size, () {
                                final list = selection
                                    .toList()
                                    .cast<Node<dynamic, bool>>();
                                return LogicNode(
                                  BitwiseOperator.and,
                                  list[0],
                                  list[1],
                                );
                              }),
                            ],
                            if (selection
                                .toList()
                                .every((e) => e is Node<dynamic, bool>)) ...[
                              nodePreview(size, () {
                                final list = selection
                                    .toList()
                                    .cast<Node<dynamic, bool>>();
                                final node = BitmapNode.fromSource(
                                  sources: list,
                                  crossAxisCount: 3, // square?
                                );
                                return node;
                              }),
                            ],
                            if (selection
                                .toList()
                                .every((e) => e is Node<dynamic, num>)) ...[
                              nodePreview(size, () {
                                final list = selection
                                    .toList()
                                    .cast<Node<dynamic, num>>();
                                final node = ReduceNode(Reducer.add, list);
                                return node;
                              }),
                              if (selection.length == 2) ...[
                                nodePreview(size, () {
                                  final list =
                                      selection.cast<Node<dynamic, num>>();
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
                        ] else ...[
                          nodePreview(size, () => SwitchNode(true)),
                          nodePreview(size, () => NumberNode(0)),
                          nodePreview(size, () => IntNode(0)),
                          nodePreview(size, () => DoubleNode(0)),
                          nodePreview(size, () => SliderNode(0.5)),
                          nodePreview(
                              size,
                              () => IntSliderNode(
                                    0,
                                    name: 'Int Slider',
                                    min: 0,
                                    max: 255,
                                  )),
                          nodePreview(size, () => TextNode('Hello World')),
                          nodePreview(size, () => StepperNode(0)),
                          nodePreview(size, () => ColorNode(Colors.blue)),
                          nodePreview(size, () => DateTimeNode(DateTime.now())),
                          nodePreview(
                              size, () => TimeOfDayNode(TimeOfDay.now())),
                          nodePreview(size, () => BitmapNode.grid9()),
                          nodePreview(size, () => BooleanNode(true)),
                          nodePreview(size, () => CurrentTimeNode()),
                          nodePreview(size, () => TriggerNode(Object())),
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
                              dragAccept() ? colors.primary : colors.surface;
                          return color.withOpacity(0.1);
                        }(),
                      ),
                      onWillAcceptWithDetails: (details) {
                        // ignore: unnecessary_null_comparison
                        dragAccept.value = details.data != null;
                        return dragAccept();
                      },
                      onLeave: (_) {
                        dragAccept.value = false;
                      },
                      onAcceptWithDetails: (details) {
                        nodes[details.data] = draggableOffset()!;
                        selection.clear();
                      },
                    ),
                  ),
                ),
            ],
          ),
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

  Widget renderNode(Node node, TextStyle style, bool circles) {
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
            if (!circles) return;
            if (pressed.contains(node)) {
              nodes[node] = nodes[node]! + details.delta;
            }
          },
          onTap: () {
            if (!circles) return;
            if (selection.contains(node)) {
              selection.remove(node);
            } else {
              selection.add(node);
            }
          },
          onPanDown: (details) {
            pressed.add(node);
          },
          onPanEnd: (details) {
            pressed.remove(node);
          },
          onPanCancel: () {
            pressed.remove(node);
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
                width: node.size().width,
                child: Text(
                  node.name,
                  style: style,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
