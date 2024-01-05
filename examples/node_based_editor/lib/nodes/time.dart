import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

import 'value.dart';

class TimeOfDayNode extends ValueNode<TimeOfDay> {
  TimeOfDayNode(
    super.value, {
    super.name = 'TimeOfDay',
  });

  TimeOfDayNode.fromSource(
    super.source, {
    super.name = 'TimeOfDay (readonly)',
  }) : super.fromSource();

  @override
  Widget build() => Builder(builder: (context) {
        if (output is Signal<TimeOfDay>) {
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
              child: Text(output.value.format(context)),
            ),
          );
        }

        return Text(output.value.format(context));
      });

  @override
  Size size() => const Size(80, 20);
}
