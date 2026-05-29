---
title: "Type: DevToolsSignalsObserver"
description: "API reference and details for DevToolsSignalsObserver from signals.dart."
---

# DevToolsSignalsObserver <span class="deprecated-badge">deprecated</span>

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
  &nbsp;|&nbsp; <span class="deprecated-badge">deprecated</span>
</Info>

## Class: DevToolsSignalsObserver <span class="deprecated-badge">deprecated</span>

Signals DevTools observer

### Members of DevToolsSignalsObserver

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **DevToolsSignalsObserver** | <code>constructor</code> | <code>dart DevToolsSignalsObserver()</code> | Create a DevToolsSignalsObserver and register the VM service extensions. |
| **enabled** | <code>method</code> | <code>dart bool enabled</code> | Check if devTools is enabled |
| **enabled** | <code>method</code> | <code>dart enabled(bool value)</code> | Enable/Disable devTools |
| **reassemble** | <code>method</code> | <code>dart void reassemble()</code> | Reload the signals devTools |
| **onComputedCreated** | <code>method</code> | <code>dart void onComputedCreated(Computed<T> instance)</code> |  |
| **onComputedUpdated** | <code>method</code> | <code>dart void onComputedUpdated(Computed<T> instance, T value)</code> |  |
| **onSignalCreated** | <code>method</code> | <code>dart void onSignalCreated(Signal<T> instance, T value)</code> |  |
| **onSignalUpdated** | <code>method</code> | <code>dart void onSignalUpdated(Signal<T> instance, T value)</code> |  |
| **log** | <code>method</code> | <code>dart void log(String message)</code> | Logs a message to the console. |
| **onEffectCreated** | <code>method</code> | <code>dart void onEffectCreated(Effect instance)</code> |  |
| **onEffectCalled** | <code>method</code> | <code>dart void onEffectCalled(Effect instance)</code> |  |
| **onEffectRemoved** | <code>method</code> | <code>dart void onEffectRemoved(Effect instance)</code> |  |
| **getNodes** | <code>method</code> | <code>dart Map<String, dynamic> getNodes()</code> | Returns a map representation of all active signals, computeds, and effects |

## References

The **DevToolsSignalsObserver** type is referenced and used in the following pages:

* [SignalsObserver](/packages/signals_flutter/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [SignalsObserver](/packages/signals_core/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [SignalsObserver](/packages/signals/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

