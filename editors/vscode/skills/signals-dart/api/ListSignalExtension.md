# extension `ListSignalExtension`

Helper extensions for [Signal<List>](/types/signal)

---

## Members of `ListSignalExtension`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **first** | `method` | `first(E val)` |  |
| **last** | `method` | `last(E val)` |  |
| **length** | `method` | `length(int value)` |  |
| **[]=** | `method` | `void []=(int index, E value)` |  |
| **add** | `method` | `void add(E value)` |  |
| **addAll** | `method` | `void addAll(Iterable<E> iterable)` |  |
| **clear** | `method` | `void clear()` |  |
| **fillRange** | `method` | `void fillRange(int start, int end, [E? fillValue])` |  |
| **insert** | `method` | `void insert(int index, E element)` |  |
| **insertAll** | `method` | `void insertAll(int index, Iterable<E> iterable)` |  |
| **remove** | `method` | `bool remove(Object? value)` |  |
| **removeAt** | `method` | `E removeAt(int index)` |  |
| **removeLast** | `method` | `E removeLast()` |  |
| **removeRange** | `method` | `void removeRange(int start, int end)` |  |
| **removeWhere** | `method` | `void removeWhere(bool Function(E element) test)` |  |
| **replaceRange** | `method` | `void replaceRange(int start, int end, Iterable<E> replacements)` |  |
| **retainWhere** | `method` | `void retainWhere(bool Function(E element) test)` |  |
| **setAll** | `method` | `void setAll(int index, Iterable<E> iterable)` |  |
| **setRange** | `method` | `void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0])` |  |
| **shuffle** | `method` | `void shuffle([Random? random])` |  |
| **sort** | `method` | `void sort([int Function(E a, E b)? compare])` |  |
