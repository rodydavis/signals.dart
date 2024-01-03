import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

abstract class Node<I, O> {
  final String name;
  final List<Node<dynamic, I>> inputs;

  int get id => output.globalId;

  const Node({
    required this.name,
    required this.inputs,
  });

  ReadonlySignal<O> get output;

  Widget build();

  Size size();
}
