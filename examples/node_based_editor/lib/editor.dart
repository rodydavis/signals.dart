import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'nodes/base.dart';
import 'nodes/compare.dart';
import 'nodes/number.dart';
import 'nodes/reduce.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Node Based Editor'),
        centerTitle: false,
      ),
      body: Watch.builder(
        builder: (context) => Stack(
          children: [
            Positioned.fill(
              child: SizedBox.expand(
                child: CustomPaint(
                  painter: NodeEdges(nodes, selection),
                  child: CustomMultiChildLayout(
                    delegate: NodeLayout(nodes),
                    children: [
                      for (final node in nodes.keys)
                        LayoutId(
                          id: node.id,
                          child: Container(
                            decoration: BoxDecoration(
                              color: selection.contains(node)
                                  ? Colors.lightBlue.shade100
                                  : Colors.grey.shade300,
                              border: Border.all(
                                color: selection.contains(node)
                                    ? Colors.lightBlue
                                    : Colors.grey,
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
                                  Positioned.fill(child: node.build()),
                                  Positioned(
                                    top: -25,
                                    left: 0,
                                    child: Text(node.name),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Text('Nodes: ${nodes.length}'),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilledButton(
                    child: const Text('Add Number'),
                    onPressed: () => nodes[NumberNode(0)] = Offset.zero,
                  ),
                  if (selection.length > 1 &&
                      selection
                          .toList()
                          .every((e) => e is Node<dynamic, num>)) ...[
                    const SizedBox(height: 10),
                    FilledButton(
                      child: const Text('Create Reducer'),
                      onPressed: () {
                        nodes[ReduceNode(
                          Reducer.add,
                          selection.toList().cast<Node<dynamic, num>>(),
                        )] = Offset.zero;
                        selection.clear();
                      },
                    ),
                    if (selection.length == 2) ...[
                      const SizedBox(height: 10),
                      FilledButton(
                        child: const Text('Create Compare'),
                        onPressed: () {
                          nodes[CompareNode(
                            Operator.equalTo,
                            selection.first as Node<dynamic, num>,
                            selection.last as Node<dynamic, num>,
                          )] = Offset.zero;
                          selection.clear();
                        },
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
