---
title: useValueNotifierToSignal
description: Creates a new mutable Signal from a **ValueNotifier** and subscribes to it.
---

Creates a new mutable [Signal](/packages/signals/core/signal) from a **ValueNotifier** and subscribes to it.

This provides interoperability with standard Flutter classes, allowing you to bridge a **ValueNotifier**
into a fully reactive [Signal](/packages/signals/core/signal) container. Changes made to the **ValueNotifier** automatically update the signal,
and changes made to the [signal](/packages/signals/flutter/signal) automatically write back to the **ValueNotifier**.

<Success>
This enables seamless bi-directional integration when working with external packages or existing widgets
that rely heavily on **ValueNotifier**.
</Success>

### Parameters
- **value**: The **ValueNotifier** to bridge.
- **keys**: A list of objects to watch. If any key changes, the signal is re-created.
- **debugLabel**: An optional debug label.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class LegacyBridgeWidget extends HookWidget {
  const LegacyBridgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = useValueNotifier(0);
    // Bridge the standard ValueNotifier to a fully reactive Signal
    final countSignal = useValueNotifierToSignal(notifier);

    return Column(
      children: [
        Text('ValueNotifier value: ${notifier.value}'),
        Text('Signal value: ${countSignal.value}'),
        ElevatedButton(
          onPressed: () => countSignal.value++, // Updates notifier automatically
          child: const Text('Increment Signal'),
        ),
      ],
    );
  }
}
````
