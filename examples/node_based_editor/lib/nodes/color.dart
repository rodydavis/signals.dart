import 'package:flutter/material.dart';

import 'value.dart';

class ColorNode extends ValueNode<int> {
  ColorNode(
    super.value, {
    super.name = 'Color',
    this.colors = const [
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
    ],
  });

  final List<Color> colors;

  @override
  Widget build() => Center(
        child: SizedBox(
          height: 40,
          width: 40,
          child: PopupMenuButton(
            icon: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Color(output.value),
                shape: BoxShape.circle,
              ),
            ),
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
              if (!colors.any((e) => e.value == output.value))
                PopupMenuItem(
                  value: output.value,
                  child: const Text('Custom'),
                ),
            ],
            initialValue: output.get(),
            onSelected: output.set,
          ),
        ),
      );

  @override
  Size size() => const Size(60, 60);
}
