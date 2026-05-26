---
title: useTrackedSignal
description: Creates a new **TrackedSignal** and subscribes to it.
---

Creates a new **TrackedSignal** and subscribes to it.

A **TrackedSignal** extends standard signals by maintaining a record of its previous value alongside its
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
