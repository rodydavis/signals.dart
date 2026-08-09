---
title: "Type: useComputed"
description: "API reference and details for useComputed from signals.dart."
---

# useComputed

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useComputed

```dart
FlutterComputed<T> useComputed(T Function() value, {List<Object?> keys = const <Object>[], ComputedOptions<T>? options})
```

Creates a new [Computed](/types/computed) signal and subscribes to it.

This hook is useful for deriving state within a **HookWidget** based on other signals or values.
The callback **value** is evaluated lazily and cached. It is recomputed only when the dependent
signals inside the callback change, or if any of the hook **keys** change.

The host widget will rebuild whenever the derived value changes.

<Info>
  Use computed signals to keep build methods clean and prevent unnecessary re-computations
  of expensive operations (e.g., filtering, sorting, or formatting data).
</Info>

### Parameters
- **value**: The computation callback that derives the computed value.
- **keys**: A list of objects to watch for changes. If any key changes, the computed signal is re-created.
- **debugLabel**: An optional debug label to identify the computed signal in developer tools.

### Returns
A [FlutterComputed](/types/fluttercomputed) signal containing the derived value.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class DerivedStateWidget extends HookWidget {
  const DerivedStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final firstName = useSignal('John');
    final lastName = useSignal('Doe');

    // Derived full name computed from the individual signals
    final fullName = useComputed(
      () => '${firstName.value} ${lastName.value}',
      keys: [firstName, lastName],
    );

    return Column(
      children: [
        Text('Full Name: ${fullName.value}'),
        ElevatedButton(
          onPressed: () => firstName.value = 'Jane',
          child: const Text('Change First Name'),
        ),
      ],
    );
  }
}
````

## References

The **useComputed** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useComputed](/packages/signals_hooks/hooks/use-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-hooks AI Skill](/skills/signals-hooks) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

