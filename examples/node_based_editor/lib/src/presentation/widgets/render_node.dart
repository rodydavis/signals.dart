import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:signals/signals_flutter.dart';

import '../../generated/nodes/base_node.dart';
import 'actions.dart';

class RenderNode extends StatelessWidget {
  const RenderNode({
    super.key,
    required this.node,
    required this.selected,
  });

  final BaseNode node;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // final outputs = node.outputsRects();
    // final inputs = node.inputsRects();
    final inputTypes = node.inputTypes();
    final outputTypes = node.outputTypes();
    return Watch.builder(
      builder: (context) {
        return FittedBox(
          fit: BoxFit.fill,
          child: SizedBox.fromSize(
            size: node.size(),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      foregroundDecoration: BoxDecoration(
                        border: Border.all(
                          color: selected ? colors.primary : colors.outline,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          () {
                            final bgColor = selected
                                ? colors.primary
                                : colors.inverseSurface;
                            final fgColor = selected
                                ? colors.onPrimary
                                : colors.onInverseSurface;
                            return Container(
                              width: double.infinity,
                              height: labelHeight,
                              color: bgColor,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: RotatedBox(
                                      quarterTurns: node.expanded.value ? 0 : 2,
                                      child: const Icon(Icons.arrow_drop_down),
                                    ),
                                    iconSize: 20,
                                    padding: EdgeInsets.zero,
                                    color: fgColor,
                                    onPressed: () => node.expanded.value =
                                        !node.expanded.value,
                                  ),
                                  const SizedBox(width: padding),
                                  Expanded(
                                    child: Text(
                                      node.label.value,
                                      style: TextStyle(
                                        color: fgColor,
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(width: padding),
                                  if (selected) ...[
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      padding: EdgeInsets.zero,
                                      iconSize: 14,
                                      color: fgColor,
                                      onPressed: () async {
                                        final value = await prompt(
                                          context,
                                          title: 'Rename node',
                                          value: node.label.value,
                                        );
                                        if (value == null ||
                                            value.trim().isEmpty ||
                                            value == node.label.value) {
                                          return;
                                        }
                                        node.label.value = value.trim();
                                      },
                                    ),
                                  ],
                                ],
                              ),
                            );
                          }(),
                          Expanded(
                            child: Container(
                              color: colors.surface,
                              padding: const EdgeInsets.all(padding),
                              child: Column(
                                children: [
                                  ...node.outputs.entries.map(
                                    (e) => _output(outputTypes[e.key]!, e),
                                  ),
                                  ...node.inputs.entries.map(
                                    (e) => _input(inputTypes[e.key]!, e),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _input(String type, MapEntry<String, NodeInput> e) {
  return Container(
    height: ioHeight,
    width: double.infinity,
    padding: const EdgeInsets.all(2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _type(type, e.value.value),
        const SizedBox(width: 4),
        Expanded(child: Text(e.key)),
      ],
    ),
  );
}

Widget _output(String type, MapEntry<String, ReadonlySignal<dynamic>> e) {
  return Container(
    height: ioHeight,
    width: double.infinity,
    padding: const EdgeInsets.all(2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(e.key),
          ),
        ),
        const SizedBox(width: 4),
        _type(type, e.value)
      ],
    ),
  );
}

Widget _type(String type, ReadonlySignal e) {
  final (label, color) = _signalType(type, e);
  return Container(
    width: connectorSize,
    height: connectorSize,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
    child: Tooltip(
      message: 'Type: $label',
      child: const SizedBox.expand(),
    ),
  );
}

// Widget _control(String key, String type, ReadonlySignal e, bool enabled) {
//   if (enabled && e is Signal) {
//     const numberTypes = [
//       'num',
//       'num?',
//       'int',
//       'int?',
//       'double',
//       'double?',
//     ];
//     const stringTypes = [
//       'String',
//       'String?',
//     ];
//     const boolTypes = [
//       'bool',
//       'bool?',
//     ];
//     const textFieldTypes = [
//       ...numberTypes,
//       ...stringTypes,
//     ];
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(key),
//         Expanded(
//           child: Align(
//             alignment: Alignment.centerRight,
//             child: () {
//               if (boolTypes.contains(type)) {
//                 return Checkbox(
//                   tristate: type.endsWith('?'),
//                   value: e.value,
//                   onChanged: (val) {
//                     if (type.endsWith('?')) {
//                       e.value = val;
//                     } else {
//                       e.value = val!;
//                     }
//                   },
//                 );
//               }
//               if (textFieldTypes.contains(type)) {
//                 return TextFormField(
//                   decoration: const InputDecoration(border: InputBorder.none),
//                   initialValue: e.value?.toString(),
//                   validator: (val) {
//                     if (!type.endsWith('?') && (val == null || val.isEmpty)) {
//                       return 'Cannot be empty';
//                     }
//                     if (numberTypes.contains(type)) {
//                       final value = num.tryParse(val!);
//                       if (value == null) return 'Not a valid number';
//                     }
//                     return null;
//                   },
//                   onChanged: (val) {
//                     if (numberTypes.contains(type)) {
//                       final value = num.tryParse(val);
//                       if (e is Signal<int> || e is Signal<int?>) {
//                         e.value = value?.toInt();
//                       } else if (e is Signal<double> || e is Signal<double?>) {
//                         e.value = value?.toDouble();
//                       } else if (e is Signal<num> || e is Signal<num?>) {
//                         e.value = value;
//                       }
//                     } else {
//                       e.value = val;
//                     }
//                   },
//                 );
//               }
//               return const SizedBox.shrink();
//             }(),
//           ),
//         ),
//       ],
//     );
//   }
//   return Text(key);
// }

(String, Color) _signalType(String type, ReadonlySignal e) {
  switch (type) {
    case 'String':
    case 'String?':
      return (type, Colors.orange);
    case 'RegExp':
    case 'RegExp?':
      return (type, Colors.deepOrange);
    case 'Pattern':
    case 'Pattern?':
      return (type, Colors.orangeAccent);
    case 'bool':
    case 'bool?':
      return (type, Colors.purple);
    case 'int':
    case 'int?':
      return (type, Colors.lightBlue);
    case 'double':
    case 'double?':
      return (type, Colors.blue);
    case 'num':
    case 'num?':
      return (type, Colors.cyan);
    case 'Object':
    case 'Object?':
      return (type, Colors.blueGrey);
    default:
  }
  return ('dynamic', Colors.grey);
}

extension BaseNodeUtils on BaseNode {
  Size size() {
    double width = minWidth + (padding * 2);
    double height = labelHeight;
    if (expanded.value) {
      height += padding * 2;
      height += _height(inputs.length);
      height += _height(outputs.length);
    }
    return Size(width, height);
  }

  Offset offset() => toOffset();

  Offset toOffset() {
    final val = this.offset.value;
    return Offset(val.dx, val.dy);
  }

  Rect rect({
    bool withInputs = false,
    bool withOutputs = false,
    bool moveable = false,
  }) {
    final o = toOffset();
    if (moveable) {
      return o & Size(size().width, labelHeight);
    }
    return o & size();
  }

  Map<String, Rect> outputsRects({bool target = true}) {
    final result = <String, Rect>{};
    double top = labelHeight + padding;
    final s = size();
    for (var i = 0; i < outputs.length; i++) {
      final entry = outputs.entries.elementAt(i);
      result[entry.key] = target
          ? Rect.fromLTWH(
              s.width - (connectorSize + padding + 2),
              top + ((ioHeight / 2) - (connectorSize / 2)),
              connectorSize,
              connectorSize,
            )
          : Rect.fromLTWH(
              0,
              top,
              s.width,
              ioHeight,
            );
      top += ioHeight;
    }
    return result;
  }

  Map<String, Rect> inputsRects({bool target = true}) {
    final result = <String, Rect>{};
    double top = outputs.length * ioHeight + labelHeight + padding;
    final s = size();
    for (var i = 0; i < inputs.length; i++) {
      final entry = inputs.entries.elementAt(i);
      result[entry.key] = target
          ? Rect.fromLTWH(
              padding + 2,
              top + ((ioHeight / 2) - (connectorSize / 2)),
              connectorSize,
              connectorSize,
            )
          : Rect.fromLTWH(
              0,
              top,
              s.width,
              ioHeight,
            );
      top += ioHeight;
    }
    return result;
  }

  int inputIndexForOffset(Rect rect) {
    final rects = inputsRects();
    for (var i = 0; i < rects.length; i++) {
      final entry = rects.entries.elementAt(i);
      if (entry.value.overlaps(rect)) return i;
    }
    return -1;
  }

  int outputIndexForOffset(Rect rect) {
    final rects = outputsRects();
    for (var i = 0; i < rects.length; i++) {
      final entry = rects.entries.elementAt(i);
      if (entry.value.overlaps(rect)) return i;
    }
    return -1;
  }

  Offset? getOffsetForInput(String key) {
    if (!expanded() && inputs.containsKey(key)) {
      return const Offset(2, labelHeight / 2);
    }
    final rects = inputsRects();
    return rects[key]?.center;
  }

  Offset? getOffsetForOutput(String key) {
    if (!expanded() && outputs.containsKey(key)) {
      return Offset(size().width - connectorSize - 2, labelHeight / 2);
    }
    final rects = outputsRects();
    return rects[key]?.center;
  }

  bool canLinkInput(String key, (BaseNode, String) output) {
    final inputType = inputTypes()[key];
    final outputType = output.$1.outputTypes()[output.$2];
    if (inputType != null && outputType != null) {
      if (outputType == inputType) return true;
      if ('$outputType?' == inputType) return true;
      if (!outputType.endsWith('?') && inputType == 'Object') return true;
      if (inputType == 'Object?') return true;
    }
    return false;
  }

  bool linkInputCausesCycle(String key, (BaseNode, String) output) {
    // Follow connections to make sure we don't create a cycle.
    if (output.$1 == this) return true;
    final visited = <BaseNode>{};
    final stack = <BaseNode>{};
    stack.add(output.$1);
    while (stack.isNotEmpty) {
      final node = stack.first;
      stack.remove(node);
      if (visited.contains(node)) continue;
      visited.add(node);
      for (final input in node.inputs.values) {
        if (input.link == null) continue;
        final target = getNode(input.link!.nodeId)!;
        if (target == this) return true;
        stack.add(target);
      }
    }
    return false;
  }
}

double _height(int length) {
  var h = length * ioHeight;
  if (length > 0) {
    h += (length - 1);
  }
  return h;
}

const connectorSize = 10.0;
const labelHeight = 30.0;
const padding = 4.0;
const ioHeight = 40.0;
const minWidth = 200.0;
