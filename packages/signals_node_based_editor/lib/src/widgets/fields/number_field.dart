import 'package:flutter/material.dart';

class NumberField<T extends num> extends StatefulWidget {
  const NumberField({
    super.key,
    required this.valueFromString,
    required this.valueToString,
    required this.value,
    required this.onChanged,
  });

  final T value;
  final ValueChanged<T> onChanged;
  final T? Function(String) valueFromString;
  final String Function(T) valueToString;

  @override
  State<NumberField<T>> createState() => _NumberFieldState<T>();
}

class _NumberFieldState<T extends num> extends State<NumberField<T>> {
  late final controller = TextEditingController(
    text: widget.valueToString(widget.value),
  );

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      final str = controller.text.trim();
      if (str.isEmpty) return;
      final val = widget.valueFromString(str);
      if (val == null) return;
      widget.onChanged(val);
    });
  }

  @override
  void didUpdateWidget(covariant NumberField<T> oldWidget) {
    if (oldWidget.value != widget.value) {
      final desc = widget.valueToString(widget.value);
      if (desc != controller.text) {
        controller.text = desc;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
    );
  }
}

class OptionalNumberField<T extends num> extends StatefulWidget {
  const OptionalNumberField({
    super.key,
    required this.valueFromString,
    required this.valueToString,
    required this.value,
    required this.onChanged,
  });

  final T? value;
  final ValueChanged<T?> onChanged;
  final T? Function(String) valueFromString;
  final String Function(T?) valueToString;

  @override
  State<OptionalNumberField<T>> createState() => _OptionalNumberFieldState<T>();
}

class _OptionalNumberFieldState<T extends num>
    extends State<OptionalNumberField<T>> {
  late final controller = TextEditingController(
    text: widget.valueToString(widget.value),
  );

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      final str = controller.text.trim();
      if (str.isEmpty) {
        widget.onChanged(null);
        return;
      }
      final val = widget.valueFromString(str);
      if (val == null) return;
      widget.onChanged(val);
    });
  }

  @override
  void didUpdateWidget(covariant OptionalNumberField<T> oldWidget) {
    if (oldWidget.value != widget.value) {
      final desc = widget.valueToString(widget.value);
      if (desc != controller.text) {
        controller.text = desc;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
    );
  }
}
