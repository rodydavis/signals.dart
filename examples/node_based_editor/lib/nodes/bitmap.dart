import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'base.dart';

class BitmapNode extends Node<void, List<bool>> {
  BitmapNode({
    super.name = 'Bitmap',
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
  })  : output = listSignal<bool>(initial.toList()),
        super(inputs: []);

  @override
  late final ListSignal<bool> output;

  @override
  Size size() => const Size(80, 80);

  @override
  Widget build() {
    return GridView.count(
      crossAxisCount: 3,
      children: [
        for (var i = 0; i < 9; i++)
          Center(
            child: SizedBox(
                height: 20,
                width: 20,
                child: InkWell(
                  onTap: () => output[i] = !output[i],
                  child: Container(
                    color: output[i] ? Colors.black : Colors.white,
                  ),
                )),
          ),
      ],
    );
  }
}
