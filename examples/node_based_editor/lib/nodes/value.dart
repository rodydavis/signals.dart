import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'base.dart';

abstract class ValueNode<T> extends Node<void, T> {
  @override
  final Signal<T> output;

  ValueNode(
    T value, {
    super.name = 'Value',
  })  : output = signal(value),
        super(inputs: []);

  @override
  Size size() => const Size(60, 60);
}
