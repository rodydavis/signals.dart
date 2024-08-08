import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:signals/signals_flutter.dart';

import 'background_painter.dart';
import 'graph_delegate.dart';
import 'nodes/filters/all.dart';
import 'nodes/graph.dart';
import 'nodes/base.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  final picker = FilePicker.platform;
  final imageOffset = signal<Offset>(Offset.zero);
  final graph = ImageGraph();

  Future<void> selectPhoto() async {
    final result = await picker.pickFiles(
      dialogTitle: 'Select Image',
      allowedExtensions: ['png'],
      type: FileType.custom,
      withData: true,
    );
    if (result == null) return;
    final file = result.xFiles.firstOrNull;
    if (file == null) return;
    final bytes = await file.readAsBytes();
    graph.source.source.value = bytes;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Watch((context) {
      final selected = graph.selection.firstOrNull;
      final size = graph.source.imageSize.value;
      return Scaffold(
        body: Row(
          children: [
            Expanded(
              child: Watch((context) {
                return CustomPaint(
                  painter: GraphBackgroundPainter(
                    graph.source,
                    graph.nodes,
                    colors.outline,
                  ),
                  child: CustomMultiChildLayout(
                    delegate: GraphDelegate(
                      graph.source,
                      graph.nodes,
                    ),
                    children: [
                      for (final node in graph.nodes)
                        LayoutId(
                          id: node.id,
                          child: () {
                            final selected = graph.selection.contains(node);
                            node.offset.value;
                            return GestureDetector(
                              onTap: () {
                                if (selected) {
                                  graph.selection.remove(node);
                                } else {
                                  batch(() {
                                    graph.selection.clear();
                                    graph.selection.add(node);
                                  });
                                }
                              },
                              onPanUpdate: (details) {
                                node.offset.value += details.delta;
                              },
                              child: Container(
                                foregroundDecoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: selected
                                        ? colors.primary
                                        : colors.outlineVariant,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                decoration: BoxDecoration(
                                  color: colors.surface,
                                ),
                                child: () {
                                  if (size.isEmpty) {
                                    return const SizedBox.shrink();
                                  }
                                  return Watch.builder(builder: (context) {
                                    return node.export.value.map(
                                        loading: () => const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                        error: (err) => Center(
                                              child: Text(
                                                'Error creating image: $err',
                                              ),
                                            ),
                                        data: (bytes) {
                                          return RawImage(
                                            image: bytes,
                                          );
                                        });
                                  });
                                }(),
                              ),
                            );
                          }(),
                        ),
                    ],
                  ),
                );
              }),
            ),
            const VerticalDivider(width: 1),
            Container(
              width: 300,
              color: colors.surface,
              child: ListView(
                key: ValueKey(graph.selection.version),
                children: [
                  if (selected != null) ...[
                    ExpansionTile(
                      title: const Text('Add Filter'),
                      leading: const Icon(Icons.filter),
                      children: () {
                        return <Widget>[
                          for (final entry in filters.entries)
                            ListTile(
                              title: TextButton(
                                onPressed: () {
                                  final GraphNode child = entry.value(selected);
                                  child.offset.value =
                                      (selected.offset.value & size)
                                          .topRight
                                          .translate(40, 0);
                                  graph.nodes.add(child);
                                },
                                child: Text(entry.key),
                              ),
                            ),
                        ];
                      }(),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: OutlinedButton.icon(
                        onPressed: () => graph.removeNode(selected),
                        label: const Text('Remove'),
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Select photo',
          onPressed: selectPhoto,
          child: const Icon(Icons.upload),
        ),
      );
    });
  }
}
