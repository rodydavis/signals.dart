import 'package:recase/recase.dart';
import 'package:signals/signals.dart';
import 'package:signals_node_based_editor/signals_node_based_editor.dart';

import 'base.dart';

class StringNode extends BaseNode {
  final Knob<String?> data;
  final EnumKnob<Recase> recase;
  final bool optional;

  StringNode({
    String? data,
    Recase recase = Recase.none,
    this.optional = false,
  })  : data = optional
            ? OptionalStringKnob('data', data ?? '')
            : StringKnob('data', data ?? ''),
        recase = EnumKnob('recase', recase, Recase.values),
        super('String${optional ? '?' : ''}');

  factory StringNode.fromJson(Map<String, dynamic> json, bool optional) {
    return StringNode(
      data: json['data'],
      optional: optional,
      recase: Recase.values.firstWhere(
        (e) => e.name == json['recase'],
        orElse: () => Recase.none,
      ),
    );
  }

  late Computed<String> result$ = computed(() {
    final value = ReCase(data.value ?? '');
    return switch (recase.value) {
      Recase.none => value.originalText,
      Recase.camelCase => value.camelCase,
      Recase.constantCase => value.constantCase,
      Recase.sentenceCase => value.sentenceCase,
      Recase.snakeCase => value.snakeCase,
      Recase.dotCase => value.dotCase,
      Recase.paramCase => value.paramCase,
      Recase.pathCase => value.pathCase,
      Recase.pascalCase => value.pascalCase,
      Recase.headerCase => value.headerCase,
      Recase.titleCase => value.titleCase,
    };
  });

  @override
  late Computed<List<NodeWidgetInput>> inputs = computed(() {
    return [
      ...super.inputs.value,
      NodeWidgetInput(data, 'String', optional),
      NodeWidgetInput(recase, 'Recase', false),
    ];
  });

  @override
  late Computed<List<NodeWidgetOutput>> outputs = computed(() {
    return [
      ...super.outputs.value,
      NodeWidgetOutput('value', result$, 'String', false),
    ];
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data.value,
      'recase': recase.value.name,
    };
  }
}

enum Recase {
  none,
  camelCase,
  constantCase,
  sentenceCase,
  snakeCase,
  dotCase,
  paramCase,
  pathCase,
  pascalCase,
  headerCase,
  titleCase,
}
