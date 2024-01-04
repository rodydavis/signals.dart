import 'package:flutter/material.dart';

import 'number.dart';

class StepperNode extends NumberNode {
  StepperNode(super.value, {super.name = 'Stepper'});

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
                  onPressed: () => output.value += 1,
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  tooltip: 'Decrement',
                  onPressed: () => output.value -= 1,
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
                  onPressed: () => output.value = output.initialValue,
                  icon: const Icon(Icons.restore),
                ),
                IconButton(
                  tooltip: 'Undo',
                  onPressed: () => output.value = output.previousValue,
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
