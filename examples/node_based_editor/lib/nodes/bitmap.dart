import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'base.dart';

class BitmapNode extends Node<dynamic, List<bool>> {
  BitmapNode({
    super.name = 'Bitmap',
    required List<bool> initial,
    required this.crossAxisCount,
    this.offColor,
    this.onColor,
  })  : output = listSignal<bool>(initial.toList()),
        super(inputs: []);

  BitmapNode.fromSource({
    super.name = 'Bitmap (readonly)',
    required List<Node<dynamic, bool>> sources,
    required this.crossAxisCount,
    this.offColor,
    this.onColor,
  })  : output = computed(() => sources.map((e) => e.output.value).toList()),
        super(inputs: [
          ...sources,
          if (offColor != null) offColor,
          if (onColor != null) onColor,
        ]);

  BitmapNode.grid9({
    super.name = 'Bitmap (3x3)',
    List<bool> initial = const [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ],
    this.crossAxisCount = 3,
    this.offColor,
    this.onColor,
  })  : output = listSignal<bool>(initial.toList()),
        super(inputs: [
          if (offColor != null) offColor,
          if (onColor != null) onColor,
        ]);

  @override
  late final ReadonlySignal<List<bool>> output;

  final int crossAxisCount;

  final Node<dynamic, Color>? offColor, onColor;

  @override
  Size size() => Size(
        10 + (25.0 * crossAxisCount),
        (output.value.length / crossAxisCount) * 25.0,
      );

  @override
  Widget build() {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      children: [
        for (var i = 0; i < output.value.length; i++)
          Center(
            child: SizedBox(
                height: 20,
                width: 20,
                child: InkWell(
                  onTap: () {
                    if (output is ListSignal<bool>) {
                      final lsit = output as ListSignal<bool>;
                      return () => lsit[i] = !lsit[i];
                    }
                    return null;
                  }(),
                  child: Container(
                    color: output.value[i]
                        ? (offColor?.output.value ?? Colors.black)
                        : (onColor?.output.value ?? Colors.white),
                  ),
                )),
          ),
      ],
    );
  }
}
