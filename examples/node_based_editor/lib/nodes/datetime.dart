import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import 'value.dart';

class DateTimeNode extends ValueNode<DateTime> {
  DateTimeNode(
    super.value, {
    super.name = 'DateTime',
    this.firstDate,
    this.lastDate,
  });

  DateTimeNode.fromSource(
    super.source, {
    super.name = 'DateTime (readonly)',
    this.firstDate,
    this.lastDate,
  }) : super.fromSource();

  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build() {
    if (output is Signal<DateTime>) {
      return Watch.builder(builder: (context) {
        return InkWell(
          onTap: () {
            final now = DateTime.now();
            showDatePicker(
              context: context,
              firstDate: firstDate ?? now.subtract(const Duration(days: 365)),
              lastDate: lastDate ?? now.add(const Duration(days: 365)),
              currentDate: output.value,
              initialDate: output.value,
            );
          },
          child: Text(output.value.toIso8601String()),
        );
      });
    }
    return Text(output.value.toIso8601String());
  }

  @override
  Size size() => const Size(180, 20);
}
