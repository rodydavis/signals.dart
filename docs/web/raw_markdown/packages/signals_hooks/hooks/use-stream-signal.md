---
title: useStreamSignal
description: Creates a new StreamSignal and subscribes to it.
---

Creates a new [StreamSignal](/packages/signals/async/stream) and subscribes to it.

A [StreamSignal](/packages/signals/async/stream) wraps a standard Dart **Stream**, capturing emitted events, errors,
and done notifications as reactive states (`loading`, `data`, `error`). The host widget
is automatically rebuilt on every stream emission.

<Success>
Clean up is fully automated: when the **HookWidget** is disposed, the underlying stream subscription
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
      AsyncSignalOptions(keys: [channelId]),
    );

    return streamSignal.value.map(
      data: (message) => Text('New message: ${message.text}'),
      error: (err, stack) => Text('Stream error: $err'),
      loading: () => const Text('Connecting to channel...'),
    );
  }
}
````
