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

class IntSliderNode extends ValueNode<int> {
  IntSliderNode(
    super.value, {
    super.name = 'Int Slider',
    this.min = 0,
    this.max = 100,
  });

  IntSliderNode.fromSource(
    super.source, {
    super.name = 'Int Slider (readonly)',
    this.min = 0,
    this.max = 100,
  }) : super.fromSource();

  final int min, max;

  @override
  Widget build() => Slider(
        value: output.get().toDouble(),
        onChanged: () {
          if (output is Signal<int>) {
            return (val) => (output as Signal<int>).set(val.toInt());
          }
          return null;
        }(),
        min: min.toDouble(),
        max: max.toDouble(),
      );

  @override
  Size size() => const Size(180, 40);
}
