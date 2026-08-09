# extension `ReadonlyIterableSignalExtension`

Helper extensions for [ReadonlySignal<Iterable>](/types/readonlysignal)

---

## Members of `ReadonlyIterableSignalExtension`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **any** | `method` | `bool any(bool Function(E element) test)` |  |
| **cast** | `method` | `Iterable<R> cast()` |  |
| **contains** | `method` | `bool contains(Object? value)` |  |
| **elementAt** | `method` | `E elementAt(int index)` |  |
| **every** | `method` | `bool every(bool Function(E element) test)` |  |
| **expand** | `method` | `Iterable<R> expand(Iterable<R> Function(E element) toElements)` |  |
| **first** | `method` | `E first` |  |
| **firstWhere** | `method` | `E firstWhere(bool Function(E element) test, {E Function()? orElse})` |  |
| **fold** | `method` | `R fold(R initialValue, R Function(R previousValue, E element) combine)` |  |
| **followedBy** | `method` | `Iterable<E> followedBy(Iterable<E> other)` |  |
| **isEmpty** | `method` | `bool isEmpty` |  |
| **isNotEmpty** | `method` | `bool isNotEmpty` |  |
| **iterator** | `method` | `Iterator<E> iterator` |  |
| **join** | `method` | `String join([String separator = ""])` |  |
| **last** | `method` | `E last` |  |
| **lastWhere** | `method` | `E lastWhere(bool Function(E element) test, {E Function()? orElse})` |  |
| **length** | `method` | `int length` |  |
| **map** | `method` | `Iterable<R> map(R Function(E e) toElement)` |  |
| **reduce** | `method` | `E reduce(E Function(E value, E element) combine)` |  |
| **single** | `method` | `E single` |  |
| **singleWhere** | `method` | `E singleWhere(bool Function(E element) test, {E Function()? orElse})` |  |
| **skip** | `method` | `Iterable<E> skip(int count)` |  |
| **skipWhile** | `method` | `Iterable<E> skipWhile(bool Function(E value) test)` |  |
| **take** | `method` | `Iterable<E> take(int count)` |  |
| **takeWhile** | `method` | `Iterable<E> takeWhile(bool Function(E value) test)` |  |
| **toList** | `method` | `List<E> toList({bool growable = true})` |  |
| **toSet** | `method` | `Set<E> toSet()` |  |
| **where** | `method` | `Iterable<E> where(bool Function(E element) test)` |  |
| **whereType** | `method` | `Iterable<R> whereType()` |  |
| **forEach** | `method` | `void forEach(void Function(E element) action)` |  |
