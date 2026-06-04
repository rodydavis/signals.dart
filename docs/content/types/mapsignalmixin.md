---
title: "Type: MapSignalMixin"
description: "API reference and details for MapSignalMixin from signals.dart."
---

# MapSignalMixin

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: MapSignalMixin

A mixin that adds reactive <code>Map</code> methods and operators directly to a [Signal](/types/signal).

This mixin delegates all standard **Map** operations (such as mutations like <code>[]=</code>, <code>clear</code>,
<code>remove</code>, and lookups like <code>containsKey</code>, <code>isEmpty</code>, <code>keys</code>, <code>values</code>) to the underlying
map value.

Every mutating operation automatically updates the signal and notifies its observers
(by forcing a change notification using <code>force: true</code>).

### Simple Example
```dart
class MyMapSignal<K, V> extends Signal<Map<K, V>>
    with MapSignalMixin<K, V, Map<K, V>> {
  MyMapSignal(super.value);
}

final cart = MyMapSignal<String, int>({'apple': 1});

// Register an effect reacting to cart changes
effect(() {
  print('Cart length: ${cart.length}');
});

// Treating it as a standard Map triggers updates automatically!
cart['banana'] = 3;  // Prints: Cart length: 2
cart.remove('apple'); // Prints: Cart length: 1
```

### Members of MapSignalMixin

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **[]** | <code>method</code> | <code>dart V? [](Object? key)</code> |  |
| **[]=** | <code>method</code> | <code>dart void []=(K key, V value)</code> |  |
| **addAll** | <code>method</code> | <code>dart void addAll(Map<K, V> other)</code> |  |
| **addEntries** | <code>method</code> | <code>dart void addEntries(Iterable<MapEntry<K, V>> newEntries)</code> |  |
| **cast** | <code>method</code> | <code>dart Map<RK, RV> cast()</code> |  |
| **clear** | <code>method</code> | <code>dart void clear()</code> |  |
| **containsKey** | <code>method</code> | <code>dart bool containsKey(Object? key)</code> |  |
| **containsValue** | <code>method</code> | <code>dart bool containsValue(Object? value)</code> |  |
| **entries** | <code>method</code> | <code>dart Iterable<MapEntry<K, V>> entries</code> |  |
| **forEach** | <code>method</code> | <code>dart void forEach(void Function(K key, V value) action)</code> |  |
| **isEmpty** | <code>method</code> | <code>dart bool isEmpty</code> |  |
| **isNotEmpty** | <code>method</code> | <code>dart bool isNotEmpty</code> |  |
| **keys** | <code>method</code> | <code>dart Iterable<K> keys</code> |  |
| **length** | <code>method</code> | <code>dart int length</code> |  |
| **map** | <code>method</code> | <code>dart Map<K2, V2> map(MapEntry<K2, V2> Function(K key, V value) convert)</code> |  |
| **putIfAbsent** | <code>method</code> | <code>dart V putIfAbsent(K key, V Function() ifAbsent)</code> |  |
| **remove** | <code>method</code> | <code>dart V? remove(Object? key)</code> |  |
| **removeWhere** | <code>method</code> | <code>dart void removeWhere(bool Function(K key, V value) test)</code> |  |
| **update** | <code>method</code> | <code>dart V update(K key, V Function(V value) update, {V Function()? ifAbsent})</code> |  |
| **updateAll** | <code>method</code> | <code>dart void updateAll(V Function(K key, V value) update)</code> |  |
| **values** | <code>method</code> | <code>dart Iterable<V> values</code> |  |
| **toMap** | <code>method</code> | <code>dart Map<K, V> toMap()</code> | Snapshot of **MapEntries** |

## References

The **MapSignalMixin** type is referenced and used in the following pages:

* [MapSignalMixin](/packages/signals_flutter/mixins/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [signals_flutter](/packages/signals_flutter)
* [MapSignalMixin](/packages/signals_core/mixins/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [signals_core](/packages/signals_core)
* [MapSignalMixin](/packages/signals/mixins/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [signals](/packages/signals)

