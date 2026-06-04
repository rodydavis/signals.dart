---
title: "Type: useConnect"
description: "API reference and details for useConnect from signals.dart."
---

# useConnect

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useConnect

```dart
Connect<T, S> useConnect(Signal<T> signal, {Stream<S>? stream})
```

Creates a new [Connect](/types/connect) instance and automatically disposes of it when the widget unmounts.

[Connect](/types/connect) connects one or more streams to feed a target signal.

<Success>
Clean up is fully automated: when the <strong>HookWidget</strong> is disposed, all connected streams are unsubscribed,
and the connected signal is disposed.
</Success>

### Parameters
- [signal](/types/signal): The target [Signal](/types/signal) to feed.
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

## References

The **useConnect** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useConnect](/packages/signals_hooks/hooks/use-connect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

