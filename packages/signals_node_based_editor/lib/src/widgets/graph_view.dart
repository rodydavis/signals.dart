import 'package:flutter/material.dart'
    hide InteractiveViewer, TransformationController;
import 'package:signals/signals_flutter.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';
import 'package:vector_math/vector_math_64.dart' show Quad;

import '../graph.dart';
import '../node.dart';
import '../utils/axis_aligned_bounding_box.dart';
import 'actions.dart';
import 'background_painter.dart';
import 'interactive_viewer.dart';
import 'foreground_painter.dart';
import 'graph_delegate.dart';

class GraphView extends StatelessWidget {
  const GraphView({
    super.key,
    required this.graph,
    this.focusNode,
    this.gridSize = const Size.square(50),
    this.portColorBuilder,
  });

  final Graph graph;
  final FocusNode? focusNode;
  final Size gridSize;

  final Color? Function(NodeWidgetPort)? portColorBuilder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      graph.viewport.value = constraints.biggest;
      return KeyboardListener(
        focusNode: graph.keyboardFocusNode,
        onKeyEvent: graph.onKeyEvent,
        autofocus: true,
        child: Watch.builder(
          builder: (context) => InteractiveViewer.builder(
            transformChild: false,
            transformationController: graph.controller,
            minScale: graph.minScale.value,
            maxScale: graph.maxScale.value,
            boundaryMargin: const EdgeInsets.all(double.infinity),
            onInteractionStart: graph.onInteractionStart,
            onInteractionUpdate: graph.onInteractionUpdate,
            onInteractionEnd: graph.onInteractionEnd,
            panEnabled: graph.panEnabled.value,
            scaleEnabled: graph.scaleEnabled.value,
            builder: renderView,
          ),
        ),
      );
    });
  }

  Widget renderView(BuildContext context, Quad quad) {
    final viewport = axisAlignedBoundingBox(quad);
    return Watch((context) {
      final colors = Theme.of(context).colorScheme;
      final fonts = Theme.of(context).textTheme;
      final matrix = graph.transform.value;
      return SizedBox.fromSize(
        size: graph.maxSize.value.size,
        child: CustomPaint(
          painter: GraphBackgroundPainter(
            selection: graph.selection.value,
            connectors: graph.connectors.value,
            colors: colors,
            fonts: fonts,
            cellSize: gridSize,
            viewport: viewport,
            dotDimension: 3,
            transform: matrix,
            graph: graph,
          ),
          foregroundPainter: GraphForegroundPainter(
            transform: matrix,
            connection: graph.connection.value,
            colors: colors,
            fonts: fonts,
            straightLines: true,
          ),
          child: CustomMultiChildLayout(
            delegate: GraphDelegate(
              transform: matrix,
              nodes: graph.nodes,
              viewport: viewport,
            ),
            children: [
              for (final node in graph.nodes)
                LayoutId(
                  id: node.id$,
                  child: () {
                    node.rect$.value;
                    var nodeRect =
                        node.offset$.value & node.preferredSize$.value;
                    nodeRect = MatrixUtils.transformRect(matrix, nodeRect);
                    return Watch(
                      (context) => SizedBox.fromSize(
                        size: nodeRect.size,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: renderNode(
                            context,
                            node,
                            graph,
                          ),
                        ),
                      ),
                    );
                  }(),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget renderNode(BuildContext context, GraphNode node, Graph graph) {
    return Watch((context) {
      final visible = graph.nodeVisible(node);
      if (!visible && graph.lazyRender) return const SizedBox.shrink();
      final selected = graph //
          .selection
          .value
          .any((e) => e is NodeSelection && e.node == node);
      final colors = Theme.of(context).colorScheme;
      return SizedBox.fromSize(
        size: node.preferredSize$.value,
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.all(
              Radius.circular(GraphNode.borderRadius),
            ),
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
                      topLeft: Radius.circular(GraphNode.borderRadius),
                      topRight: Radius.circular(GraphNode.borderRadius),
                      bottomLeft: node.collapsed$.value
                          ? Radius.circular(GraphNode.borderRadius)
                          : Radius.zero,
                      bottomRight: node.collapsed$.value
                          ? Radius.circular(GraphNode.borderRadius)
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
                        padding: EdgeInsets.symmetric(
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
                        padding: EdgeInsets.symmetric(
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
                                clip: !(item.port.knob is ObjectKnob ||
                                    item.port.knob is OptionalObjectKnob),
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
    bool clip = true,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        // maxWidth: clip ? 100 : double.infinity,
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
    final color = portColorBuilder?.call(port) ?? colors.secondary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        color: color,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

class _OverlayWidget extends StatefulWidget {
  const _OverlayWidget({
    required this.parentWidget,
    required this.horizontalOffset,
    required this.verticalOffset,
    required this.mediaQuery,
  });
  final GraphView parentWidget;
  final double horizontalOffset;
  final double verticalOffset;
  final MediaQueryData mediaQuery;

  @override
  State<_OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<_OverlayWidget> {
  OverlayEntry? overlay;
  final offset = signal(Offset.zero);

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    removeOverlay();
  }

  @override
  Widget build(BuildContext context) {
    Future(addOverlay);
    return Container();
  }

  void addOverlay() {
    removeOverlay();
    RenderBox? renderBox = context.findAncestorRenderObjectOfType<RenderBox>();

    var parentSize = renderBox!.size;
    var parentPosition = renderBox.localToGlobal(Offset.zero);

    overlay = _overlayEntryBuilder(parentPosition, parentSize);
    Overlay.of(context).insert(overlay!);
  }

  void removeOverlay() {
    overlay?.remove();
  }

  OverlayEntry _overlayEntryBuilder(Offset parentPosition, Size parentSize) {
    final graph = widget.parentWidget.graph;
    return OverlayEntry(
      maintainState: true,
      builder: (context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Positioned(
            //   left: parentPosition.dx +
            //       parentSize.width -
            //       clickableArea -
            //       widget.horizontalOffset,
            //   top: parentPosition.dy +
            //       parentSize.height -
            //       clickableArea -
            //       widget.verticalOffset,
            //   child: Material(
            //     color: Colors.transparent,
            //     child: InkWell(
            //       onTap: () {
            //         widget.parentWidget.incrementCounter();
            //       },
            //       child: Container(
            //         color: Colors.blue.withAlpha(200),
            //         width: clickableArea,
            //         height: clickableArea,
            //         child: Text(
            //           'InkWell (Overlay)',
            //           style: Theme.of(context).textTheme.bodyLarge,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   left: offset.watch(context).dx +
            //       parentPosition.dx +
            //       parentSize.width -
            //       clickableArea -
            //       widget.horizontalOffset,
            //   top: offset.watch(context).dy +
            //       parentPosition.dy +
            //       widget.verticalOffset,
            //   child: GestureDetector(
            //     onTap: () {
            //       widget.parentWidget.incrementCounter();
            //     },
            //     onPanUpdate: (details) {
            //       offset.value += details.delta;
            //     },
            //     child: Container(
            //       color: Colors.purple.withAlpha(200),
            //       width: clickableArea,
            //       height: clickableArea,
            //       child: Text(
            //         'Gesture (Overlay)',
            //         style: Theme.of(context).textTheme.bodyLarge,
            //       ),
            //     ),
            //   ),
            // ),
            for (final node in graph.nodes)
              () {
                return Watch((context) {
                  node.rect$.value;
                  var nodeRect = node.offset$.value & node.preferredSize$.value;
                  return Positioned(
                    left: nodeRect.topLeft.dx + parentPosition.dx,
                    top: nodeRect.topLeft.dy + parentPosition.dy,
                    width: nodeRect.width,
                    height: nodeRect.height,
                    child: Material(
                      color: Colors.transparent,
                      child: widget.parentWidget.renderNode(
                        context,
                        node,
                        graph,
                      ),
                    ),
                  );
                });
                //  for (final node in widget.graph.nodes)
                //     () {
                //       node.rect$.value;
                //       var nodeRect =
                //           node.offset$.value & node.preferredSize$.value;
                //       return Positioned.fromRect(
                //         rect: nodeRect,
                //         child: Watch((context) {
                //           return renderNode(
                //             context,
                //             node,
                //             widget.graph,
                //           );
                //         }),
                //       );
                //     }(),
              }(),
          ],
        );
      },
    );
  }
}
