import 'package:flutter/material.dart';

import 'value.dart';

class DateTimeNode extends ValueNode<DateTime> {
  DateTimeNode(
    super.value, {
    super.name = 'DateTime',
    this.firstDate,
    this.lastDate,
  });

  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build() => Center(
        child: Builder(builder: (context) {
          return InkWell(
            onTap: () {
              final now = DateTime.now();
              showDatePicker(
                context: context,
                firstDate: firstDate ?? now.subtract(const Duration(days: 365)),
                lastDate: lastDate ?? now.add(const Duration(days: 365)),
                currentDate: output.value,
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
