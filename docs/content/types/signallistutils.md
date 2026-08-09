---
title: "Type: SignalListUtils"
description: "API reference and details for SignalListUtils from signals.dart."
---

# SignalListUtils

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: SignalListUtils

```dart
extension SignalListUtils on List<T>
```

Utility extension methods on **List** to convert them to [ListSignal](/types/listsignal)s.

### Members of SignalListUtils

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | <code>method</code> | <code>dart ListSignal<T> toSignal({ListSignalOptions<T>? options, @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ListSignalOptions(name: ...) instead') String? debugLabel})</code> | Convert this existing **List** to a reactive [ListSignal](/types/listsignal). |

## References

The **SignalListUtils** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

