# class `ListSignalMixin`

A mixin that adds reactive <code>List</code> methods and operators to a [Signal](/types/signal)
holding a **List** value.

This mixin delegates all standard **List** operations (such as mutations like <code>add</code>,
<code>remove</code>, <code>insert</code>, <code>sort</code>, and <code>clear</code>, and accessor operators like <code>[]</code> and <code>[]=</code>)
to the underlying list, while ensuring that any reads register a dependency
and any mutations automatically trigger reactive updates.

<Info>
This mixin only works with signals that have a value type extending <strong>List<E></strong>.
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

class MyListSignal extends Signal<List<int>>
    with IterableSignalMixin<int, List<int>>, ListSignalMixin<int, List<int>> {
  MyListSignal(super.internalValue);
}

void main() {
  final numbers = MyListSignal([1, 2, 3]);

  effect(() {
    print('Elements: $numbers, Length: ${numbers.length}');
  }); // Prints: "Elements: [1, 2, 3], Length: 3"

  // Adding an element (automatically calls set() and triggers updates)
  numbers.add(4); // Prints: "Elements: [1, 2, 3, 4], Length: 4"

  // Modifying an element by index (triggers updates)
  numbers[0] = 10; // Prints: "Elements: [10, 2, 3, 4], Length: 4"
}
```

<Success>
Since mutations on <code>ListSignalMixin</code> notify listeners automatically, you do not
need to assign <code>numbers.value = ...</code> to force updates. Methods like <code>add</code>, <code>addAll</code>,
and operator <code>[]=</code> take care of notification.
</Success>

---

## Members of `ListSignalMixin`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **cast** | `method` | `List<R> cast()` |  |
| **first** | `method` | `first(E val)` |  |
| **last** | `method` | `E last` |  |
| **last** | `method` | `last(E val)` |  |
| **length** | `method` | `length(int value)` |  |
| **+** | `method` | `List<E> +(List<E> other)` |  |
| **[]** | `method` | `E [](int index)` |  |
| **[]=** | `method` | `void []=(int index, E value)` |  |
| **add** | `method` | `void add(E value)` |  |
| **addAll** | `method` | `void addAll(Iterable<E> iterable)` |  |
| **asMap** | `method` | `Map<int, E> asMap()` |  |
| **clear** | `method` | `void clear()` |  |
| **expand** | `method` | `Iterable<R> expand(Iterable<R> Function(E element) toElements)` |  |
| **fillRange** | `method` | `void fillRange(int start, int end, [E? fillValue])` |  |
| **firstWhere** | `method` | `E firstWhere(bool Function(E element) test, {E Function()? orElse})` |  |
| **fold** | `method` | `R fold(R initialValue, R Function(R previousValue, E element) combine)` |  |
| **followedBy** | `method` | `Iterable<E> followedBy(Iterable<E> other)` |  |
| **getRange** | `method` | `Iterable<E> getRange(int start, int end)` |  |
| **indexOf** | `method` | `int indexOf(E element, [int start = 0])` |  |
| **indexWhere** | `method` | `int indexWhere(bool Function(E element) test, [int start = 0])` |  |
| **insert** | `method` | `void insert(int index, E element)` |  |
| **insertAll** | `method` | `void insertAll(int index, Iterable<E> iterable)` |  |
| **lastIndexOf** | `method` | `int lastIndexOf(E element, [int? start])` |  |
| **lastIndexWhere** | `method` | `int lastIndexWhere(bool Function(E element) test, [int? start])` |  |
| **remove** | `method` | `bool remove(Object? value)` |  |
| **removeAt** | `method` | `E removeAt(int index)` |  |
| **removeLast** | `method` | `E removeLast()` |  |
| **removeRange** | `method` | `void removeRange(int start, int end)` |  |
| **removeWhere** | `method` | `void removeWhere(bool Function(E element) test)` |  |
| **replaceRange** | `method` | `void replaceRange(int start, int end, Iterable<E> replacements)` |  |
| **retainWhere** | `method` | `void retainWhere(bool Function(E element) test)` |  |
| **reversed** | `method` | `Iterable<E> reversed` |  |
| **setAll** | `method` | `void setAll(int index, Iterable<E> iterable)` |  |
| **setRange** | `method` | `void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0])` |  |
| **shuffle** | `method` | `void shuffle([Random? random])` |  |
| **sort** | `method` | `void sort([int Function(E a, E b)? compare])` |  |
| **sorted** | `method` | `List<E> sorted([int Function(E a, E b)? compare])` | Return a new array that is sorted by the **compare** function |
| **sublist** | `method` | `List<E> sublist(int start, [int? end])` |  |
