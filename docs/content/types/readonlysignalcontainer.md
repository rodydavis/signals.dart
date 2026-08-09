---
title: "Type: readonlySignalContainer"
description: "API reference and details for readonlySignalContainer from signals.dart."
---

# readonlySignalContainer

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Function: readonlySignalContainer

```dart
SignalContainer<T, Arg, ReadonlySignal<T>> readonlySignalContainer(ReadonlySignal<T> Function(Arg) create, {bool cache = false, void Function(Arg key, ReadonlySignal<T> signal)? onEvict})
```

Create a signal container used to instance signals based on args

```dart
final container = readonlySignalContainer<Cache, String>((e) {
  return signal(Cache(e));
});

final cacheA = container('cache-a');
final cacheB = container('cache-b');
final cacheC = container('cache-c');
```

The signals cannot be updated but allows for
using computed where the value is only derived from other signals.

## References

The **readonlySignalContainer** type is referenced and used in the following pages:

* [SignalContainer](/packages/signals_flutter/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [SignalContainer](/packages/signals_core/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [SignalContainer](/packages/signals/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

