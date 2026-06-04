---
title: MapSignalMixin
description: A mixin that adds reactive <code>Map</code> methods and operators directly to a Signal.
---

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


### Methods

<details>
<summary> View Methods </summary>

##### <a name="[]"></a><code>V? [](Object? key)</code>

##### <a name="[]="></a><code>void []=(K key, V value)</code>

##### <a name="addall"></a><code>void addAll(Map<K, V> other)</code>

##### <a name="addentries"></a><code>void addEntries(Iterable<MapEntry<K, V>> newEntries)</code>

##### <a name="cast"></a><code>Map<RK, RV> cast()</code>

##### <a name="clear"></a><code>void clear()</code>

##### <a name="containskey"></a><code>bool containsKey(Object? key)</code>

##### <a name="containsvalue"></a><code>bool containsValue(Object? value)</code>

##### <a name="entries"></a><code>Iterable<MapEntry<K, V>> entries</code>

##### <a name="foreach"></a><code>void forEach(void Function(K key, V value) action)</code>

##### <a name="isempty"></a><code>bool isEmpty</code>

##### <a name="isnotempty"></a><code>bool isNotEmpty</code>

##### <a name="keys"></a><code>Iterable<K> keys</code>

##### <a name="length"></a><code>int length</code>

##### <a name="map"></a><code>Map<K2, V2> map(MapEntry<K2, V2> Function(K key, V value) convert)</code>

##### <a name="putifabsent"></a><code>V putIfAbsent(K key, V Function() ifAbsent)</code>

##### <a name="remove"></a><code>V? remove(Object? key)</code>

##### <a name="removewhere"></a><code>void removeWhere(bool Function(K key, V value) test)</code>

##### <a name="update"></a><code>V update(K key, V Function(V value) update, {V Function()? ifAbsent})</code>

##### <a name="updateall"></a><code>void updateAll(V Function(K key, V value) update)</code>

##### <a name="values"></a><code>Iterable<V> values</code>

##### <a name="tomap"></a><code>Map<K, V> toMap()</code>

Snapshot of **MapEntries**

</details>
