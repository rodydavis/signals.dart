import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'base.dart';
import 'value.dart';

class TextNode extends ValueNode<String> {
  TextNode(
    super.value, {
    super.name = 'Text',
    this.multiline = false,
  });

  TextNode.fromSource(
    super.source, {
    super.name = 'Text (readonly)',
    this.multiline = false,
  }) : super.fromSource();

  TextNode.computed({
    super.name = 'Text (computed)',
    this.multiline = false,
    super.inputs,
  }) : super.computed();

  final bool multiline;

  @override
  Widget build() {
    if (output is Signal<String>) {
      return TextFormField(
        initialValue: output.get(),
        onChanged: (output as Signal<String>).set,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(filled: true),
        maxLines: multiline ? null : 1,
      );
    }
    return Text(output.toString());
  }

  @override
  Size size() =>
      Size(150, multiline ? (40.0 * output.toString().split('\n').length) : 40);
}

class DynamicToText extends TextNode {
  DynamicToText(
    dynamic value, {
    super.name = 'Dynamic to Text',
  }) : super(value.toString());

  DynamicToText.fromSource(
    Node<dynamic, dynamic> source, {
    super.name = 'Dynamic to Text (readonly)',
  }) : super.computed(inputs: [source]) {
    output = computed(() => source.output.value.toString());
  }

  DynamicToText.computed(
    Node<dynamic, dynamic> source, {
    super.name = 'Dynamic to Text (computed)',
  }) : super.computed();
}

class DynamicToTextOnTrigger extends TextNode {
  DynamicToTextOnTrigger.fromSource(
    Node<dynamic, dynamic> source,
    Node<dynamic, Object> trigger, {
    super.name = 'Dynamic Trigger (readonly)',
  }) : super.computed(inputs: [source, trigger]) {
    output = computed(() {
      trigger.output.value;
      return source.output.peek().toString();
    });
  }
}
