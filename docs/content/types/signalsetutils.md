---
title: "Type: SignalSetUtils"
description: "API reference and details for SignalSetUtils from signals.dart."
---

# SignalSetUtils

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: SignalSetUtils

```dart
extension SignalSetUtils on Set<T>
```

Utility extension methods on **Set** to convert them to [SetSignal](/types/setsignal)s.

### Members of SignalSetUtils

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | <code>method</code> | <code>dart SetSignal<T> toSignal({SetSignalOptions<T>? options, @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SetSignalOptions(name: ...) instead') String? debugLabel})</code> | Convert this existing **Set** to a reactive [SetSignal](/types/setsignal). |

## References

The **SignalSetUtils** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>

