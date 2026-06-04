---
title: ListSignalMixin
description: A mixin that adds reactive <code>List</code> methods and operators to a Signal.
---

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


### Methods

<details>
<summary> View Methods </summary>

##### <a name="cast"></a><code>List<R> cast()</code>

##### <a name="first"></a><code>first(E val)</code>

##### <a name="last"></a><code>E last</code>

##### <a name="last"></a><code>last(E val)</code>

##### <a name="length"></a><code>length(int value)</code>

##### <a name="+"></a><code>List<E> +(List<E> other)</code>

##### <a name="[]"></a><code>E [](int index)</code>

##### <a name="[]="></a><code>void []=(int index, E value)</code>

##### <a name="add"></a><code>void add(E value)</code>

##### <a name="addall"></a><code>void addAll(Iterable<E> iterable)</code>

##### <a name="asmap"></a><code>Map<int, E> asMap()</code>

##### <a name="clear"></a><code>void clear()</code>

##### <a name="expand"></a><code>Iterable<R> expand(Iterable<R> Function(E element) toElements)</code>

##### <a name="fillrange"></a><code>void fillRange(int start, int end, [E? fillValue])</code>

##### <a name="firstwhere"></a><code>E firstWhere(bool Function(E element) test, {E Function()? orElse})</code>

##### <a name="fold"></a><code>R fold(R initialValue, R Function(R previousValue, E element) combine)</code>

##### <a name="followedby"></a><code>Iterable<E> followedBy(Iterable<E> other)</code>

##### <a name="getrange"></a><code>Iterable<E> getRange(int start, int end)</code>

##### <a name="indexof"></a><code>int indexOf(E element, [int start = 0])</code>

##### <a name="indexwhere"></a><code>int indexWhere(bool Function(E element) test, [int start = 0])</code>

##### <a name="insert"></a><code>void insert(int index, E element)</code>

##### <a name="insertall"></a><code>void insertAll(int index, Iterable<E> iterable)</code>

##### <a name="lastindexof"></a><code>int lastIndexOf(E element, [int? start])</code>

##### <a name="lastindexwhere"></a><code>int lastIndexWhere(bool Function(E element) test, [int? start])</code>

##### <a name="remove"></a><code>bool remove(Object? value)</code>

##### <a name="removeat"></a><code>E removeAt(int index)</code>

##### <a name="removelast"></a><code>E removeLast()</code>

##### <a name="removerange"></a><code>void removeRange(int start, int end)</code>

##### <a name="removewhere"></a><code>void removeWhere(bool Function(E element) test)</code>

##### <a name="replacerange"></a><code>void replaceRange(int start, int end, Iterable<E> replacements)</code>

##### <a name="retainwhere"></a><code>void retainWhere(bool Function(E element) test)</code>

##### <a name="reversed"></a><code>Iterable<E> reversed</code>

##### <a name="setall"></a><code>void setAll(int index, Iterable<E> iterable)</code>

##### <a name="setrange"></a><code>void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0])</code>

##### <a name="shuffle"></a><code>void shuffle([Random? random])</code>

##### <a name="sort"></a><code>void sort([int Function(E a, E b)? compare])</code>

##### <a name="sorted"></a><code>List<E> sorted([int Function(E a, E b)? compare])</code>

Return a new array that is sorted by the **compare** function

##### <a name="sublist"></a><code>List<E> sublist(int start, [int? end])</code>

</details>
