import 'package:flutter/material.dart';

import 'nodes/time.dart';
import 'nodes/color.dart';
import 'nodes/logic.dart';
import 'nodes/base.dart';
import 'nodes/reduce.dart';
import 'nodes/text.dart';

class CodeView extends StatelessWidget {
  const CodeView({
    super.key,
    required this.nodes,
    required this.selected,
    this.lang = 'dart',
  });

  final List<Node> nodes;
  final Set<Node> selected;
  final String lang;

  @override
  Widget build(BuildContext context) {
    final nodesWithName = <Node, String>{
      for (var i = 0; i < nodes.length; i++) nodes[i]: 'signal$i',
    };

    Iterable<InlineSpan> generate() sync* {
      if (lang == 'dart') {
        yield const TextSpan(text: "import 'package:flutter/material.dart';\n");
        yield const TextSpan(text: "import 'package:signals/signals.dart';\n");
        yield const TextSpan(text: "\n");
      }
      final selectedStyle = TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
      );
      for (final node in nodes) {
        final isSelected = selected.contains(node);
        final style = isSelected ? selectedStyle : null;
        yield TextSpan(text: "// ${node.name}\n", style: style);
        final name = nodesWithName[node]!;
        yield TextSpan(text: "final $name = ", style: style);
        if (node.inputs.isEmpty) {
          if (node is ColorNode) {
            yield TextSpan(
                text: 'signal<Color>(Color(${node.output.value.value}))',
                style: style);
          } else if (node is CurrentTimeNode) {
            yield TextSpan(
                text: 'signal<TimeOfDay>(TimeOfDay.now())', style: style);
          } else {
            yield TextSpan(text: 'signal(${node.output.value})', style: style);
          }
        } else {
          yield TextSpan(text: 'computed(() {\n', style: style);
          for (final input in node.inputs) {
            final target = nodesWithName[input]!;
            yield TextSpan(
                text: '  final _$target = $target.value;\n', style: style);
            if (node.inputs.length == 1) {
              if (node is DynamicToText) {
                yield TextSpan(
                    text: '  return _$target.toString();\n', style: style);
              } else {
                yield TextSpan(text: '  return _$target;\n', style: style);
              }
            }
          }

          if (node.inputs.length > 1) {
            final list = node.inputs
                .map((e) => '_${nodesWithName[e]!}')
                .toList()
                .join(',');
            if (node is ReduceNode) {
              final compare = switch (node.current.value) {
                Reducer.add => '+',
                Reducer.subtract => '-',
                Reducer.divide => '/',
                Reducer.multiply => '*',
                Reducer.modulo => '%',
                Reducer.truncateDivision => '~/',
              };
              yield TextSpan(
                  text: '  return [$list].reduce((a, b) => a $compare b);\n',
                  style: style);
            }
            if (node is LogicNode) {
              final a = '_${nodesWithName[node.inputs.first]!}';
              final b = '_${nodesWithName[node.inputs.last]!}';
              final compare = switch (node.current.value) {
                BitwiseOperator.and => '$a & $b',
                BitwiseOperator.negatedAnd => '!($a & $b)',
                BitwiseOperator.or => '$a | $b',
                BitwiseOperator.negatedOr => '!($a | $b)',
                BitwiseOperator.exclusiveOr => '$a ^ $b',
                BitwiseOperator.negatedExclusiveOr => '!($a ^ $b)',
              };
              yield TextSpan(text: '  return $compare;\n', style: style);
            }
          }
          yield TextSpan(text: '})', style: style);
        }
        yield TextSpan(text: ';\n', style: style);
      }
    }

    return DefaultTextStyle(
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      child: Text.rich(
        TextSpan(
          children: generate().toList(),
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        ),
      ),
    );
  }
}
