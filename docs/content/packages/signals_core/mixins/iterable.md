---
title: IterableSignalMixin
description: A mixin that adds reactive <code>Iterable</code> methods and properties to a Signal.
---

A mixin that adds reactive <code>Iterable</code> methods and properties to a [Signal](/packages/signals/core/signal)
holding an **Iterable** value.

This mixin delegates all standard **Iterable** operations (such as <code>length</code>,
<code>first</code>, <code>last</code>, <code>map</code>, <code>where</code>, and <code>any</code>) directly to the underlying
collection, while ensuring that any read operations register a reactive
dependency on the signal.

<Info>
This mixin only works with signals that have a value type extending **Iterable<E>**.
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


### Methods

<details>
<summary> View Methods </summary>

##### <a name="any"></a>`bool any(bool Function(E element) test)`

##### <a name="cast"></a>`Iterable<R> cast()`

##### <a name="contains"></a>`bool contains(Object? value)`

##### <a name="elementat"></a>`E elementAt(int index)`

##### <a name="every"></a>`bool every(bool Function(E element) test)`

##### <a name="expand"></a>`Iterable<R> expand(Iterable<R> Function(E element) toElements)`

##### <a name="first"></a>`E first`

##### <a name="firstwhere"></a>`E firstWhere(bool Function(E element) test, {E Function()? orElse})`

##### <a name="fold"></a>`R fold(R initialValue, R Function(R previousValue, E element) combine)`

##### <a name="followedby"></a>`Iterable<E> followedBy(Iterable<E> other)`

##### <a name="foreach"></a>`void forEach(void Function(E element) action)`

##### <a name="isempty"></a>`bool isEmpty`

##### <a name="isnotempty"></a>`bool isNotEmpty`

##### <a name="iterator"></a>`Iterator<E> iterator`

##### <a name="join"></a>`String join([String separator = ""])`

##### <a name="last"></a>`E last`

##### <a name="lastwhere"></a>`E lastWhere(bool Function(E element) test, {E Function()? orElse})`

##### <a name="length"></a>`int length`

##### <a name="map"></a>`Iterable<R> map(R Function(E e) toElement)`

##### <a name="reduce"></a>`E reduce(E Function(E value, E element) combine)`

##### <a name="single"></a>`E single`

##### <a name="singlewhere"></a>`E singleWhere(bool Function(E element) test, {E Function()? orElse})`

##### <a name="skip"></a>`Iterable<E> skip(int count)`

##### <a name="skipwhile"></a>`Iterable<E> skipWhile(bool Function(E value) test)`

##### <a name="take"></a>`Iterable<E> take(int count)`

##### <a name="takewhile"></a>`Iterable<E> takeWhile(bool Function(E value) test)`

##### <a name="tolist"></a>`List<E> toList({bool growable = true})`

##### <a name="toset"></a>`Set<E> toSet()`

##### <a name="where"></a>`Iterable<E> where(bool Function(E element) test)`

##### <a name="wheretype"></a>`Iterable<R> whereType()`

</details>
