---
title: "Type: useValueNotifierToSignal"
description: "API reference and details for useValueNotifierToSignal from signals.dart."
---

# useValueNotifierToSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useValueNotifierToSignal

```dart
Signal<T> useValueNotifierToSignal(ValueNotifier<T> value, {List<Object?> keys = const <Object>[], SignalOptions<T>? options})
```

Creates a new mutable [Signal](/types/signal) from a **ValueNotifier** and subscribes to it.

This provides interoperability with standard Flutter classes, allowing you to bridge a **ValueNotifier**
into a fully reactive [Signal](/types/signal) container. Changes made to the **ValueNotifier** automatically update the signal,
and changes made to the [signal](/types/signal) automatically write back to the **ValueNotifier**.

<Success>
This enables seamless bi-directional integration when working with external packages or existing widgets
that rely heavily on <strong>ValueNotifier</strong>.
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

## References

The **useValueNotifierToSignal** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useValueNotifierToSignal](/packages/signals_hooks/hooks/use-value-notifier-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-hooks AI Skill](/skills/signals-hooks) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

