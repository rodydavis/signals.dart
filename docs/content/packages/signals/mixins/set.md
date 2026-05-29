---
title: SetSignalMixin
description: A mixin that adds reactive <code>Set</code> methods and operations to a Signal.
---

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


### Methods

<details>
<summary> View Methods </summary>

##### <a name="add"></a><code>bool add(E value)</code>

##### <a name="addall"></a><code>void addAll(Iterable<E> elements)</code>

##### <a name="cast"></a><code>Set<R> cast()</code>

##### <a name="clear"></a><code>void clear()</code>

##### <a name="containsall"></a><code>bool containsAll(Iterable<Object?> other)</code>

##### <a name="difference"></a><code>Set<E> difference(Set<Object?> other)</code>

##### <a name="intersection"></a><code>Set<E> intersection(Set<Object?> other)</code>

##### <a name="lookup"></a><code>E? lookup(Object? object)</code>

##### <a name="remove"></a><code>bool remove(Object? value)</code>

##### <a name="removeall"></a><code>void removeAll(Iterable<Object?> elements)</code>

##### <a name="removewhere"></a><code>void removeWhere(bool Function(E element) test)</code>

##### <a name="retainall"></a><code>void retainAll(Iterable<Object?> elements)</code>

##### <a name="retainwhere"></a><code>void retainWhere(bool Function(E element) test)</code>

##### <a name="union"></a><code>Set<E> union(Set<E> other)</code>

</details>
