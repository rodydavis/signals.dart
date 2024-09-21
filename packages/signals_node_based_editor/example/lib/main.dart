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
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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

abstract class BaseNode extends GraphNode {
  @override
  final String type$;
  BaseNode(this.type$);

  Map<String, dynamic> toJson();
}

class StringNode extends BaseNode {
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
      'data': data.value,
    };
  }
}

class BoolNode extends BaseNode {
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
      'data': data.value,
    };
  }
}

class NumNode extends BaseNode {
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
      'data': data.value,
    };
  }
}

class AddKnob extends Knob<Object> {
  AddKnob() : super('+', Object());
}

abstract class ListNode<T> extends BaseNode {
  final int? maxLength, minLength;
  final bool canRemove;
  final ListSignal<Knob<T>> items;
  final AddKnob? addKnob;
  final bool optional;
  final String listType;

  late Computed<String> listType$ = computed(() {
    if (items.isNotEmpty) {
      final types = items.map((e) => e.label).toSet();
      if (types.length == 1) return types.first;
    }
    return listType;
  });

  ListNode(
    this.items, {
    this.listType = 'Object',
    this.addKnob,
    this.maxLength,
    this.minLength,
    this.canRemove = true,
    this.optional = false,
  }) : super('List<$listType${optional ? '?' : ''}>');

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      for (var i = 0; i < items.length; i++)
        NodeWidgetInput(items[i], listType$.value, optional),
      if (addKnob != null) NodeWidgetInput(addKnob!, listType$.value, optional),
    ];
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('List', items, listType$.value, false),
    ];
  });
}

class StringList extends ListNode<String> {
  StringList({
    List<String> items = const [],
    super.optional,
  }) : super(
          listSignal([
            for (var i = 0; i < items.length; i++) StringKnob('$i', items[i])
          ]),
          listType: 'String',
          addKnob: AddKnob(),
          maxLength: null,
          minLength: null,
          canRemove: true,
        );

  factory StringList.fromJson(Map<String, dynamic> json, bool optional) {
    return StringList(
      items: (json['items'] as List).cast<String>(),
      optional: optional,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'listType': listType,
      'items': items.map((e) => e.value).toList(),
    };
  }
}

abstract class InputNode extends BaseNode {
  InputNode(super.type$);
}

abstract class OutputNode extends BaseNode {
  OutputNode(super.type$);
}

abstract class GroupNode extends BaseNode {
  GroupNode(super.type$);

  ReadonlySignal<List<InputNode>> get inputNodes$;

  ReadonlySignal<List<OutputNode>> get outputNodes$;

  ReadonlySignal<List<BaseNode>> get nodes$;
}

class GraphController extends Graph<BaseNode> with JsonInteropMixin {
  @override
  Map<String, BaseNode Function(Map<String, dynamic> json)> nodesMapper = {
    'String': (json) => StringNode.fromJson(json, false),
    'String?': (json) => StringNode.fromJson(json, true),
    'bool': (json) => BoolNode.fromJson(json, false),
    'bool?': (json) => BoolNode.fromJson(json, true),
    'num': (json) => NumNode.fromJson(json, false),
    'num?': (json) => NumNode.fromJson(json, true),
    'List<String>': (json) => StringList.fromJson(json, false),
    'List<String>?': (json) => StringList.fromJson(json, true),
  };

  @override
  Map<String, dynamic> nodeToJson(BaseNode node) {
    return {
      ...super.nodeToJson(node),
      ...node.toJson(),
    };
  }

  @override
  void connectKnobToSource(
    (BaseNode, NodeWidgetInput) input,
    (BaseNode, NodeWidgetOutput) output,
  ) {
    if (input.$1 is ListNode) {
      final list = input.$1 as ListNode;
      // Add new item to list
      if (list.addKnob != null && input.$2.knob == list.addKnob!) {
        final index = list.items.length;
        batch(() {
          final Knob<dynamic> knob = StringKnob('$index', '');
          list.items.add(knob);
          knob.source = output.$2.source;
        });
        return;
      }
    }
    // input.$2.knob.source = output.$2.source;
    super.connectKnobToSource(input, output);
  }

  @override
  void disconnectKnobFromSource(BaseNode node, NodeWidgetInput input) {
    if (node is ListNode) {
      if (!node.canRemove) return;
      node.items.remove(input.knob);
    }
    super.disconnectKnobFromSource(node, input);
  }
}
