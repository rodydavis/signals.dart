import 'package:flutter/material.dart';

class EnumField<T extends Enum> extends StatefulWidget {
  const EnumField({
    super.key,
    required this.valueFromString,
    required this.valueToString,
    required this.values,
    required this.value,
    required this.onChanged,
  });

  final T value;
  final ValueChanged<T> onChanged;
  final List<Enum> values;
  final T? Function(String) valueFromString;
  final String Function(T) valueToString;

  @override
  State<EnumField<T>> createState() => _EnumFieldState<T>();
}

class _EnumFieldState<T extends Enum> extends State<EnumField<T>> {
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
  void didUpdateWidget(covariant EnumField<T> oldWidget) {
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
    return DropdownButtonFormField(
      value: widget.value,
      isExpanded: true,
      items: [
        for (final item in widget.values)
          DropdownMenuItem(
            value: item,
            child: Text(item.name),
          ),
      ],
      onChanged: (val) {
        if (val is T) {
          widget.onChanged(val);
        }
      },
    );
  }
}
