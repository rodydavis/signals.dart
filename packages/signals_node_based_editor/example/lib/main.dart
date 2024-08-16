import 'package:flutter/material.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';
import 'package:signals/signals_flutter.dart';

import 'nodes/variables.dart';
import 'nodes/widgets.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final graph = Graph();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: graph.scaffoldKey,
      appBar: AppBar(
        title: const Text('Node Based Editor'),
        actions: [
          Watch((context) {
            final selected = graph.selection.value.firstOrNull;
            return IconButton(
              onPressed: selected == null
                  ? null
                  : () {
                      if (selected is NodeSelection) {
                        graph.removeNode(selected.node);
                      }
                      if (selected is ConnectorSelection) {
                        graph.removeConnector(selected.input, selected.output);
                      }
                    },
              icon: const Icon(Icons.delete),
            );
          }),
          PopupMenuButton(
            icon: const Icon(Icons.widgets),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Text'),
                onTap: () => graph.nodes.add(
                  TextWidgetNode(data: 'Hello World!'),
                ),
              ),
              PopupMenuItem(
                child: const Text('SizedBox'),
                onTap: () => graph.nodes.add(
                  SizedBoxNode(width: 100, height: 100),
                ),
              ),
              PopupMenuItem(
                child: const Text('Button'),
                onTap: () => graph.nodes.add(
                  ButtonWidgetNode(
                    child: const Text('BUTTON'),
                  ),
                ),
              ),
              PopupMenuItem(
                child: const Text('Inc'),
                onTap: () => graph.nodes.add(
                  IncrementNode(),
                ),
              ),
            ],
          ),
          PopupMenuButton(
            icon: const Icon(Icons.add),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('String'),
                onTap: () => graph.nodes.add(
                  StringVariableNode('Hello World'),
                ),
              ),
              PopupMenuItem(
                child: const Text('String?'),
                onTap: () => graph.nodes.add(
                  OptionalStringVariableNode('Hello World'),
                ),
              ),
              PopupMenuItem(
                child: const Text('int'),
                onTap: () => graph.nodes.add(
                  IntVariableNode(0),
                ),
              ),
              PopupMenuItem(
                child: const Text('int?'),
                onTap: () => graph.nodes.add(
                  OptionalIntVariableNode(0),
                ),
              ),
              PopupMenuItem(
                child: const Text('double'),
                onTap: () => graph.nodes.add(
                  DoubleVariableNode(0),
                ),
              ),
              PopupMenuItem(
                child: const Text('double?'),
                onTap: () => graph.nodes.add(
                  OptionalDoubleVariableNode(0),
                ),
              ),
              PopupMenuItem(
                child: const Text('num'),
                onTap: () => graph.nodes.add(
                  NumVariableNode(0),
                ),
              ),
              PopupMenuItem(
                child: const Text('num?'),
                onTap: () => graph.nodes.add(
                  OptionalNumVariableNode(0),
                ),
              ),
              PopupMenuItem(
                child: const Text('bool'),
                onTap: () => graph.nodes.add(
                  BoolVariableNode(false),
                ),
              ),
              PopupMenuItem(
                child: const Text('bool?'),
                onTap: () => graph.nodes.add(
                  OptionalBoolVariableNode(null),
                ),
              ),
              PopupMenuItem(
                child: const Text('void Function()'),
                onTap: () => graph.nodes.add(
                  VoidFunctionVariableKnob(),
                ),
              ),
              PopupMenuItem(
                child: const Text('void Function()?'),
                onTap: () => graph.nodes.add(
                  OptionalVoidFunctionVariableKnob(),
                ),
              ),
              PopupMenuItem(
                child: const Text('ThemeMode'),
                onTap: () => graph.nodes.add(
                  EnumVariableNode<ThemeMode>(
                    ThemeMode.system,
                    ThemeMode.values,
                    'ThemeMode',
                  ),
                ),
              ),
              PopupMenuItem(
                child: const Text('ThemeMode?'),
                onTap: () => graph.nodes.add(
                  OptionalEnumVariableNode<ThemeMode>(
                    null,
                    ThemeMode.values,
                    'ThemeMode',
                  ),
                ),
              ),
              PopupMenuItem(
                child: const Text('Brightness'),
                onTap: () => graph.nodes.add(
                  EnumVariableNode<Brightness>(
                    Brightness.dark,
                    Brightness.values,
                    'Brightness',
                  ),
                ),
              ),
              PopupMenuItem(
                child: const Text('Brightness?'),
                onTap: () => graph.nodes.add(
                  OptionalEnumVariableNode<Brightness>(
                    null,
                    Brightness.values,
                    'Brightness',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: GraphView(
        graph: graph,
      ),
    );
  }
}
