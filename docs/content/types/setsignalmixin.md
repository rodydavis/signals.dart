---
title: "Type: SetSignalMixin"
description: "API reference and details for SetSignalMixin from signals.dart."
---

# SetSignalMixin

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: SetSignalMixin

A mixin that adds reactive <code>Set</code> methods and operations to a [Signal](/types/signal)
holding a **Set** value.

This mixin delegates all standard **Set** operations (such as mutations like <code>add</code>,
<code>remove</code>, <code>addAll</code>, <code>removeAll</code>, <code>retainAll</code>, and <code>clear</code>) to the underlying set,
while ensuring that any reads register a dependency and any mutations
automatically trigger reactive updates.

<Info>
This mixin only works with signals that have a value type extending <strong>Set<E></strong>.
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

class MySetSignal extends Signal<Set<int>>
    with IterableSignalMixin<int, Set<int>>, SetSignalMixin<int, Set<int>> {
  MySetSignal(super.internalValue);
}

void main() {
  final numbers = MySetSignal({1, 2, 3});

  effect(() {
    print('Elements: $numbers, Length: ${numbers.length}');
  }); // Prints: "Elements: {1, 2, 3}, Length: 3"

  // Adding an element (automatically calls set() and triggers updates)
  numbers.add(4); // Prints: "Elements: {1, 2, 3, 4}, Length: 4"

  // Removing an element (triggers updates)
  numbers.remove(1); // Prints: "Elements: {2, 3, 4}, Length: 3"
}
```

<Success>
Since mutations on <code>SetSignalMixin</code> notify listeners automatically, you do not
need to assign <code>numbers.value = ...</code> to force updates. Methods like <code>add</code>, <code>addAll</code>,
and <code>remove</code> take care of notification.
</Success>

### Members of SetSignalMixin

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **add** | <code>method</code> | <code>dart bool add(E value)</code> |  |
| **addAll** | <code>method</code> | <code>dart void addAll(Iterable<E> elements)</code> |  |
| **cast** | <code>method</code> | <code>dart Set<R> cast()</code> |  |
| **clear** | <code>method</code> | <code>dart void clear()</code> |  |
| **containsAll** | <code>method</code> | <code>dart bool containsAll(Iterable<Object?> other)</code> |  |
| **difference** | <code>method</code> | <code>dart Set<E> difference(Set<Object?> other)</code> |  |
| **intersection** | <code>method</code> | <code>dart Set<E> intersection(Set<Object?> other)</code> |  |
| **lookup** | <code>method</code> | <code>dart E? lookup(Object? object)</code> |  |
| **remove** | <code>method</code> | <code>dart bool remove(Object? value)</code> |  |
| **removeAll** | <code>method</code> | <code>dart void removeAll(Iterable<Object?> elements)</code> |  |
| **removeWhere** | <code>method</code> | <code>dart void removeWhere(bool Function(E element) test)</code> |  |
| **retainAll** | <code>method</code> | <code>dart void retainAll(Iterable<Object?> elements)</code> |  |
| **retainWhere** | <code>method</code> | <code>dart void retainWhere(bool Function(E element) test)</code> |  |
| **union** | <code>method</code> | <code>dart Set<E> union(Set<E> other)</code> |  |

## References

The **SetSignalMixin** type is referenced and used in the following pages:

* [SetSignalMixin](/packages/signals_flutter/mixins/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [signals_flutter](/packages/signals_flutter)
* [SetSignalMixin](/packages/signals_core/mixins/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [signals_core](/packages/signals_core)
* [SetSignalMixin](/packages/signals/mixins/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [signals](/packages/signals)

