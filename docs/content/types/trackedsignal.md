---
title: "Type: TrackedSignal"
description: "API reference and details for TrackedSignal from signals.dart."
---

# TrackedSignal

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: TrackedSignal

A signal that stores the initial and previous value

### Members of TrackedSignal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **TrackedSignal** | <code>constructor</code> | <code>dart TrackedSignal(super.value, {TrackedSignalOptions<T>? options, @Deprecated('Use options: TrackedSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: TrackedSignalOptions(name: ...) instead') String? debugLabel})</code> | A signal that stores the initial and previous value |

## Function: trackedSignal

```dart
TrackedSignal<T> trackedSignal(T value, {TrackedSignalOptions<T>? options, @Deprecated('Use options: TrackedSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: TrackedSignalOptions(name: ...) instead') String? debugLabel})
```

Create a signal that stores the initial and previous value

## References

The **TrackedSignal** type is referenced and used in the following pages:

* [TrackedSignalMixin](/packages/signals_flutter/mixins/tracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [TrackedSignalMixin](/packages/signals_core/mixins/tracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [TrackedSignalMixin](/packages/signals/mixins/tracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [useTrackedSignal](/packages/signals_hooks/hooks/use-tracked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

