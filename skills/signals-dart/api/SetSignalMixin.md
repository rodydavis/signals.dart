# class `SetSignalMixin`

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

---

## Members of `SetSignalMixin`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **add** | `method` | `bool add(E value)` |  |
| **addAll** | `method` | `void addAll(Iterable<E> elements)` |  |
| **cast** | `method` | `Set<R> cast()` |  |
| **clear** | `method` | `void clear()` |  |
| **containsAll** | `method` | `bool containsAll(Iterable<Object?> other)` |  |
| **difference** | `method` | `Set<E> difference(Set<Object?> other)` |  |
| **intersection** | `method` | `Set<E> intersection(Set<Object?> other)` |  |
| **lookup** | `method` | `E? lookup(Object? object)` |  |
| **remove** | `method` | `bool remove(Object? value)` |  |
| **removeAll** | `method` | `void removeAll(Iterable<Object?> elements)` |  |
| **removeWhere** | `method` | `void removeWhere(bool Function(E element) test)` |  |
| **retainAll** | `method` | `void retainAll(Iterable<Object?> elements)` |  |
| **retainWhere** | `method` | `void retainWhere(bool Function(E element) test)` |  |
| **union** | `method` | `Set<E> union(Set<E> other)` |  |
