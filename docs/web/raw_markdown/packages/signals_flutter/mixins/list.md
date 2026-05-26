---
title: ListSignalMixin
description: A mixin that adds reactive <code>List</code> methods and operators to a Signal.
---

A mixin that adds reactive <code>List</code> methods and operators to a [Signal](/packages/signals/core/signal)
holding a **List** value.

This mixin delegates all standard **List** operations (such as mutations like <code>add</code>,
<code>remove</code>, <code>insert</code>, <code>sort</code>, and <code>clear</code>, and accessor operators like <code>[]</code> and <code>[]=</code>)
to the underlying list, while ensuring that any reads register a dependency
and any mutations automatically trigger reactive updates.

<Info>
This mixin only works with signals that have a value type extending **List<E>**.
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


### Methods

<details>
<summary> View Methods </summary>

##### <a name="cast"></a>`List<R> cast()`

##### <a name="first"></a>`first(E val)`

##### <a name="last"></a>`E last`

##### <a name="last"></a>`last(E val)`

##### <a name="length"></a>`length(int value)`

##### <a name="+"></a>`List<E> +(List<E> other)`

##### <a name="[]"></a>`E [](int index)`

##### <a name="[]="></a>`void []=(int index, E value)`

##### <a name="add"></a>`void add(E value)`

##### <a name="addall"></a>`void addAll(Iterable<E> iterable)`

##### <a name="asmap"></a>`Map<int, E> asMap()`

##### <a name="clear"></a>`void clear()`

##### <a name="expand"></a>`Iterable<R> expand(Iterable<R> Function(E element) toElements)`

##### <a name="fillrange"></a>`void fillRange(int start, int end, [E? fillValue])`

##### <a name="firstwhere"></a>`E firstWhere(bool Function(E element) test, {E Function()? orElse})`

##### <a name="fold"></a>`R fold(R initialValue, R Function(R previousValue, E element) combine)`

##### <a name="followedby"></a>`Iterable<E> followedBy(Iterable<E> other)`

##### <a name="getrange"></a>`Iterable<E> getRange(int start, int end)`

##### <a name="indexof"></a>`int indexOf(E element, [int start = 0])`

##### <a name="indexwhere"></a>`int indexWhere(bool Function(E element) test, [int start = 0])`

##### <a name="insert"></a>`void insert(int index, E element)`

##### <a name="insertall"></a>`void insertAll(int index, Iterable<E> iterable)`

##### <a name="lastindexof"></a>`int lastIndexOf(E element, [int? start])`

##### <a name="lastindexwhere"></a>`int lastIndexWhere(bool Function(E element) test, [int? start])`

##### <a name="remove"></a>`bool remove(Object? value)`

##### <a name="removeat"></a>`E removeAt(int index)`

##### <a name="removelast"></a>`E removeLast()`

##### <a name="removerange"></a>`void removeRange(int start, int end)`

##### <a name="removewhere"></a>`void removeWhere(bool Function(E element) test)`

##### <a name="replacerange"></a>`void replaceRange(int start, int end, Iterable<E> replacements)`

##### <a name="retainwhere"></a>`void retainWhere(bool Function(E element) test)`

##### <a name="reversed"></a>`Iterable<E> reversed`

##### <a name="setall"></a>`void setAll(int index, Iterable<E> iterable)`

##### <a name="setrange"></a>`void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0])`

##### <a name="shuffle"></a>`void shuffle([Random? random])`

##### <a name="sort"></a>`void sort([int Function(E a, E b)? compare])`

##### <a name="sorted"></a>`List<E> sorted([int Function(E a, E b)? compare])`

Return a new array that is sorted by the **compare** function

##### <a name="sublist"></a>`List<E> sublist(int start, [int? end])`

</details>
