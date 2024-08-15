import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../src/graph.dart';
import '../node.dart';
import '../knobs.dart';
import 'actions.dart';

class NodeWidgetRender {
  final Signal<bool> collapsed$ = signal(false);
  final ReadonlySignal<String> label$ = signal('');

  Widget previewBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  static const headerHeight = 30.0;
  static const portHeight = 40.0;
  static const portWidth = 8.0;
  static const nodeWidth = 250.0;
  static const portPadding = 4.0;
  static const previewSizeFallback = Size(nodeWidth, 100);
  static const borderRadius = 12.0;

  final Computed<List<NodeWidgetInput>> inputs = computed(() => []);

  final Computed<List<NodeWidgetOutput>> outputs = computed(() => []);

  late Computed<Size> previewSize = computed(() {
    return const Size(nodeWidth, 0);
  });

  late Computed<Size> preferredSize = computed(() {
    var size = const Size(nodeWidth, headerHeight);
    if (collapsed$.value) return size;
    if (hasPreview) {
      size = Size(
        size.width,
        size.height + previewSize.value.height,
      );
    }
    final count = inputs.value.length + outputs.value.length;
    size = Size(
      size.width,
      size.height + (count * portHeight),
    );
    size = Size(size.width, size.height + (portPadding * 2));
    return size;
  });

  bool get hasPreview => previewSize.value.height > 0;

  late Computed<List<PortMetadata<NodeWidgetOutput>>> outputsMetadata =
      computed(() {
    final results = <PortMetadata<NodeWidgetOutput>>[];
    var top = headerHeight + previewSize.value.height + portPadding;
    for (var i = 0; i < outputs.value.length; i++) {
      final connector = Offset(
            collapsed$.value ? nodeWidth + -portWidth : nodeWidth,
            collapsed$.value ? 0 : top + i * portHeight,
          ) &
          const Size(portWidth, portHeight);
      final control = Offset(
            0,
            collapsed$.value ? 0 : top + i * portHeight,
          ) &
          const Size(nodeWidth, portHeight);
      results.add((
        connector: connector,
        control: control,
        port: outputs.value.elementAt(i),
      ));
    }
    return results;
  });

  late Computed<List<PortMetadata<NodeWidgetInput>>> inputsMetadata =
      computed(() {
    final results = <PortMetadata<NodeWidgetInput>>[];
    final top = headerHeight +
        previewSize.value.height +
        portPadding +
        (outputs.value.length * portHeight);
    for (var i = 0; i < inputs.value.length; i++) {
      final connector = Offset(
            collapsed$.value ? 0 : -portWidth,
            collapsed$.value ? 0 : top + i * portHeight,
          ) &
          const Size(portWidth, portHeight);
      final control = Offset(
            0,
            collapsed$.value ? 0 : top + i * portHeight,
          ) &
          const Size(nodeWidth, portHeight);
      results.add((
        connector: connector,
        control: control,
        port: inputs.value.elementAt(i),
      ));
    }
    return results;
  });

  Rect get headerRect => Offset.zero & const Size(nodeWidth, headerHeight);

  late Computed<Rect> previewRect = computed(() {
    return const Offset(0, headerHeight) &
        Size(
          nodeWidth,
          previewSize.value.height,
        );
  });

  Widget build(BuildContext context, GraphNode node, Graph graph) {
    return Watch((context) {
      final selected = graph //
          .selection
          .any((e) => e is NodeSelection && e.node == node);
      final colors = Theme.of(context).colorScheme;
      return SizedBox.fromSize(
        size: preferredSize.value,
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface,
          ),
          foregroundDecoration: BoxDecoration(
            border: Border.all(
              color: selected ? colors.primary : colors.outlineVariant,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: () {
            final Widget child = Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fromRect(
                  rect: headerRect,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(borderRadius),
                      topRight: const Radius.circular(borderRadius),
                      bottomLeft: collapsed$.value
                          ? const Radius.circular(borderRadius)
                          : Radius.zero,
                      bottomRight: collapsed$.value
                          ? const Radius.circular(borderRadius)
                          : Radius.zero,
                    ),
                    child: Container(
                      height: headerHeight,
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerHighest,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () => collapsed$.value = !collapsed$.value,
                              child: RotatedBox(
                                quarterTurns: collapsed$.value ? 2 : 0,
                                child: const Icon(Icons.arrow_drop_down),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                label$.value,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            if (label$ is Signal<String>) ...[
                              const SizedBox(width: 4),
                              GestureDetector(
                                child: const Icon(Icons.edit, size: 16),
                                onTap: () async {
                                  final result = await prompt(
                                    context,
                                    title: 'Edit Label',
                                    value: label$.value,
                                  );
                                  if (result == null) return;
                                  (label$ as Signal<String>).value = result;
                                },
                              ),
                            ],
                            const SizedBox(width: 4),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (!collapsed$.value) ...[
                  if (hasPreview)
                    Positioned.fromRect(
                      rect: previewRect.value,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Center(
                          child: SizedBox.fromSize(
                            size: previewSize.value,
                            child: previewBuilder(context),
                          ),
                        ),
                      ),
                    ),
                  for (final item in outputsMetadata.value) ...[
                    Positioned.fromRect(
                      rect: item.connector,
                      child: buildPort(context, item.port),
                    ),
                    Positioned.fromRect(
                      rect: item.control,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: portPadding,
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: buildLabel(
                                context,
                                item.port.label,
                                textAlign: TextAlign.right,
                                type: item.port.type,
                                optional: item.port.optional,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  for (final item in inputsMetadata.value) ...[
                    Positioned.fromRect(
                      rect: item.connector,
                      child: buildPort(context, item.port),
                    ),
                    Positioned.fromRect(
                      rect: item.control,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: portPadding,
                          horizontal: 10,
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            inputDecorationTheme: const InputDecorationTheme(
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                              filled: true,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildLabel(
                                context,
                                item.port.knob.label,
                                textAlign: TextAlign.left,
                                type: item.port.type,
                                optional: item.port.optional,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: item.port.knob.render(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ],
            );
            // if (selected) {
            //   return ContextMenu(
            //     menu: [
            //       MenuEntry(
            //         label: 'Test',
            //       ),
            //     ],
            //     child: child,
            //   );
            // }
            return child;
          }(),
        ),
      );
    });
  }

  Widget buildLabel(
    BuildContext context,
    String label, {
    required String type,
    required bool optional,
    TextAlign textAlign = TextAlign.left,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 100,
        minWidth: 50,
      ),
      child: Tooltip(
        message: () {
          var msg = label;
          msg += ' (${type.replaceAll('img.', '')}';
          if (optional) msg += '?';
          msg += ')';
          return msg;
        }(),
        child: Text(
          label,
          textAlign: textAlign,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget buildPort(BuildContext context, NodeWidgetPort port) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        color: colors.secondary,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

typedef PortMetadata<T extends NodeWidgetPort> = ({
  Rect connector,
  Rect control,
  T port,
});

sealed class NodeWidgetPort {
  final String label;
  final String type;
  final bool optional;
  NodeWidgetPort(this.label, this.type, this.optional);
}

class NodeWidgetInput<T> extends NodeWidgetPort {
  final Knob<T> knob;
  NodeWidgetInput(this.knob, String type, bool optional)
      : super(knob.label, type, optional);
}

class NodeWidgetOutput<T> extends NodeWidgetPort {
  final ReadonlySignal<T> source;
  NodeWidgetOutput(super.label, this.source, super.type, super.optional);
}
