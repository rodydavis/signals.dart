---
title: "Type: TimerSignal"
description: "API reference and details for TimerSignal from signals.dart."
---

# TimerSignal

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: TimerSignal

Emit recurring **TimerSignalEvent** aka [AsyncSignal](/types/asyncsignal)

### Members of TimerSignal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **every** | <code>field</code> | <code>dart Duration every</code> | Trigger an **TimerSignalEvent** every duration |
| **TimerSignal** | <code>constructor</code> | <code>dart TimerSignal({required this.every, super.cancelOnError, AsyncSignalOptions<TimerSignalEvent>? options, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})</code> | Emit recurring **TimerSignalEvent** aka [AsyncSignal](/types/asyncsignal) |

## Function: timerSignal

```dart
TimerSignal timerSignal(Duration every, {bool? cancelOnError, AsyncSignalOptions<TimerSignalEvent>? options, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})
```

Create a [TimerSignal](/types/timersignal)

## References

The **TimerSignal** type is referenced and used in the following pages:

* [AsyncSignal](/packages/signals_flutter/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [AsyncSignal](/packages/signals_core/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [AsyncSignal](/packages/signals/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>

