---
title: "Type: SignalsInMemoryKeyValueStore"
description: "API reference and details for SignalsInMemoryKeyValueStore from signals.dart."
---

# SignalsInMemoryKeyValueStore

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: SignalsInMemoryKeyValueStore

An in-memory, volatile implementation of [SignalsKeyValueStore](/types/signalskeyvaluestore).

This serves as a fallback engine and does not persist across restarts/reload.

### Members of SignalsInMemoryKeyValueStore

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **store** | <code>field</code> | <code>dart store</code> | The in-memory store. |
| **getItem** | <code>method</code> | <code>dart Future<String?> getItem(String key)</code> |  |
| **removeItem** | <code>method</code> | <code>dart Future<void> removeItem(String key)</code> |  |
| **setItem** | <code>method</code> | <code>dart Future<void> setItem(String key, String value)</code> |  |

## References

The **SignalsInMemoryKeyValueStore** type is referenced and used in the following pages:

* [PersistedSignal](/packages/signals_flutter/utilities/persisted) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [PersistedSignal](/packages/signals_core/utilities/persisted) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [PersistedSignal](/packages/signals/utilities/persisted) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

