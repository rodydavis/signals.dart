---
title: "Type: PersistedSignalMixin"
description: "API reference and details for PersistedSignalMixin from signals.dart."
---

# PersistedSignalMixin

<Info>
  <strong>Kind:</strong> <code>mixin</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Mixin: PersistedSignalMixin

A mixin that adds local persistence capabilities to a standard [Signal](/types/signal).

By mixing in <code>PersistedSignalMixin<T></code> on a <code>Signal<T></code> subclass, the signal
will automatically retrieve its stored state on boot and save its state whenever
<code>.value</code> is mutated.

Classes mixing in <code>PersistedSignalMixin<T></code> must implement:
- **key**: A unique identifier string for the key-value database.
- **store**: An implementation of [SignalsKeyValueStore](/types/signalskeyvaluestore).

### Serialization Customization
By default, the mixin uses standard JSON parsing (<code>jsonDecode</code> / <code>jsonEncode</code>).
If your data type <code>T</code> is not natively supported by JSON, override:
- **decode** to convert the raw string value back into type <code>T</code>.
- **encode** to serialize type <code>T</code> into a string.

### Members of PersistedSignalMixin

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **key** | <code>method</code> | <code>dart String key</code> | The key to use for storing the value. |
| **store** | <code>method</code> | <code>dart SignalsKeyValueStore store</code> | The store to use for storing the value. |
| **loaded** | <code>field</code> | <code>dart bool loaded</code> | Whether the signal has been loaded from the store. |
| **init** | <code>method</code> | <code>dart Future<void> init()</code> | Initializes the signal by loading the value from the store. |
| **value** | <code>method</code> | <code>dart T value</code> |  |
| **value** | <code>method</code> | <code>dart value(T value)</code> |  |
| **load** | <code>method</code> | <code>dart Future<T> load()</code> | Loads the value from the store. |
| **save** | <code>method</code> | <code>dart Future<void> save(T value)</code> | Saves the value to the store. |
| **decode** | <code>method</code> | <code>dart T decode(String value)</code> | Decodes the value from a string. |
| **encode** | <code>method</code> | <code>dart String encode(T value)</code> | Encodes the value to a string. |

## References

The **PersistedSignalMixin** type is referenced and used in the following pages:

* [Persisted Signals](/guides/persisted-signals) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [PersistedSignal](/packages/signals_flutter/utilities/persisted) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [PersistedSignal](/packages/signals_core/utilities/persisted) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [PersistedSignal](/packages/signals/utilities/persisted) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

