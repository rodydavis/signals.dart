---
title: "Type: SignalMapUtils"
description: "API reference and details for SignalMapUtils from signals.dart."
---

# SignalMapUtils

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: SignalMapUtils

```dart
extension SignalMapUtils on Map<K, V>
```

Utility extension methods on **Map** to convert them to [MapSignal](/types/mapsignal)s.

### Members of SignalMapUtils

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **toSignal** | <code>method</code> | <code>dart MapSignal<K, V> toSignal({MapSignalOptions<K, V>? options, @Deprecated('Use options: MapSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: MapSignalOptions(name: ...) instead') String? debugLabel})</code> | Convert this existing **Map** to a reactive [MapSignal](/types/mapsignal). |

## References

The **SignalMapUtils** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

