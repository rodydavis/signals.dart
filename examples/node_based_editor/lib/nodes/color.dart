import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'base.dart';
import 'value.dart';

class ColorNode extends ValueNode<Color> {
  static const defaultColors = <Color>[
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];

  ColorNode(
    super.value, {
    super.name = 'Color',
    this.colors = defaultColors,
  });

  ColorNode.fromSource(
    super.source, {
    super.name = 'Color (readonly)',
    this.colors = defaultColors,
  }) : super.fromSource();

  ColorNode.fromRGBO(
    Node<dynamic, int> red,
    Node<dynamic, int> green,
    Node<dynamic, int> blue,
    Node<dynamic, double> opacity, {
    super.name = 'Color (readonly)',
    this.colors = defaultColors,
  }) : super.computed(inputs: [red, green, blue, opacity]) {
    output = computed(() {
      return Color.fromRGBO(
        red.output.value,
        green.output.value,
        blue.output.value,
        opacity.output.value,
      );
    });
  }

  final List<Color> colors;

  @override
  Widget build() => Center(
        child: SizedBox(
          height: 40,
          width: 40,
          child: () {
            final current = Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: output.value,
                shape: BoxShape.circle,
              ),
            );
            if (output is Signal<Color>) {
              return PopupMenuButton<int>(
                icon: current,
                itemBuilder: (context) => [
                  for (final color in colors)
                    PopupMenuItem(
                      value: color.value,
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(() {
                            // RGB
                            final r = color.red;
                            final g = color.green;
                            final b = color.blue;
                            return 'rgb($r,$g,$b)';
                          }()),
                        ],
                      ),
                    ),
                  if (!colors.any((e) => e.value == output.value.value))
                    PopupMenuItem(
                      value: output.value.value,
                      child: const Text('Custom'),
                    ),
                ],
                initialValue: output.get().value,
                onSelected: (val) => (output as Signal<Color>).set(Color(val)),
              );
            }
            return current;
          }(),
        ),
      );

  @override
  Size size() => const Size(60, 60);
}
