---
title: "Type: computedContainer"
description: "API reference and details for computedContainer from signals.dart."
---

# computedContainer

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Function: computedContainer

```dart
SignalContainer<T, Arg, Computed<T>> computedContainer(Computed<T> Function(Arg) create, {bool cache = false, void Function(Arg key, Computed<T> signal)? onEvict})
```

Create a signal container for computed signals based on args.

```dart
final container = computedContainer<int, int>((arg) {
  return computed(() => sourceSignal.value * arg);
});
```

## References

The **computedContainer** type is referenced and used in the following pages:

* [SignalContainer](/packages/signals_flutter/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [SignalContainer](/packages/signals_core/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [SignalContainer](/packages/signals/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

