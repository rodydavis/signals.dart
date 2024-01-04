import 'package:flutter/material.dart';

import 'value.dart';

class SliderNode extends ValueNode<double> {
  SliderNode(
    super.value, {
    super.name = 'Slider',
    this.min = 0.0,
    this.max = 1.0,
  });

  final double min, max;

  @override
  Widget build() => Center(
        child: SizedBox(
          height: 40,
          width: 170,
          child: Slider(
            value: output.get(),
            onChanged: output.set,
            min: min,
            max: max,
          ),
        ),
      );

  @override
  Size size() => const Size(180, 60);
}
