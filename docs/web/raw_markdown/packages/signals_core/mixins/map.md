---
title: MapSignalMixin
description: A mixin that adds reactive <code>Map</code> methods and operators directly to a Signal.
---

A mixin that adds reactive <code>Map</code> methods and operators directly to a [Signal](/packages/signals/core/signal).

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

##### <a name="[]"></a>`V? [](Object? key)`

##### <a name="[]="></a>`void []=(K key, V value)`

##### <a name="addall"></a>`void addAll(Map<K, V> other)`

##### <a name="addentries"></a>`void addEntries(Iterable<MapEntry<K, V>> newEntries)`

##### <a name="cast"></a>`Map<RK, RV> cast()`

##### <a name="clear"></a>`void clear()`

##### <a name="containskey"></a>`bool containsKey(Object? key)`

##### <a name="containsvalue"></a>`bool containsValue(Object? value)`

##### <a name="entries"></a>`Iterable<MapEntry<K, V>> entries`

##### <a name="foreach"></a>`void forEach(void Function(K key, V value) action)`

##### <a name="isempty"></a>`bool isEmpty`

##### <a name="isnotempty"></a>`bool isNotEmpty`

##### <a name="keys"></a>`Iterable<K> keys`

##### <a name="length"></a>`int length`

##### <a name="map"></a>`Map<K2, V2> map(MapEntry<K2, V2> Function(K key, V value) convert)`

##### <a name="putifabsent"></a>`V putIfAbsent(K key, V Function() ifAbsent)`

##### <a name="remove"></a>`V? remove(Object? key)`

##### <a name="removewhere"></a>`void removeWhere(bool Function(K key, V value) test)`

##### <a name="update"></a>`V update(K key, V Function(V value) update, {V Function()? ifAbsent})`

##### <a name="updateall"></a>`void updateAll(V Function(K key, V value) update)`

##### <a name="values"></a>`Iterable<V> values`

##### <a name="tomap"></a>`Map<K, V> toMap()`

Snapshot of **MapEntries**

</details>
