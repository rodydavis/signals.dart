---
title: "Type: futureSignalContainer"
description: "API reference and details for futureSignalContainer from signals.dart."
---

# futureSignalContainer

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Function: futureSignalContainer

```dart
SignalContainer<AsyncState<T>, Arg, FutureSignal<T>> futureSignalContainer(FutureSignal<T> Function(Arg) create, {bool cache = false, void Function(Arg key, FutureSignal<T> signal)? onEvict})
```

Create a signal container for FutureSignals based on args.

```dart
final container = futureSignalContainer<Post, int>((id) {
  return futureSignal(() => fetchPost(id));
});
```

## References

The **futureSignalContainer** type is referenced and used in the following pages:

* [SignalContainer](/packages/signals_flutter/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [SignalContainer](/packages/signals_core/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [SignalContainer](/packages/signals/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>

