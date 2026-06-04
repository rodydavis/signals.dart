---
title: "Type: useStreamSignal"
description: "API reference and details for useStreamSignal from signals.dart."
---

# useStreamSignal

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_hooks</code>
</Info>

## Function: useStreamSignal

```dart
StreamSignal<T> useStreamSignal(Stream<T> Function() value, {List<Object?> keys = const <Object>[], AsyncSignalOptions<T>? options})
```

Creates a new [StreamSignal](/types/streamsignal) and subscribes to it.

A [StreamSignal](/types/streamsignal) wraps a standard Dart **Stream**, capturing emitted events, errors,
and done notifications as reactive states (<code>loading</code>, <code>data</code>, <code>error</code>). The host widget
is automatically rebuilt on every stream emission.

<Success>
Clean up is fully automated: when the <strong>HookWidget</strong> is disposed, the underlying stream subscription
is cancelled to prevent memory leaks.
</Success>

### Parameters
- **value**: A callback returning the **Stream** to subscribe to.
- **options**: An optional **StreamSignalOptions** to configure the stream signal.
- **keys**: A list of objects to watch. If any key changes, the hook unsubscribes from the old stream and
  subscribes to the new one.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class ChatMessagesWidget extends HookWidget {
  final String channelId;
  const ChatMessagesWidget({required this.channelId, super.key});

  @override
  Widget build(BuildContext context) {
    // Subscribes to chat stream, automatically switching streams if channelId changes
    final streamSignal = useStreamSignal(
      () => listenToChannel(channelId),
      keys: [channelId],
    );

    return streamSignal.value.map(
      data: (message) => Text('New message: ${message.text}'),
      error: (err, stack) => Text('Stream error: $err'),
      loading: () => const Text('Connecting to channel...'),
    );
  }
}
````

## References

The **useStreamSignal** type is referenced and used in the following pages:

* [signals_hooks](/packages/signals_hooks)
* [useStreamSignal](/packages/signals_hooks/hooks/use-stream-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useAsyncSignal](/packages/signals_hooks/hooks/use-async-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

