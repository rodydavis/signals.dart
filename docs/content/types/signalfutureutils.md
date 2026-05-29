---
title: "Type: SignalFutureUtils"
description: "API reference and details for SignalFutureUtils from signals.dart."
---

# SignalFutureUtils

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: SignalFutureUtils

```dart
extension SignalFutureUtils on Future<T>
```

Extension on future to provide helpful methods for signals

### Members of SignalFutureUtils

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toFutureSignal** | <code>method</code> | <code>dart FutureSignal<T> toFutureSignal({Duration? timeout, T? initialValue, bool lazy = true, List<ReadonlySignal<dynamic>> dependencies = const [], AsyncSignalOptions<T>? options})</code> | Convert an existing future to [FutureSignal](/types/futuresignal) |

## References

The **SignalFutureUtils** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

