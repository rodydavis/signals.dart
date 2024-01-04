import 'package:flutter/material.dart';

import 'value.dart';

class SwitchNode extends ValueNode<bool> {
  SwitchNode(
    super.value, {
    super.name = 'Switch',
  });

  @override
  Widget build() => Center(
        child: SizedBox(
          height: 40,
          width: 40,
          child: Switch(
            value: output.get(),
            onChanged: output.set,
          ),
        ),
      );

  @override
  Size size() => const Size(60, 60);
}
