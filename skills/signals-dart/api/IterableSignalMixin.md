# class `IterableSignalMixin`

A mixin that adds reactive <code>Iterable</code> methods and properties to a [Signal](/types/signal)
holding an **Iterable** value.

This mixin delegates all standard **Iterable** operations (such as <code>length</code>,
<code>first</code>, <code>last</code>, <code>map</code>, <code>where</code>, and <code>any</code>) directly to the underlying
collection, while ensuring that any read operations register a reactive
dependency on the signal.

<Info>
This mixin only works with signals that have a value type extending <strong>Iterable<E></strong>.
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

class MyIterableSignal extends Signal<Iterable<int>>
    with IterableSignalMixin<int, Iterable<int>> {
  MyIterableSignal(super.internalValue);
}

void main() {
  final numbers = MyIterableSignal([1, 2, 3]);

  // Set up a reactive effect that prints the list size and first element
  effect(() {
    print('Size: ${numbers.length}, First: ${numbers.first}');
  }); // Prints: "Size: 3, First: 1"

  // Update the signal value (triggers the effect)
  numbers.value = [10, 20, 30, 40]; // Prints: "Size: 4, First: 10"
}
```

<Warning>
Direct mutation of elements inside the iterable will NOT notify listeners
unless you reassign the value or use a specialized signal class like <code>ListSignal</code>,
<code>SetSignal</code>, or <code>MapSignal</code> which automatically trigger updates when modified.
</Warning>

---

## Members of `IterableSignalMixin`

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
| **forEach** | `method` | `void forEach(void Function(E element) action)` |  |
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
