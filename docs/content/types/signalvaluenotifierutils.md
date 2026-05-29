---
title: "Type: SignalValueNotifierUtils"
description: "API reference and details for SignalValueNotifierUtils from signals.dart."
---

# SignalValueNotifierUtils

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_flutter</code>
</Info>

## Extension: SignalValueNotifierUtils

```dart
extension SignalValueNotifierUtils on ValueNotifier<T>
```

Extension on **ValueNotifier** to seamlessly bridge standard Flutter mutable values to reactive signals.

### Members of SignalValueNotifierUtils

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | <code>method</code> | <code>dart Signal<T> toSignal({String? debugLabel, bool autoDispose = false})</code> | Converted **ValueNotifier** objects become mutable [Signal](/types/signal) instances. Setting the value |

## References

The **SignalValueNotifierUtils** type is referenced and used in the following pages:

* [Signal Value Notifier Utils](/packages/signals_flutter/extensions/signal-value-notifier-utils) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [Signal Value Notifier Utils](/packages/signals/extensions/signal-value-notifier-utils) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>

