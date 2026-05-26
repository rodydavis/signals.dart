---
title: useConnect
description: Creates a new Connect instance and automatically disposes of it when the widget unmounts.
---

Creates a new [Connect](/packages/signals/async/connect) instance and automatically disposes of it when the widget unmounts.

[Connect](/packages/signals/async/connect) connects one or more streams to feed a target signal.

<Success>
Clean up is fully automated: when the **HookWidget** is disposed, all connected streams are unsubscribed,
and the connected signal is disposed.
</Success>

### Parameters
- [signal](/packages/signals/flutter/signal): The target [Signal](/packages/signals/core/signal) to feed.
- **stream**: An optional initial stream to connect immediately.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class StreamingCounterWidget extends HookWidget {
  const StreamingCounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useSignal(0);

    // Automatically connects the periodic stream to the counter signal
    final periodicStream = useMemoized(
      () => Stream.periodic(const Duration(seconds: 1), (i) => i),
    );
    useConnect(counter, periodicStream);

    return Text('Tick count: ${counter.value}');
  }
}
````
