---
title: useMapSignal
description: Creates a new MapSignal and subscribes to it.
---

Creates a new [MapSignal](/packages/signals/value/map) and subscribes to it.

A [MapSignal](/packages/signals/value/map) provides a reactive wrapper around a standard Dart **Map**. It tracks in-place mutations
(such as entry addition, value updates, or key removals) and automatically triggers rebuilds of the host **HookWidget**.

<Success>
Excellent for storing state dictionaries, form configurations, cached records, or key-value structures
that require fine-grained reactivity.
</Success>

### Parameters
- **value**: The initial map entries.
- **options**: The options for the signal.
- **keys**: A list of objects to watch. If any key changes, the map signal is re-created.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class DynamicFormWidget extends HookWidget {
  const DynamicFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final formData = useMapSignal<String, String>({});

    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Email'),
          onChanged: (val) => formData['email'] = val,
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Password'),
          onChanged: (val) => formData['password'] = val,
        ),
        Text('Live Form Data: ${formData.value}'),
      ],
    );
  }
}
````
