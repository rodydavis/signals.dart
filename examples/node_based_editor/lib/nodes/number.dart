import 'package:flutter/material.dart';

import 'value.dart';

class NumberNode extends ValueNode<num> {
  NumberNode(
    super.value, {
    super.name = 'Number',
  });

  @override
  Widget build() => Center(
        child: SizedBox(
          height: 40,
          width: 40,
          child: TextFormField(
            initialValue: output.value.toString(),
            onChanged: (val) => output.value = num.tryParse(val) ?? 0,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(border: InputBorder.none),
            textAlign: TextAlign.center,
          ),
        ),
      );

  @override
  Size size() => const Size(60, 60);
}
