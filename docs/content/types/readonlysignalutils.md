---
title: "Type: ReadonlySignalUtils"
description: "API reference and details for ReadonlySignalUtils from signals.dart."
---

# ReadonlySignalUtils

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: ReadonlySignalUtils

```dart
extension ReadonlySignalUtils on ReadonlySignal<T>
```

Utility extensions on [ReadonlySignal](/types/readonlysignal) to bridge reactive programming with asynchronous streams and select sub-states.

### Members of ReadonlySignalUtils

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toStream** | <code>method</code> | <code>dart Stream<T> toStream()</code> | Convert a signal to a **Stream** to be consumed as |
| **select** | <code>method</code> | <code>dart Computed<R> select(R Function(ReadonlySignal<T>) selector, [ComputedOptions<R>? options])</code> | Select a sub-state value from this signal and return a computed signal that only notifies when that specific sub-state changes. |

## References

The **ReadonlySignalUtils** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>

