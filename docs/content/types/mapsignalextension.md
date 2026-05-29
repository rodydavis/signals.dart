---
title: "Type: MapSignalExtension"
description: "API reference and details for MapSignalExtension from signals.dart."
---

# MapSignalExtension

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: MapSignalExtension

```dart
extension MapSignalExtension on Signal<Map<K, V>>
```

Helper extensions for [Signal<Map>](/types/signal)

### Members of MapSignalExtension

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **[]=** | <code>method</code> | <code>dart void []=(K key, V value)</code> |  |
| **addAll** | <code>method</code> | <code>dart void addAll(Map<K, V> other)</code> |  |
| **addEntries** | <code>method</code> | <code>dart void addEntries(Iterable<MapEntry<K, V>> newEntries)</code> |  |
| **clear** | <code>method</code> | <code>dart void clear()</code> |  |
| **forEach** | <code>method</code> | <code>dart void forEach(void Function(K key, V value) action)</code> |  |
| **putIfAbsent** | <code>method</code> | <code>dart V putIfAbsent(K key, V Function() ifAbsent)</code> |  |
| **remove** | <code>method</code> | <code>dart V? remove(Object? key)</code> |  |
| **removeWhere** | <code>method</code> | <code>dart void removeWhere(bool Function(K key, V value) test)</code> |  |
| **update** | <code>method</code> | <code>dart V update(K key, V Function(V value) update, {V Function()? ifAbsent})</code> |  |
| **updateAll** | <code>method</code> | <code>dart void updateAll(V Function(K key, V value) update)</code> |  |

## References

The **MapSignalExtension** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>

