import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'base.dart';
import 'value.dart';

class BooleanNode extends ValueNode<bool> {
  BooleanNode(
    super.value, {
    super.name = 'Boolean',
  });

  BooleanNode.fromSource(
    super.source, {
    super.name = 'Boolean',
  }) : super.fromSource();

  BooleanNode.computed({
    super.name = 'Boolean (readonly)',
    super.inputs,
  }) : super.computed();

  @override
  Widget build() => Center(
        child: SizedBox(
          height: 40,
          width: 40,
          child: Text(output.toString()),
        ),
      );

  @override
  Size size() => const Size(60, 60);
}

class IntToBoolean extends BooleanNode {
  IntToBoolean(
    int value, {
    super.name = 'Int to Boolean',
  }) : super(value == 1);

  IntToBoolean.fromSource(
    Node<dynamic, int> source, {
    super.name = 'Int to Boolean (readonly)',
  }) : super.computed(inputs: [source]) {
    output = computed(() => source.output.value == 1);
  }
}

class NegatedBooleanNode extends BooleanNode {
  NegatedBooleanNode(
    bool value, {
    super.name = 'Negated Boolean',
  }) : super(!value);

  NegatedBooleanNode.fromSource(
    Node<dynamic, bool> source, {
    super.name = 'Negated Boolean (readonly)',
  }) : super.computed(inputs: [source]) {
    output = computed(() => !source.output.value);
  }
}
