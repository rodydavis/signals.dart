---
title: useLinkedSignal
description: Creates a new LinkedSignal that resets its value whenever its source computation changes.
---

Creates a new [LinkedSignal](/packages/signals/core/linked-signal) that resets its value whenever its source computation changes.

A [LinkedSignal](/packages/signals/core/linked-signal) is a specialized signal that "links" to another reactive source or computed value,
automatically updating or resetting itself based on a custom computation function when the source changes.

<Success>
This is perfect for situations like editing a form field where the default value is derived from a
dynamic source (e.g. an item index, a fetched database record) but the user can also edit the value locally.
</Success>

### Parameters
- **source**: A computation function that yields the source value of type **S**.
- **options**: Configuration options for the linked signal, detailing how the source value **S** maps to
  the signal's inner value **T**.
- **keys**: A list of objects to watch. If any key changes, the signal is re-created.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class ProfileEditor extends HookWidget {
  final String initialUsername;
  const ProfileEditor({required this.initialUsername, super.key});

  @override
  Widget build(BuildContext context) {
    // LinkedSignal resets to initialUsername if the prop initialUsername changes,
    // but allows local modifications in the meantime.
    final usernameSignal = useLinkedSignal(
      () => initialUsername,
      keys: [initialUsername],
      options: LinkedSignalOptions(
        computation: (source, previous) => source,
      ),
    );

    return Column(
      children: [
        TextField(
          controller: useTextEditingController(text: usernameSignal.value)
            ..addListener(() {
              // Local modifications allowed
              usernameSignal.value = usernameSignal.value;
            }),
        ),
        Text('Live Username Signal: ${usernameSignal.value}'),
      ],
    );
  }
}
````
