import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'base.dart';
import 'value.dart';

class BooleanNode<T extends bool> extends ValueNode<T> {
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
  Widget build() {
    return Checkbox(
      value: output.value,
      onChanged: () {
        if (output is Signal<bool>) {
          return (bool? val) => (output as Signal<bool>).set(val!);
        }
        return null;
      }(),
    );
  }

  @override
  Size size() => const Size(40, 30);
}

class TristateBooleanNode extends ValueNode<bool?> {
  TristateBooleanNode(
    super.value, {
    super.name = 'Boolean',
  });

  TristateBooleanNode.fromSource(
    super.source, {
    super.name = 'Boolean',
  }) : super.fromSource();

  TristateBooleanNode.computed({
    super.name = 'Boolean (readonly)',
    super.inputs,
  }) : super.computed();

  @override
  Widget build() {
    return Checkbox(
      tristate: true,
      value: output.value,
      onChanged: () {
        if (output is Signal<bool>) {
          return (bool? val) => (output as Signal<bool>).set(val!);
        }
        return null;
      }(),
    );
  }

  @override
  Size size() => const Size(40, 30);
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
