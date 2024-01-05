import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'boolean.dart';

class SwitchNode extends BooleanNode {
  SwitchNode(
    super.value, {
    super.name = 'Switch',
  });

  SwitchNode.fromSource(
    super.source, {
    super.name = 'Switch (readonly)',
  }) : super.fromSource();

  SwitchNode.computed({
    super.name = 'Switch (computed)',
    super.inputs,
  }) : super.computed();

  @override
  Widget build() => Switch(
        value: output.get(),
        onChanged: () {
          if (output is Signal<bool>) {
            return (output as Signal<bool>).set;
          }
          return null;
        }(),
      );

  @override
  Size size() => const Size(70, 40);
}
