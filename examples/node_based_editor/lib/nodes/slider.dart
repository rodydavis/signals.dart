import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'value.dart';

class SliderNode extends ValueNode<double> {
  SliderNode(
    super.value, {
    super.name = 'Slider',
    this.min = 0.0,
    this.max = 1.0,
  });

  SliderNode.fromSource(
    super.source, {
    super.name = 'Slider (readonly)',
    this.min = 0.0,
    this.max = 1.0,
  }) : super.fromSource();

  final double min, max;

  @override
  Widget build() => Slider(
        value: output.get(),
        onChanged: () {
          if (output is Signal<double>) {
            return (output as Signal<double>).set;
          }
          return null;
        }(),
        min: min,
        max: max,
      );

  @override
  Size size() => const Size(180, 40);
}
