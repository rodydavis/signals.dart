import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'base.dart';

class CompareNode<T extends num> extends Node<T, bool> {
  @override
  late final Computed<bool> output;
  late final Signal<Operator> current;

  CompareNode(Operator operatorCompare, Node<dynamic, T> a, Node<dynamic, T> b)
      : current = signal(operatorCompare),
        super(
          name: 'Compare Node',
          inputs: [a, b],
        ) {
    output = computed(() {
      final aVal = a.output();
      final bVal = b.output();
      return switch (current.value) {
        Operator.greaterThan => aVal > bVal,
        Operator.greaterThanEqualTo => aVal >= bVal,
        Operator.lessThan => aVal < bVal,
        Operator.lessThanEqualTo => aVal <= bVal,
        Operator.equalTo => aVal == bVal,
        Operator.notEqualTo => aVal != bVal,
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
              items: Operator.values
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

enum Operator {
  greaterThan,
  greaterThanEqualTo,
  lessThan,
  lessThanEqualTo,
  equalTo,
  notEqualTo,
}
