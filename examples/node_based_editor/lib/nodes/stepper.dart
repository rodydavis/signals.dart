import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'base.dart';
import 'number.dart';

class StepperNode extends NumberNode {
  StepperNode(
    super.value, {
    super.name = 'Stepper',
  });

  final _cleanup = <EffectCleanup>[];

  StepperNode.fromTriggers(
    num initial, {
    super.name = 'Stepper (Triggers)',
    required Node<dynamic, Object> increment,
    required Node<dynamic, Object> decrement,
  }) : super.computed(inputs: [increment, decrement]) {
    output = trackedSignal(initial);
    _cleanup.add(effect(() {
      increment.output.value;
      final out = output as Signal<num>;
      out.value = out.peek() + 1;
    }));
    _cleanup.add(effect(() {
      decrement.output.value;
      final out = output as Signal<num>;
      out.value = out.peek() - 1;
    }));
    output.onDispose(() {
      for (final cb in _cleanup) {
        cb();
      }
    });
  }

  @override
  Widget build() => Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: 'Increment',
                  onPressed: () => (output as Signal<num>).value += 1,
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  tooltip: 'Decrement',
                  onPressed: () => (output as Signal<num>).value -= 1,
                  icon: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: 'Reset',
                  onPressed: () => (output as Signal<num>).value =
                      (output as TrackedSignal<num>).initialValue,
                  icon: const Icon(Icons.restore),
                ),
                IconButton(
                  tooltip: 'Undo',
                  onPressed: () => (output as Signal<num>).value =
                      (output as TrackedSignal<num>).previousValue ??
                          (output as TrackedSignal<num>).initialValue,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Text('Value: $output'),
          )
        ],
      );

  @override
  Size size() => const Size(180, 60);
}
