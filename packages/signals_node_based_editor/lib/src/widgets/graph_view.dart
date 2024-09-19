import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../graph.dart';
import '../node.dart';
import '../utils/axis_aligned_bounding_box.dart';
import 'actions.dart';
import 'background_painter.dart';
import 'foreground_painter.dart';
import 'graph_delegate.dart';
import 'grid_background.dart';

class GraphView extends StatefulWidget {
  const GraphView({
    super.key,
    required this.graph,
    this.focusNode,
    this.gridSize = const Size.square(50),
  });

  final Graph graph;
  final FocusNode? focusNode;
  final Size gridSize;

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  late final focusNode = widget.focusNode ?? FocusNode();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      widget.graph.viewport.value = constraints.biggest;
      return KeyboardListener(
        focusNode: focusNode,
        onKeyEvent: widget.graph.onKeyEvent,
        child: Watch((context) {
          final gridSize = widget.gridSize;
          return InteractiveViewer.builder(
            transformationController: widget.graph.controller,
            minScale: widget.graph.minScale.value,
            maxScale: widget.graph.maxScale.value,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            onInteractionStart: widget.graph.onInteractionStart,
            onInteractionUpdate: widget.graph.onInteractionUpdate,
            onInteractionEnd: widget.graph.onInteractionEnd,
            panEnabled: widget.graph.panEnabled.value,
            scaleEnabled: widget.graph.scaleEnabled.value,
            builder: (context, quad) {
              return Watch((context) {
                final colors = Theme.of(context).colorScheme;
                final fonts = Theme.of(context).textTheme;
                return SizedBox.fromSize(
                  // TODO: Bug - Negative offset cannot work with text fields
                  size: widget.graph.maxSize.value.size,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                        child: GridBackgroundBuilder(
                          cellWidth: gridSize.width,
                          cellHeight: gridSize.height,
                          viewport: axisAlignedBoundingBox(quad),
                        ),
                      ),
                      Positioned.fill(
                        child: CustomPaint(
                          painter: GraphBackgroundPainter(
                            widget.graph.selection.value,
                            widget.graph.connectors.value,
                            () {
                              final mouse = widget.graph.mouse.value;
                              if (mouse == null) return null;
                              return mouse;
                            }(),
                            colors: colors,
                            fonts: fonts,
                          ),
                          foregroundPainter: GraphForegroundPainter(
                            widget.graph.connection.value,
                            colors: colors,
                            fonts: fonts,
                            straightLines: true,
                          ),
                          child: CustomMultiChildLayout(
                            delegate: GraphDelegate(widget.graph.nodes),
                            children: [
                              for (final node in widget.graph.nodes)
                                LayoutId(
                                  id: node.id,
                                  child: () {
                                    node.rect$.value;
                                    return Watch((context) {
                                      return renderNode(
                                        context,
                                        node,
                                        widget.graph,
                                      );
                                    });
                                  }(),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
            },
          );
        }),
      );
    });
  }

  Widget renderNode(BuildContext context, GraphNode node, Graph graph) {
    return Watch((context) {
      final selected = graph //
          .selection
          .any((e) => e is NodeSelection && e.node == node);
      final colors = Theme.of(context).colorScheme;
      return SizedBox.fromSize(
        size: node.preferredSize$.value,
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface,
          ),
          foregroundDecoration: BoxDecoration(
            border: Border.all(
              color: selected ? colors.primary : colors.outlineVariant,
            ),
            borderRadius: BorderRadius.circular(GraphNode.borderRadius),
          ),
          child: () {
            final Widget child = Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fromRect(
                  rect: node.headerRect,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(GraphNode.borderRadius),
                      topRight: const Radius.circular(GraphNode.borderRadius),
                      bottomLeft: node.collapsed$.value
                          ? const Radius.circular(GraphNode.borderRadius)
                          : Radius.zero,
                      bottomRight: node.collapsed$.value
                          ? const Radius.circular(GraphNode.borderRadius)
                          : Radius.zero,
                    ),
                    child: Container(
                      height: GraphNode.headerHeight,
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
                              onTap: () => node.collapsed$.value =
                                  !node.collapsed$.value,
                              child: RotatedBox(
                                quarterTurns: node.collapsed$.value ? 2 : 0,
                                child: const Icon(Icons.arrow_drop_down),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                node.label$.value,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            ...node.actions$(context),
                            if (node.label$ is Signal<String>) ...[
                              const SizedBox(width: 4),
                              GestureDetector(
                                child: const Icon(Icons.edit, size: 16),
                                onTap: () async {
                                  final result = await prompt(
                                    context,
                                    title: 'Edit Label',
                                    value: node.label$.value,
                                  );
                                  if (result == null) return;
                                  (node.label$ as Signal<String>).value =
                                      result;
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
                if (!node.collapsed$.value) ...[
                  if (node.hasPreview)
                    Positioned.fromRect(
                      rect: node.previewRect.value,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Center(
                          child: SizedBox.fromSize(
                            size: node.previewSize$.value,
                            child: node.preview(context),
                          ),
                        ),
                      ),
                    ),
                  for (final item in node.outputsMetadata.value) ...[
                    Positioned.fromRect(
                      rect: item.connector,
                      child: buildNodePort(
                        context,
                        item.port,
                      ),
                    ),
                    Positioned.fromRect(
                      rect: item.control,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: GraphNode.portPadding,
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: buildNodeLabel(
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
                  for (final item in node.inputsMetadata.value) ...[
                    Positioned.fromRect(
                      rect: item.connector,
                      child: buildNodePort(
                        context,
                        item.port,
                      ),
                    ),
                    Positioned.fromRect(
                      rect: item.control,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: GraphNode.portPadding,
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
                              buildNodeLabel(
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

  Widget buildNodeLabel(
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

  Widget buildNodePort(BuildContext context, NodeWidgetPort port) {
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
