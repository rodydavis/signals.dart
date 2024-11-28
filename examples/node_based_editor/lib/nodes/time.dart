import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

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

  TimeOfDayNode.computed({
    super.name = 'TimeOfDay (computed)',
    super.inputs,
  }) : super.computed();

  @override
  Widget build() => Watch.builder(builder: (context) {
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

class CurrentTimeNode extends TimeOfDayNode {
  CurrentTimeNode({
    super.name = 'Current Time',
    Duration tick = const Duration(seconds: 1),
  }) : super.computed(inputs: []) {
    final timer = timerSignal(tick);
    output = computed(() {
      timer.value.value;
      return TimeOfDay.now();
    });
  }
}
