---
title: "Type: useQueueSignal"
description: "API reference and details for useQueueSignal from signals.dart."
---

# useQueueSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useQueueSignal

```dart
QueueSignal<T> useQueueSignal(Queue<T> value, {List<Object?> keys = const <Object>[], QueueSignalOptions<T>? options})
```

Creates a new [QueueSignal](/types/queuesignal) and subscribes to it.

A [QueueSignal](/types/queuesignal) wraps a Dart **Queue**, providing reactive tracking for queue operations like adding items to
the end or removing items from the front. Perfect for task pipelines, notification streams, or undo histories.

### Parameters
- **value**: The initial queue items.
- **options**: The options for the signal.
- **keys**: A list of objects to watch. If any key changes, the queue signal is re-created.

### Example

````dart
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class NotificationQueueWidget extends HookWidget {
  const NotificationQueueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = useQueueSignal<String>(Queue());

    return Column(
      children: [
        ElevatedButton(
          onPressed: () => notifications.addLast('Alert at ${DateTime.now()}'),
          child: const Text('Enqueue Alert'),
        ),
        if (notifications.isNotEmpty)
          ElevatedButton(
            onPressed: () => notifications.removeFirst(),
            child: const Text('Dismiss Oldest Alert'),
          ),
        Expanded(
          child: ListView(
            children: notifications.map((note) => ListTile(title: Text(note))).toList(),
          ),
        ),
      ],
    );
  }
}
````

## References

The **useQueueSignal** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useQueueSignal](/packages/signals_hooks/hooks/use-queue-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-hooks AI Skill](/skills/signals-hooks) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

