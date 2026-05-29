---
title: "Type: useMapSignal"
description: "API reference and details for useMapSignal from signals.dart."
---

# useMapSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useMapSignal

```dart
MapSignal<K, V> useMapSignal(Map<K, V> value, {List<Object?> keys = const <Object>[], MapSignalOptions<K, V>? options})
```

Creates a new [MapSignal](/types/mapsignal) and subscribes to it.

A [MapSignal](/types/mapsignal) provides a reactive wrapper around a standard Dart **Map**. It tracks in-place mutations
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

## References

The **useMapSignal** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useMapSignal](/packages/signals_hooks/hooks/use-map-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-hooks AI Skill](/skills/signals-hooks) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

