import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'base.dart';

class LogicNode extends Node<bool, bool> {
  @override
  late final Computed<bool> output;
  late final Signal<BitwiseOperator> current;

  LogicNode(
    BitwiseOperator operatorCompare,
    Node<dynamic, bool> a,
    Node<dynamic, bool> b, {
    super.name = 'Logic Node',
  })  : current = signal(operatorCompare),
        super(inputs: [a, b]) {
    output = computed(() {
      final aVal = a.output();
      final bVal = b.output();
      return switch (current.value) {
        BitwiseOperator.and => aVal & bVal,
        BitwiseOperator.negatedAnd => !(aVal & bVal),
        BitwiseOperator.or => aVal | bVal,
        BitwiseOperator.negatedOr => !(aVal | bVal),
        BitwiseOperator.exclusiveOr => aVal ^ bVal,
        BitwiseOperator.negatedExclusiveOr => !(aVal ^ bVal),
      };
    });
  }

  @override
  Widget build() => Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButton(
              isDense: true,
              items: BitwiseOperator.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(switch (e) {
                          BitwiseOperator.and => 'AND',
                          BitwiseOperator.negatedAnd => 'NAND',
                          BitwiseOperator.or => 'OR',
                          BitwiseOperator.negatedOr => 'NOR',
                          BitwiseOperator.exclusiveOr => 'XOR',
                          BitwiseOperator.negatedExclusiveOr => 'XNOR',
                        }),
                      ))
                  .toList(),
              value: current.value,
              onChanged: (val) => current.set(val!),
            ),
          ),
          const SizedBox(width: 10),
          Text(output.value.toString()),
          const SizedBox(width: 10),
        ],
      );

  @override
  Size size() => const Size(150, 60);
}

enum BitwiseOperator {
  and,
  or,
  exclusiveOr,
  negatedAnd,
  negatedOr,
  negatedExclusiveOr
}
