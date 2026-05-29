---
title: "Type: SignalIterableUtils"
description: "API reference and details for SignalIterableUtils from signals.dart."
---

# SignalIterableUtils

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: SignalIterableUtils

```dart
extension SignalIterableUtils on Iterable<T>
```

Utility extension methods on **Iterable** to convert them to [IterableSignal](/types/iterablesignal)s.

### Members of SignalIterableUtils

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | <code>method</code> | <code>dart IterableSignal<T> toSignal({IterableSignalOptions<T>? options, @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: IterableSignalOptions(name: ...) instead') String? debugLabel})</code> | Convert an existing **Iterable** to an [IterableSignal](/types/iterablesignal). |

## References

The **SignalIterableUtils** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>

