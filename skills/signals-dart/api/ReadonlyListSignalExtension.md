# extension `ReadonlyListSignalExtension`

Helper extensions for [ReadonlySignal<List>](/types/readonlysignal)

---

## Members of `ReadonlyListSignalExtension`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **cast** | `method` | `List<R> cast()` |  |
| **last** | `method` | `E last` |  |
| **+** | `method` | `List<E> +(List<E> other)` |  |
| **[]** | `method` | `E [](int index)` |  |
| **asMap** | `method` | `Map<int, E> asMap()` |  |
| **expand** | `method` | `Iterable<R> expand(Iterable<R> Function(E element) toElements)` |  |
| **firstWhere** | `method` | `E firstWhere(bool Function(E element) test, {E Function()? orElse})` |  |
| **fold** | `method` | `R fold(R initialValue, R Function(R previousValue, E element) combine)` |  |
| **followedBy** | `method` | `Iterable<E> followedBy(Iterable<E> other)` |  |
| **getRange** | `method` | `Iterable<E> getRange(int start, int end)` |  |
| **indexOf** | `method` | `int indexOf(E element, [int start = 0])` |  |
| **indexWhere** | `method` | `int indexWhere(bool Function(E element) test, [int start = 0])` |  |
| **lastIndexOf** | `method` | `int lastIndexOf(E element, [int? start])` |  |
| **lastIndexWhere** | `method` | `int lastIndexWhere(bool Function(E element) test, [int? start])` |  |
| **reversed** | `method` | `Iterable<E> reversed` |  |
| **sorted** | `method` | `List<E> sorted([int Function(E a, E b)? compare])` | Return a new array that is sorted by the **compare** function |
| **sublist** | `method` | `List<E> sublist(int start, [int? end])` |  |
