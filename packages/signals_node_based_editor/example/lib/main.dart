import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';
import 'package:signals/signals_flutter.dart';

import 'controller.dart';
import 'nodes/base.dart';
import 'nodes/bool.dart';
import 'nodes/group.dart';
import 'nodes/list.dart';
import 'nodes/num.dart';
import 'nodes/string.dart';

void main() {
  runApp(const App());
}

final themeMode = signal(ThemeMode.system);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Example(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode.watch(context),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final graph = GraphController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    graph.init();
    effect(() {
      final error = graph.errorMessage.value;
      if (error.isEmpty) return;
      final scaffold = scaffoldKey.currentState!;
      final messenger = ScaffoldMessenger.of(scaffold.context);
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(SnackBar(content: Text(error)));
    });
  }

  @override
  void dispose() {
    graph.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: PopupMenuButton(
          icon: Watch((context) {
            final mode = themeMode.value;
            return Icon(
              switch (mode) {
                ThemeMode.light => Icons.light_mode,
                ThemeMode.dark => Icons.dark_mode,
                ThemeMode.system => Icons.auto_awesome,
              },
            );
          }),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Text('Light'),
              onTap: () => themeMode.value = ThemeMode.light,
            ),
            PopupMenuItem(
              child: const Text('Dark'),
              onTap: () => themeMode.value = ThemeMode.dark,
            ),
            PopupMenuItem(
              child: const Text('System'),
              onTap: () => themeMode.value = ThemeMode.system,
            ),
          ],
        ),
        title: const Text('Node Based Editor'),
        actions: [
          Watch((context) {
            return IconButton(
              onPressed: !graph.canUndo() ? null : graph.undo,
              icon: const Icon(Icons.undo),
            );
          }),
          Watch((context) {
            return IconButton(
              onPressed: !graph.canRedo() ? null : graph.redo,
              icon: const Icon(Icons.redo),
            );
          }),
          Watch((context) {
            final selected = graph.selection.value.firstOrNull;
            return IconButton(
              onPressed: selected == null
                  ? null
                  : () {
                      if (selected is NodeSelection<BaseNode>) {
                        graph.removeNode(selected.node);
                      }
                      if (selected is ConnectorSelection) {
                        graph.removeConnector(selected.input);
                      }
                    },
              icon: const Icon(Icons.delete),
            );
          }),
          Watch((context) {
            final canGroup = graph.canGroup();
            final selection = graph.selection.value.firstOrNull;
            if (canGroup) {
              return IconButton(
                onPressed: graph.groupNodes,
                icon: const Icon(Icons.select_all),
              );
            }
            if (selection is NodeSelection<BaseNode>) {
              if (selection.node is GroupNode) {
                final group = selection.node as GroupNode;
                return IconButton(
                  onPressed: () => graph.unGroup(group),
                  icon: const Icon(Icons.clear),
                );
              }
            }
            return const SizedBox.shrink();
          }),
          IconButton(
            onPressed: () {
              const encoder = JsonEncoder.withIndent('  ');
              final str = encoder.convert(graph.toJson());
              debugPrint(str);
              // Copy to clipboard
              Clipboard.setData(ClipboardData(text: str));
            },
            icon: const Icon(Icons.copy),
          ),
          IconButton(
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              final data = await Clipboard.getData('text/plain');
              if (data != null) {
                final json = jsonDecode(data.text!);
                try {
                  graph.fromJson(json);
                } on JsonInteropParseError catch (e) {
                  messenger.showSnackBar(
                    SnackBar(content: Text(e.message)),
                  );
                }
              }
            },
            icon: const Icon(Icons.paste),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.add),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('String'),
                onTap: () => graph.nodes.add(
                  StringNode(data: 'Hello World'),
                ),
              ),
              PopupMenuItem(
                child: const Text('String?'),
                onTap: () => graph.nodes.add(
                  StringNode(data: '', optional: true),
                ),
              ),
              PopupMenuItem(
                child: const Text('bool'),
                onTap: () => graph.nodes.add(
                  BoolNode(data: false),
                ),
              ),
              PopupMenuItem(
                child: const Text('bool?'),
                onTap: () => graph.nodes.add(
                  BoolNode(data: null, optional: true),
                ),
              ),
              PopupMenuItem(
                child: const Text('num'),
                onTap: () => graph.nodes.add(
                  NumNode(data: 0),
                ),
              ),
              PopupMenuItem(
                child: const Text('num?'),
                onTap: () => graph.nodes.add(
                  NumNode(data: null, optional: true),
                ),
              ),
              PopupMenuItem(
                child: const Text('List<String>'),
                onTap: () => graph.nodes.add(
                  StringList(items: ['Hello', 'World']),
                ),
              ),
              PopupMenuItem(
                child: const Text('List<String>?'),
                onTap: () => graph.nodes.add(
                  StringList(items: [], optional: true),
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
