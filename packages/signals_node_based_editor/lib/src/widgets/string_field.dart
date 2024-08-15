import 'package:flutter/material.dart';

class StringField extends StatefulWidget {
  const StringField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  @override
  State<StringField> createState() => _StringFieldState();
}

class _StringFieldState extends State<StringField> {
  late final controller = TextEditingController(text: widget.value);

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      final str = controller.text.trim();
      if (str.isEmpty) return;
      final val = str;
      if (val.isEmpty) return;
      widget.onChanged(val);
    });
  }

  @override
  void didUpdateWidget(covariant StringField oldWidget) {
    if (oldWidget.value != widget.value) {
      final desc = widget.value;
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

class OptionalStringField extends StatefulWidget {
  const OptionalStringField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  State<OptionalStringField> createState() => _OptionalStringFieldState();
}

class _OptionalStringFieldState extends State<OptionalStringField> {
  late final controller = TextEditingController(text: widget.value);

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      final str = controller.text.trim();
      if (str.isEmpty) {
        widget.onChanged(null);
        return;
      }
      widget.onChanged(str);
    });
  }

  @override
  void didUpdateWidget(covariant OptionalStringField oldWidget) {
    if (oldWidget.value != widget.value) {
      final desc = widget.value;
      if (desc != controller.text) {
        controller.text = desc ?? '';
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
