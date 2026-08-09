---
title: "Type: useLinkedSignal"
description: "API reference and details for useLinkedSignal from signals.dart."
---

# useLinkedSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useLinkedSignal

```dart
LinkedSignal<T, S> useLinkedSignal(S Function() source, {List<Object?> keys = const <Object>[], LinkedSignalOptions<T, S>? options})
```

Creates a new [LinkedSignal](/types/linkedsignal) that resets its value whenever its source computation changes.

A [LinkedSignal](/types/linkedsignal) is a specialized signal that "links" to another reactive source or computed value,
automatically updating or resetting itself based on a custom computation function when the source changes.

<Info>
  This is perfect for situations like editing a form field where the default value is derived from a
  dynamic source (e.g. an item index, a fetched database record) but the user can also edit the value locally.
</Info>

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

## References

The **useLinkedSignal** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useLinkedSignal](/packages/signals_hooks/hooks/use-linked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-hooks AI Skill](/skills/signals-hooks) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

