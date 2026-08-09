---
title: "Type: LoggingSignalsObserver"
description: "API reference and details for LoggingSignalsObserver from signals.dart."
---

# LoggingSignalsObserver

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: LoggingSignalsObserver

Logs all signals and computed changes to the console.

### Members of LoggingSignalsObserver

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **onComputedCreated** | <code>method</code> | <code>dart void onComputedCreated(Computed<T> instance)</code> |  |
| **onComputedUpdated** | <code>method</code> | <code>dart void onComputedUpdated(Computed<T> instance, T value)</code> |  |
| **onSignalCreated** | <code>method</code> | <code>dart void onSignalCreated(Signal<T> instance, T value)</code> |  |
| **onSignalUpdated** | <code>method</code> | <code>dart void onSignalUpdated(Signal<T> instance, T value)</code> |  |
| **onEffectCreated** | <code>method</code> | <code>dart void onEffectCreated(Effect instance)</code> |  |
| **onEffectCalled** | <code>method</code> | <code>dart void onEffectCalled(Effect instance)</code> |  |
| **onEffectRemoved** | <code>method</code> | <code>dart void onEffectRemoved(Effect instance)</code> |  |
| **log** | <code>method</code> | <code>dart void log(String message)</code> | Logs a message to the console. |

## References

The **LoggingSignalsObserver** type is referenced and used in the following pages:

* [SignalsObserver](/packages/signals_flutter/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [SignalsObserver](/packages/signals_core/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [SignalsObserver](/packages/signals/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

