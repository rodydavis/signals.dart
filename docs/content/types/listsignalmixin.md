---
title: "Type: ListSignalMixin"
description: "API reference and details for ListSignalMixin from signals.dart."
---

# ListSignalMixin

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: ListSignalMixin

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

### Members of ListSignalMixin

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **cast** | <code>method</code> | <code>dart List<R> cast()</code> |  |
| **first** | <code>method</code> | <code>dart first(E val)</code> |  |
| **last** | <code>method</code> | <code>dart E last</code> |  |
| **last** | <code>method</code> | <code>dart last(E val)</code> |  |
| **length** | <code>method</code> | <code>dart length(int value)</code> |  |
| **+** | <code>method</code> | <code>dart List<E> +(List<E> other)</code> |  |
| **[]** | <code>method</code> | <code>dart E [](int index)</code> |  |
| **[]=** | <code>method</code> | <code>dart void []=(int index, E value)</code> |  |
| **add** | <code>method</code> | <code>dart void add(E value)</code> |  |
| **addAll** | <code>method</code> | <code>dart void addAll(Iterable<E> iterable)</code> |  |
| **asMap** | <code>method</code> | <code>dart Map<int, E> asMap()</code> |  |
| **clear** | <code>method</code> | <code>dart void clear()</code> |  |
| **expand** | <code>method</code> | <code>dart Iterable<R> expand(Iterable<R> Function(E element) toElements)</code> |  |
| **fillRange** | <code>method</code> | <code>dart void fillRange(int start, int end, [E? fillValue])</code> |  |
| **firstWhere** | <code>method</code> | <code>dart E firstWhere(bool Function(E element) test, {E Function()? orElse})</code> |  |
| **fold** | <code>method</code> | <code>dart R fold(R initialValue, R Function(R previousValue, E element) combine)</code> |  |
| **followedBy** | <code>method</code> | <code>dart Iterable<E> followedBy(Iterable<E> other)</code> |  |
| **getRange** | <code>method</code> | <code>dart Iterable<E> getRange(int start, int end)</code> |  |
| **indexOf** | <code>method</code> | <code>dart int indexOf(E element, [int start = 0])</code> |  |
| **indexWhere** | <code>method</code> | <code>dart int indexWhere(bool Function(E element) test, [int start = 0])</code> |  |
| **insert** | <code>method</code> | <code>dart void insert(int index, E element)</code> |  |
| **insertAll** | <code>method</code> | <code>dart void insertAll(int index, Iterable<E> iterable)</code> |  |
| **lastIndexOf** | <code>method</code> | <code>dart int lastIndexOf(E element, [int? start])</code> |  |
| **lastIndexWhere** | <code>method</code> | <code>dart int lastIndexWhere(bool Function(E element) test, [int? start])</code> |  |
| **remove** | <code>method</code> | <code>dart bool remove(Object? value)</code> |  |
| **removeAt** | <code>method</code> | <code>dart E removeAt(int index)</code> |  |
| **removeLast** | <code>method</code> | <code>dart E removeLast()</code> |  |
| **removeRange** | <code>method</code> | <code>dart void removeRange(int start, int end)</code> |  |
| **removeWhere** | <code>method</code> | <code>dart void removeWhere(bool Function(E element) test)</code> |  |
| **replaceRange** | <code>method</code> | <code>dart void replaceRange(int start, int end, Iterable<E> replacements)</code> |  |
| **retainWhere** | <code>method</code> | <code>dart void retainWhere(bool Function(E element) test)</code> |  |
| **reversed** | <code>method</code> | <code>dart Iterable<E> reversed</code> |  |
| **setAll** | <code>method</code> | <code>dart void setAll(int index, Iterable<E> iterable)</code> |  |
| **setRange** | <code>method</code> | <code>dart void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0])</code> |  |
| **shuffle** | <code>method</code> | <code>dart void shuffle([Random? random])</code> |  |
| **sort** | <code>method</code> | <code>dart void sort([int Function(E a, E b)? compare])</code> |  |
| **sorted** | <code>method</code> | <code>dart List<E> sorted([int Function(E a, E b)? compare])</code> | Return a new array that is sorted by the **compare** function |
| **sublist** | <code>method</code> | <code>dart List<E> sublist(int start, [int? end])</code> |  |

## References

The **ListSignalMixin** type is referenced and used in the following pages:

* [ListSignalMixin](/packages/signals_flutter/mixins/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [signals_flutter](/packages/signals_flutter)
* [ListSignalMixin](/packages/signals_core/mixins/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [signals_core](/packages/signals_core)
* [ListSignalMixin](/packages/signals/mixins/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [signals](/packages/signals)
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

