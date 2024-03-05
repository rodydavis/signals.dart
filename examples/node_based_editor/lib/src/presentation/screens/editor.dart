import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals_flutter.dart';

import '../../generated/menus/bool.dart';
import '../../generated/menus/double.dart';
import '../../generated/menus/int.dart';
import '../../generated/menus/math.dart';
import '../../generated/menus/num.dart';
import '../../generated/menus/object.dart';
import '../../generated/menus/pattern.dart';
import '../../generated/menus/regex.dart';
import '../../generated/menus/string.dart';
import '../../generated/nodes/base_node.dart';
import '../widgets/actions.dart';
import '../widgets/connector_painter.dart';
import '../widgets/menus.dart';
import '../widgets/node_edges_painter.dart';
import '../widgets/node_layout_delegate.dart';
import '../widgets/render_node.dart';
import 'app.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  final nodes = listSignal<BaseNode>([]);
  final selection = setSignal<BaseNode>({});
  final hovered = setSignal<BaseNode>({});
  final dragging = setSignal<BaseNode>({});
  final scale = signal(1.0);
  final connectStart = signal<Offset?>(null);
  final connectEnd = signal<Offset?>(null);
  final inputTarget = signal<(BaseNode, String)?>(null);
  final outputTarget = signal<(BaseNode, String)?>(null);
  final matrix = signal(Matrix4.identity());
  final target = signal<BaseNode?>(null);
  int lastId = 0;

  BaseNode? getNode(int id) {
    return nodes.firstWhereOrNull((e) => e.id == id);
  }

  void onCreateNode(BaseNode Function(int id) create) {
    final node = create(++lastId);
    node.getNode = getNode;
    nodes.add(node);
  }

  void deleteSelection() async {
    if (selection.isNotEmpty) {
      if (await confirm(
        context,
        content: 'Delete ${selection.length} nodes?',
      )) {
        for (final node in selection) {
          deleteNode(node);
        }
        selection.clear();
      }
    }
  }

  void deleteNode(BaseNode node) {
    // Delete connected outputs
    for (final target in nodes) {
      if (target.id == node.id) continue;
      for (final input in target.inputs.entries) {
        if (input.value.link == null) continue;
        if (input.value.link!.nodeId == node.id) {
          target.inputs[input.key] = (link: null, value: input.value.value);
        }
      }
    }
    nodes.remove(node);
    resetUiState();
  }

  void resetUiState() {
    selection.clear();
    hovered.clear();
    dragging.clear();
    connectStart.value = null;
    connectEnd.value = null;
  }

  List<BaseNode> overlappingNodes(
    Offset localPosition, {
    bool inputs = false,
    bool outputs = false,
    bool moveable = false,
  }) {
    final pointRect = localPosition & const Size.square(1);
    return nodes().where((it) {
      final rect = it.rect(
        withInputs: inputs,
        withOutputs: inputs,
        moveable: moveable,
      );
      final transformedRect = MatrixUtils.transformRect(
        matrix(),
        rect,
      );
      return transformedRect.overlaps(pointRect);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      this.prefs = prefs;
      load().ignore();
    });
  }

  static const String _key = 'temp';
  late SharedPreferences prefs;

  Future<void> save() async {
    const encoder = JsonEncoder.withIndent(' ');
    final source = nodes.value.map((e) => jsonDecode(e.toJson())).toList();
    final result = encoder.convert(source);
    await prefs.setString(_key, result);
  }

  Future<void> load() async {
    final file = prefs.getString(_key);
    if (file == null) return;
    await open(file);
  }

  Future<void> open(String src) async {
    resetUiState();
    nodes.clear();
    if (src.trim().isEmpty) return;
    final json = jsonDecode(src);
    if (json is List) {
      final data = json.cast<Map<String, Object?>>();
      nodes.value = data.map((e) {
        final n = BaseNode.fromMap(e);
        n.getNode = getNode;
        return n;
      }).toList();
      if (nodes.isNotEmpty) {
        lastId = nodes.reduce((a, b) => a.id > b.id ? a : b).id + 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Watch.builder(
      builder: (context) {
        final size = MediaQuery.sizeOf(context);
        return Scaffold(
          body: Menus(
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PopupMenuButton<ThemeMode>(
                  icon: const Icon(Icons.brightness_4),
                  initialValue: themeMode.watch(context),
                  itemBuilder: (context) => [
                    for (final mode in ThemeMode.values)
                      PopupMenuItem(
                        value: mode,
                        child: Text(mode.name),
                      ),
                  ],
                  onSelected: themeMode.set,
                ),
              ],
            ),
            entries: [
              MenuEntry(
                label: 'Create',
                menuChildren: [
                  boolMenus(onCreateNode),
                  doubleMenus(onCreateNode),
                  intMenus(onCreateNode),
                  mathMenus(onCreateNode),
                  numMenus(onCreateNode),
                  patternMenus(onCreateNode),
                  regexMenus(onCreateNode),
                  stringMenus(onCreateNode),
                  objectMenus(onCreateNode),
                ],
              ),
              if (selection.isNotEmpty)
                MenuEntry(
                  label: 'Selection',
                  menuChildren: [
                    MenuEntry(
                      label: 'Move Forward',
                      onPressed: () {
                        final entries = nodes.toList();
                        final selection = this.selection.toList();
                        int idx = 0;
                        while (idx < entries.length) {
                          final entry = entries[idx];
                          if (selection.contains(entry)) {
                            final next = idx + 1;
                            if (next < entries.length) {
                              final nextEntry = entries[next];
                              entries[idx] = nextEntry;
                              entries[next] = entry;
                            }
                          }
                          idx++;
                        }
                        nodes.value = entries;
                      },
                    ),
                    MenuEntry(
                      label: 'Bring to Front',
                      onPressed: () {
                        final entries = nodes.toList();
                        final selection = this.selection.toList();
                        entries.removeWhere((e) => selection.contains(e));
                        entries.addAll(selection);
                        nodes.value = entries;
                      },
                    ),
                    MenuEntry(
                      label: 'Move Backwards',
                      onPressed: () {
                        final entries = nodes.toList();
                        final selection = this.selection.toList();
                        int idx = 0;
                        while (idx < entries.length) {
                          final entry = entries[idx];
                          if (selection.contains(entry)) {
                            final prev = idx - 1;
                            if (prev >= 0) {
                              final prevEntry = entries[prev];
                              entries[idx] = prevEntry;
                              entries[prev] = entry;
                            }
                          }
                          idx++;
                        }
                        nodes.value = entries;
                      },
                    ),
                    MenuEntry(
                      label: 'Send to Back',
                      onPressed: () {
                        final entries = nodes.toList();
                        final selection = this.selection.toList();
                        entries.removeWhere((e) => selection.contains(e));
                        entries.insertAll(0, selection);
                        nodes.value = entries;
                      },
                    ),
                    MenuEntry(
                      label: 'Delete Selection',
                      onPressed: deleteSelection,
                    ),
                  ],
                ),
              MenuEntry(
                label: 'View',
                menuChildren: [
                  MenuEntry(
                    label: 'Zoom In',
                    onPressed: () {
                      matrix.set(
                        matrix()
                          ..translate(size.width / 2, size.height / 2)
                          ..scale(1.1)
                          ..translate(-(size.width / 2), -(size.height / 2)),
                        force: true,
                      );
                      scale.value = scale() * 1.1;
                    },
                  ),
                  MenuEntry(
                    label: 'Zoom Out',
                    onPressed: () {
                      matrix.set(
                        matrix()
                          ..translate(size.width / 2, size.height / 2)
                          ..scale(0.9)
                          ..translate(-(size.width / 2), -(size.height / 2)),
                        force: true,
                      );
                      scale.value = scale() * 0.9;
                    },
                  ),
                ],
              ),
              if (kDebugMode)
                MenuEntry(
                  label: 'Debug',
                  menuChildren: [
                    MenuEntry(
                      label: 'Print Nodes to Json',
                      onPressed: () {
                        const encoder = JsonEncoder.withIndent(' ');
                        final source = nodes.value
                            .map((e) => jsonDecode(e.toJson()))
                            .toList();
                        // ignore: avoid_print
                        print(encoder.convert(source));
                      },
                    ),
                    MenuEntry(
                      label: 'Save',
                      onPressed: save,
                    ),
                    MenuEntry(
                      label: 'Load',
                      onPressed: load,
                    ),
                    MenuEntry(
                      label: 'Reset',
                      onPressed: () {
                        resetUiState();
                        nodes.clear();
                        save();
                      },
                    ),
                  ],
                ),
            ],
            child: SizedBox.expand(
              child: Listener(
                onPointerHover: (details) {
                  final overlaps = overlappingNodes(details.localPosition);
                  hovered.value = overlaps.toSet();
                },
                onPointerPanZoomStart: (details) {
                  scale.value = 1;
                },
                onPointerPanZoomUpdate: (details) {
                  final scale = details.scale;
                  if (scale == 1) {
                    final mScale = matrix().getMaxScaleOnAxis();
                    final pan = details.localPanDelta / mScale;
                    matrix.set(matrix()..translate(pan.dx, pan.dy),
                        force: true);
                  } else {
                    final scaleDelta = scale / this.scale.value;
                    this.scale.value = scale;
                    final pointRect = MatrixUtils.inverseTransformRect(
                      matrix(),
                      details.localPosition & const Size.square(1),
                    );
                    final point = pointRect.topLeft;
                    matrix.set(
                      matrix()
                        ..translate(point.dx, point.dy)
                        ..scale(scaleDelta, scaleDelta)
                        ..translate(-point.dx, -point.dy),
                      force: true,
                    );
                  }
                },
                onPointerMove: (details) {
                  final scale = matrix().getMaxScaleOnAxis();
                  final delta = details.delta / scale;
                  batch(() {
                    if (dragging.isNotEmpty) {
                      final items = {
                        ...dragging,
                        if (dragging.any(selection.contains) &&
                            isShiftPressed())
                          ...selection,
                      };
                      for (final node in items) {
                        final offset = node.offset.value;
                        node.offset.value = (
                          dx: offset.dx + delta.dx,
                          dy: offset.dy + delta.dy,
                        );
                      }
                    } else {
                      connectEnd.value = details.localPosition;
                    }
                  });
                },
                onPointerDown: (details) {
                  final moveableOverlaps = overlappingNodes(
                    details.localPosition,
                    moveable: true,
                  );
                  if (moveableOverlaps.isNotEmpty) {
                    final top = moveableOverlaps.last;
                    dragging.value = {top};
                  } else {
                    dragging.clear();
                    // Look up if connector will be on a node input/output
                    final overlaps = overlappingNodes(
                      details.localPosition,
                      inputs: true,
                      outputs: true,
                    );
                    if (overlaps.isNotEmpty) {
                      final top = overlaps.last;
                      final point = MatrixUtils.inverseTransformRect(
                        matrix(),
                        details.localPosition & const Size.square(1),
                      );
                      if (top.expanded()) {
                        final local = point.topLeft - top.toOffset();
                        final localRect = local & const Size.square(1);
                        final inputIdx = top.inputIndexForOffset(localRect);
                        final outputIdx = top.outputIndexForOffset(localRect);
                        if (inputIdx != -1 || outputIdx != -1) {
                          connectStart.value = details.localPosition;
                          connectEnd.value = details.localPosition;
                          inputTarget.value = null;
                          outputTarget.value = null;
                          if (inputIdx != -1) {
                            inputTarget.value = (
                              top,
                              top.inputs.keys.elementAt(inputIdx),
                            );
                          } else if (outputIdx != -1) {
                            outputTarget.value = (
                              top,
                              top.outputs.keys.elementAt(outputIdx),
                            );
                          }
                        }
                      }
                    }
                  }
                },
                onPointerCancel: (_) {
                  dragging.clear();
                  connectStart.value = null;
                  connectEnd.value = null;
                  inputTarget.value = null;
                  outputTarget.value = null;
                },
                onPointerUp: (details) {
                  final overlaps = overlappingNodes(details.localPosition);
                  if (overlaps.isNotEmpty) {
                    batch(() {
                      final top = overlaps.last;
                      if (isShiftPressed()) {
                        selection.add(top);
                      } else {
                        selection.clear();
                        selection.add(top);
                      }
                    });
                  } else if (!isShiftPressed()) {
                    selection.clear();
                  }

                  {
                    // Look up if connector will be on a node input/output
                    final overlaps = overlappingNodes(
                      details.localPosition,
                      inputs: true,
                      outputs: true,
                    );
                    if (overlaps.isNotEmpty) {
                      final top = overlaps.last;
                      final point = MatrixUtils.inverseTransformRect(
                        matrix(),
                        details.localPosition & const Size.square(1),
                      );
                      final local = point.topLeft - top.toOffset();
                      final localRect = local & const Size.square(1);
                      final inputIdx = top.inputIndexForOffset(localRect);
                      final outputIdx = top.outputIndexForOffset(localRect);
                      if (inputIdx != -1) {
                        if (inputTarget.value?.$1 != top) {
                          inputTarget.value = (
                            top,
                            top.inputs.keys.elementAt(inputIdx),
                          );
                        }
                      } else if (outputIdx != -1) {
                        if (outputTarget.value?.$1 != top) {
                          outputTarget.value = (
                            top,
                            top.outputs.keys.elementAt(outputIdx),
                          );
                        }
                      }
                    }
                    if (inputTarget() != null && outputTarget() != null) {
                      // Check if already connect (no-op)
                      final output = outputTarget()!;
                      final input = inputTarget()!;
                      // Create connection from output to input
                      if (output.$1 == input.$1) {
                        alert(context, content: 'Cannot add node to self');
                      } else {
                        final valid = input.$1.canLinkInput(input.$2, output);
                        if (!valid) {
                          alert(
                            context,
                            content: 'Cannot link input',
                          );
                        } else {
                          final previous = input.$1.inputs[input.$2];
                          if (input.$1.linkInputCausesCycle(input.$2, output)) {
                            alert(
                              context,
                              content: 'Linking node creates cycle',
                            );
                          } else {
                            if (previous != null) {
                              input.$1.unlinkInput(input.$2);
                            }
                            input.$1.linkInput(input.$2, (
                              nodeId: output.$1.id,
                              outputKey: output.$2,
                            ));
                          }
                        }
                      }
                    }
                  }

                  dragging.clear();
                  connectStart.value = null;
                  connectEnd.value = null;
                  inputTarget.value = null;
                  outputTarget.value = null;
                },
                behavior: HitTestBehavior.opaque,
                child: CustomPaint(
                  painter: NodeEdgesPainter(
                    matrix4: matrix(),
                    nodes: nodes(),
                    selected: selection(),
                    colors: Theme.of(context).colorScheme,
                  ),
                  foregroundPainter: ConnectorPainter(
                    matrix4: matrix(),
                    nodes: nodes(),
                    connectStart: connectStart(),
                    connectEnd: connectEnd(),
                    colors: Theme.of(context).colorScheme,
                  ),
                  child: CustomMultiChildLayout(
                    delegate: NodeLayoutDelegate(
                      matrix4: matrix(),
                      nodes: nodes
                          .map((e) => e
                            ..offset.value
                            ..expanded.value)
                          .toList(),
                    ),
                    children: [
                      for (final node in nodes)
                        LayoutId(
                          id: node.id,
                          child: () {
                            final selected = selection.contains(node);
                            return RenderNode(
                              node: node,
                              selected: selected,
                            );
                          }(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

bool isKeyPressed(List<LogicalKeyboardKey> keys) {
  return RawKeyboard.instance.keysPressed
      .where((it) => keys.contains(it))
      .isNotEmpty;
}

bool isShiftPressed() => isKeyPressed([
      LogicalKeyboardKey.shiftLeft,
      LogicalKeyboardKey.shiftRight,
      LogicalKeyboardKey.shift,
    ]);
