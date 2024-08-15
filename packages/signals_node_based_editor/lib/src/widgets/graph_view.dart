import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../graph.dart';
import '../utils/axis_aligned_bounding_box.dart';
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
                                      return node.build(
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
}
