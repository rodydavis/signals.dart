---
title: "Type: useTrackedSignal"
description: "API reference and details for useTrackedSignal from signals.dart."
---

# useTrackedSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useTrackedSignal

```dart
TrackedSignal<T> useTrackedSignal(T value, {List<Object?> keys = const <Object>[], TrackedSignalOptions<T>? options})
```

Creates a new [TrackedSignal](/types/trackedsignal) and subscribes to it.

A [TrackedSignal](/types/trackedsignal) extends standard signals by maintaining a record of its previous value alongside its
current value. This allows you to inspect history changes, calculate delta differences, or perform custom transition animations.

<Success>
You can access both the current value using <code>.value</code> and the previous value using <code>.previousValue</code>.
</Success>

### Parameters
- **value**: The initial value of the signal.
- **options**: The options for the signal.
- **keys**: A list of objects to watch. If any key changes, the signal is re-created.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class DeltaCounterWidget extends HookWidget {
  const DeltaCounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useTrackedSignal(0);

    return Column(
      children: [
        Text('Current: ${count.value}'),
        Text('Previous: ${count.previousValue ?? "N/A"}'),
        ElevatedButton(
          onPressed: () => count.value++,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
````

## References

The **useTrackedSignal** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useTrackedSignal](/packages/signals_hooks/hooks/use-tracked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

