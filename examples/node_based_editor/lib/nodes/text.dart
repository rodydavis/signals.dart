import 'package:flutter/material.dart';

import 'value.dart';

class TextNode extends ValueNode<String> {
  TextNode(
    super.value, {
    super.name = 'Text',
    this.multiline = false,
  });

  final bool multiline;

  @override
  Widget build() => Center(
        child: SizedBox(
          width: 140,
          child: TextFormField(
            initialValue: output.get(),
            onChanged: output.set,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(border: InputBorder.none),
            maxLines: multiline ? null : 1,
          ),
        ),
      );

  @override
  Size size() => const Size(150, 60);
}
