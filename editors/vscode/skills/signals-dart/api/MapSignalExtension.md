# extension `MapSignalExtension`

Helper extensions for [Signal<Map>](/types/signal)

---

## Members of `MapSignalExtension`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **[]=** | `method` | `void []=(K key, V value)` |  |
| **addAll** | `method` | `void addAll(Map<K, V> other)` |  |
| **addEntries** | `method` | `void addEntries(Iterable<MapEntry<K, V>> newEntries)` |  |
| **clear** | `method` | `void clear()` |  |
| **forEach** | `method` | `void forEach(void Function(K key, V value) action)` |  |
| **putIfAbsent** | `method` | `V putIfAbsent(K key, V Function() ifAbsent)` |  |
| **remove** | `method` | `V? remove(Object? key)` |  |
| **removeWhere** | `method` | `void removeWhere(bool Function(K key, V value) test)` |  |
| **update** | `method` | `V update(K key, V Function(V value) update, {V Function()? ifAbsent})` |  |
| **updateAll** | `method` | `void updateAll(V Function(K key, V value) update)` |  |
