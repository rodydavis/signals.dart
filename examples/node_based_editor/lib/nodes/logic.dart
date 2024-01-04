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
        BitwiseOperator.or => aVal | bVal,
        BitwiseOperator.exclusiveOr => aVal ^ bVal,
      };
    });
  }

  @override
  Widget build() => Stack(
        children: [
          Positioned(
            top: 5,
            right: 5,
            child: Text('Result: $output'),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            left: 5,
            child: DropdownButton(
              isDense: true,
              items: BitwiseOperator.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      ))
                  .toList(),
              value: current.value,
              onChanged: (val) => current.set(val!),
            ),
          ),
        ],
      );

  @override
  Size size() => const Size(200, 60);
}

enum BitwiseOperator {
  and,
  or,
  exclusiveOr,
}
