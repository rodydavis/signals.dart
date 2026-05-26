---
title: SetSignalMixin
description: A mixin that adds reactive Set methods and operations to a Signal.
---

A mixin that adds reactive `Set` methods and operations to a [Signal](/packages/signals/core/signal)
holding a **Set** value.

This mixin delegates all standard **Set** operations (such as mutations like `add`,
`remove`, `addAll`, `removeAll`, `retainAll`, and `clear`) to the underlying set,
while ensuring that any reads register a dependency and any mutations
automatically trigger reactive updates.

<Info>
This mixin only works with signals that have a value type extending **Set<E>**.
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
Since mutations on `SetSignalMixin` notify listeners automatically, you do not
need to assign `numbers.value = ...` to force updates. Methods like `add`, `addAll`,
and `remove` take care of notification.
</Success>


### Methods

##### <a name="add"></a>`bool add(E value)`

##### <a name="addall"></a>`void addAll(Iterable<E> elements)`

##### <a name="cast"></a>`Set<R> cast()`

##### <a name="clear"></a>`void clear()`

##### <a name="containsall"></a>`bool containsAll(Iterable<Object?> other)`

##### <a name="difference"></a>`Set<E> difference(Set<Object?> other)`

##### <a name="intersection"></a>`Set<E> intersection(Set<Object?> other)`

##### <a name="lookup"></a>`E? lookup(Object? object)`

##### <a name="remove"></a>`bool remove(Object? value)`

##### <a name="removeall"></a>`void removeAll(Iterable<Object?> elements)`

##### <a name="removewhere"></a>`void removeWhere(bool Function(E element) test)`

##### <a name="retainall"></a>`void retainAll(Iterable<Object?> elements)`

##### <a name="retainwhere"></a>`void retainWhere(bool Function(E element) test)`

##### <a name="union"></a>`Set<E> union(Set<E> other)`
