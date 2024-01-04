import 'package:flutter/material.dart';

import 'value.dart';

class TimeOfDayNode extends ValueNode<TimeOfDay> {
  TimeOfDayNode(
    super.value, {
    super.name = 'TimeOfDay',
  });

  @override
  Widget build() => Center(
        child: Builder(builder: (context) {
          return InkWell(
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: output.value,
              );
            },
            child: SizedBox(
              height: 40,
              width: 90,
              child: Text(output.toString()),
            ),
          );
        }),
      );

  @override
  Size size() => const Size(100, 60);
}
