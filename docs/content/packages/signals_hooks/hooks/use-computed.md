---
title: useComputed
description: Creates a new Computed signal and subscribes to it.
---

Creates a new [Computed](/packages/signals/core/computed) signal and subscribes to it.

This hook is useful for deriving state within a **HookWidget** based on other signals or values.
The callback **value** is evaluated lazily and cached. It is recomputed only when the dependent
signals inside the callback change, or if any of the hook **keys** change.

The host widget will rebuild whenever the derived value changes.

<Success>
Use computed signals to keep build methods clean and prevent unnecessary re-computations
of expensive operations (e.g., filtering, sorting, or formatting data).
</Success>

### Parameters
- **value**: The computation callback that derives the computed value.
- **keys**: A list of objects to watch for changes. If any key changes, the computed signal is re-created.
- **debugLabel**: An optional debug label to identify the computed signal in developer tools.

### Returns
A [FlutterComputed](/packages/signals/flutter/computed) signal containing the derived value.

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
