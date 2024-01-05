import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'base.dart';

abstract class ValueNode<T> extends Node<dynamic, T> {
  final Node<dynamic, T>? source;

  @override
  late final ReadonlySignal<T> output;

  ValueNode(
    T value, {
    super.name = 'Value',
  })  : output = signal(value),
        source = null,
        super(inputs: []);

  ValueNode.fromSource(
    Node<dynamic, T> this.source, {
    super.name = 'Value (readonly)',
  })  : output = computed(() => source.output.value),
        super(inputs: [source]);

  ValueNode.computed({
    super.name = 'Value (computed)',
    super.inputs = const [],
  }) : source = null;

  @override
  Size size() => const Size(60, 60);
}
