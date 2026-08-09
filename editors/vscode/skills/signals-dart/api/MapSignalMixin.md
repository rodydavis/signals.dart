# class `MapSignalMixin`

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

---

## Members of `MapSignalMixin`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **[]** | `method` | `V? [](Object? key)` |  |
| **[]=** | `method` | `void []=(K key, V value)` |  |
| **addAll** | `method` | `void addAll(Map<K, V> other)` |  |
| **addEntries** | `method` | `void addEntries(Iterable<MapEntry<K, V>> newEntries)` |  |
| **cast** | `method` | `Map<RK, RV> cast()` |  |
| **clear** | `method` | `void clear()` |  |
| **containsKey** | `method` | `bool containsKey(Object? key)` |  |
| **containsValue** | `method` | `bool containsValue(Object? value)` |  |
| **entries** | `method` | `Iterable<MapEntry<K, V>> entries` |  |
| **forEach** | `method` | `void forEach(void Function(K key, V value) action)` |  |
| **isEmpty** | `method` | `bool isEmpty` |  |
| **isNotEmpty** | `method` | `bool isNotEmpty` |  |
| **keys** | `method` | `Iterable<K> keys` |  |
| **length** | `method` | `int length` |  |
| **map** | `method` | `Map<K2, V2> map(MapEntry<K2, V2> Function(K key, V value) convert)` |  |
| **putIfAbsent** | `method` | `V putIfAbsent(K key, V Function() ifAbsent)` |  |
| **remove** | `method` | `V? remove(Object? key)` |  |
| **removeWhere** | `method` | `void removeWhere(bool Function(K key, V value) test)` |  |
| **update** | `method` | `V update(K key, V Function(V value) update, {V Function()? ifAbsent})` |  |
| **updateAll** | `method` | `void updateAll(V Function(K key, V value) update)` |  |
| **values** | `method` | `Iterable<V> values` |  |
| **toMap** | `method` | `Map<K, V> toMap()` | Snapshot of **MapEntries** |
