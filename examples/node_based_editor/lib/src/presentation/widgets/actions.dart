import 'package:flutter/material.dart';

Future<String?> prompt(
  BuildContext context, {
  String? value,
  String title = 'Edit Text',
}) async {
  final controller = TextEditingController(text: value);
  final theme = Theme.of(context);
  final colors = theme.colorScheme;
  final saved = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: colors.surface,
      contentTextStyle: TextStyle(
        color: colors.onSurface,
      ),
      title: Text(title),
      content: StatefulBuilder(
        builder: (context, setState) {
          return TextField(
            autofocus: true,
            controller: controller,
            onEditingComplete: () => Navigator.of(context).pop(true),
          );
        },
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: const Text('Save'),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
  return saved == true ? controller.text : null;
}

Future<bool> confirm(
  BuildContext context, {
  String title = 'Confirm',
  String? content,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: const Text('Confirm'),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
  return result ?? false;
}

Future<void> alert(
  BuildContext context, {
  String title = 'Alert',
  String? content,
}) async {
  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: content != null ? Text(content) : null,
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}
