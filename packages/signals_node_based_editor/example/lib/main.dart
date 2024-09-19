import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';
import 'package:signals/signals_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: graph.scaffoldKey,
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
            final selected = graph.selection.value.firstOrNull;
            return IconButton(
              onPressed: selected == null
                  ? null
                  : () {
                      if (selected is NodeSelection<BaseKnob>) {
                        graph.removeNode(selected.node);
                      }
                      if (selected is ConnectorSelection) {
                        graph.removeConnector(selected.input, selected.output);
                      }
                    },
              icon: const Icon(Icons.delete),
            );
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

abstract class BaseKnob extends GraphNode {
  @override
  final String type$;
  BaseKnob(this.type$);

  Map<String, dynamic> toJson();
}

class StringNode extends BaseKnob {
  final Knob data;
  final bool optional;

  StringNode({
    String? data,
    this.optional = false,
  })  : data = optional
            ? OptionalStringKnob('data', data ?? '')
            : StringKnob('data', data ?? ''),
        super('String${optional ? '?' : ''}');

  factory StringNode.fromJson(Map<String, dynamic> json, bool optional) {
    return StringNode(
      data: json['data'],
      optional: optional,
    );
  }

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(data, 'String', optional),
    ];
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('value', data.source, 'String', false),
    ];
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type$,
      'data': data.value,
    };
  }
}

class BoolNode extends BaseKnob {
  final Knob data;
  final bool optional;

  BoolNode({
    bool? data,
    this.optional = false,
  })  : data = optional
            ? OptionalBoolKnob('data', data ?? false)
            : BoolKnob('data', data ?? false),
        super('bool${optional ? '?' : ''}');

  factory BoolNode.fromJson(Map<String, dynamic> json, bool optional) {
    return BoolNode(
      data: json['data'],
      optional: optional,
    );
  }

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(data, 'bool', optional),
    ];
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('value', data.source, 'bool', false),
    ];
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type$,
      'data': data.value,
    };
  }
}

class NumNode extends BaseKnob {
  final Knob data;
  final bool optional;

  NumNode({
    num? data,
    this.optional = false,
  })  : data = optional
            ? OptionalNumKnob('data', data ?? 0)
            : NumKnob('data', data ?? 0),
        super('num${optional ? '?' : ''}');

  factory NumNode.fromJson(Map<String, dynamic> json, bool optional) {
    return NumNode(
      data: json['data'],
      optional: optional,
    );
  }

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(data, 'num', optional),
    ];
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('value', data.source, 'num', false),
    ];
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type$,
      'data': data.value,
    };
  }
}

class GraphController extends Graph<BaseKnob> with JsonInteropMixin {
  @override
  Map<String, BaseKnob Function(Map<String, dynamic> json)> nodesMapper = {
    'String': (json) => StringNode.fromJson(json, false),
    'String?': (json) => StringNode.fromJson(json, true),
    'bool': (json) => BoolNode.fromJson(json, false),
    'bool?': (json) => BoolNode.fromJson(json, true),
    'num': (json) => NumNode.fromJson(json, false),
    'num?': (json) => NumNode.fromJson(json, true),
  };

  @override
  Map<String, dynamic> nodeToJson(BaseKnob node) {
    return {
      ...super.nodeToJson(node),
      ...node.toJson(),
    };
  }
}
