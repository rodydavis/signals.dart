import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

abstract class Node<I, O> {
  final String name;
  final List<Node<dynamic, I>> inputs;

  int get id => output.globalId;
  ReadonlySignal<O> get output;

  const Node({
    required this.name,
    required this.inputs,
  });

  Widget build();

  Size size();

  Widget buildWithNodes() {
    const dragWidth = 10.0;
    return SizedBox.fromSize(
      size: size(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            width: dragWidth,
            top: 0,
            left: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
            ),
          ),
          Positioned.fill(
            left: dragWidth,
            child: Center(child: build()),
          ),
          Positioned.fromRect(
            rect: outputOffset & _circle,
            child: nodeCircle(Colors.blue),
          ),
          for (final offset in inputOffsets)
            Positioned.fromRect(
              rect: offset & _circle,
              child: nodeCircle(Colors.red),
            ),
        ],
      ),
    );
  }

  Offset get outputOffset => Offset(size().width, 0);

  Map<Node, Offset> get inputsWithOffsets => {
        for (var i = 0; i < inputs.length; i++)
          inputs[i]: Offset(-_circle.width, i * (_circle.height + _gap))
      };

  List<Offset> get inputOffsets => [
        for (var i = 0; i < inputs.length; i++)
          Offset(-_circle.width, i * (_circle.height + _gap))
      ];
}

const _circle = Size(20, 20);
const _gap = 5.0;
final circleCenter = Offset(_circle.width / 2, _circle.height / 2);

Widget nodeCircle(Color color) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    width: _circle.width,
    height: _circle.height,
  );
}
