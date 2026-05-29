---
title: "Type: streamSignalContainer"
description: "API reference and details for streamSignalContainer from signals.dart."
---

# streamSignalContainer

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Function: streamSignalContainer

```dart
SignalContainer<Arg, StreamSignal<T>> streamSignalContainer(StreamSignal<T> Function(Arg) create, {bool cache = false, void Function(Arg key, StreamSignal<T> signal)? onEvict})
```

Create a signal container for StreamSignals based on args.

```dart
final container = streamSignalContainer<Message, int>((roomId) {
  return streamSignal(() => listenToRoom(roomId));
});
```

## References

The **streamSignalContainer** type is referenced and used in the following pages:

* [SignalContainer](/packages/signals_flutter/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [SignalContainer](/packages/signals_core/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [SignalContainer](/packages/signals/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>

