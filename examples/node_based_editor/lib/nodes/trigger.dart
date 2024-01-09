import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'value.dart';

class TriggerNode extends ValueNode<Object> {
  TriggerNode(
    super.value, {
    super.name = 'Trigger',
  });

  TriggerNode.fromSource(
    super.source, {
    super.name = 'Trigger',
  }) : super.fromSource();

  TriggerNode.computed({
    super.name = 'Trigger (readonly)',
    super.inputs,
  }) : super.computed();

  @override
  Widget build() {
    return FilledButton(
      key: ValueKey(output.value),
      onPressed: () {
        if (output is Signal<Object>) {
          return () {
            (output as Signal<Object>).set(Object());
            // ignore: avoid_print
            print(output.value.hashCode);
          };
        }
        return null;
      }(),
      child: const Text('Trigger'),
    );
  }

  @override
  Size size() => const Size(125, 45);
}
