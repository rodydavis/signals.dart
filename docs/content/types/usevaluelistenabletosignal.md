---
title: "Type: useValueListenableToSignal"
description: "API reference and details for useValueListenableToSignal from signals.dart."
---

# useValueListenableToSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useValueListenableToSignal

```dart
ReadonlySignal<T> useValueListenableToSignal(ValueListenable<T> value, {List<Object?> keys = const <Object>[], SignalOptions<T>? options})
```

Creates a new [ReadonlySignal](/types/readonlysignal) from a **ValueListenable** and subscribes to it.

This provides read-only interoperability with standard Flutter classes, allowing you to bridge any
**ValueListenable** (like **ScrollController**, **TextEditingController**, or other custom listenables) into a
reactive [ReadonlySignal](/types/readonlysignal).

<Success>
Perfect for listening to UI framework states such as scroll offsets, keyboard visibility, or text inputs in a
clean, functional reactive style.
</Success>

### Parameters
- **value**: The **ValueListenable** to bridge.
- **keys**: A list of objects to watch. If any key changes, the signal is re-created.
- **debugLabel**: An optional debug label.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class ScrollTrackerWidget extends HookWidget {
  const ScrollTrackerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    // Bridge the listenable offset to a reactive ReadonlySignal
    final scrollSignal = useValueListenableToSignal(scrollController);

    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll Position: ${scrollSignal.value.toStringAsFixed(1)}'),
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: 100,
        itemBuilder: (context, idx) => ListTile(title: Text('Row $idx')),
      ),
    );
  }
}
````

## References

The **useValueListenableToSignal** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useValueListenableToSignal](/packages/signals_hooks/hooks/use-value-listenable-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-hooks AI Skill](/skills/signals-hooks) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

