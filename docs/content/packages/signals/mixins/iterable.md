---
title: IterableSignalMixin
description: A mixin that adds reactive <code>Iterable</code> methods and properties to a Signal.
---

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


### Methods

<details>
<summary> View Methods </summary>

##### <a name="any"></a><code>bool any(bool Function(E element) test)</code>

##### <a name="cast"></a><code>Iterable<R> cast()</code>

##### <a name="contains"></a><code>bool contains(Object? value)</code>

##### <a name="elementat"></a><code>E elementAt(int index)</code>

##### <a name="every"></a><code>bool every(bool Function(E element) test)</code>

##### <a name="expand"></a><code>Iterable<R> expand(Iterable<R> Function(E element) toElements)</code>

##### <a name="first"></a><code>E first</code>

##### <a name="firstwhere"></a><code>E firstWhere(bool Function(E element) test, {E Function()? orElse})</code>

##### <a name="fold"></a><code>R fold(R initialValue, R Function(R previousValue, E element) combine)</code>

##### <a name="followedby"></a><code>Iterable<E> followedBy(Iterable<E> other)</code>

##### <a name="foreach"></a><code>void forEach(void Function(E element) action)</code>

##### <a name="isempty"></a><code>bool isEmpty</code>

##### <a name="isnotempty"></a><code>bool isNotEmpty</code>

##### <a name="iterator"></a><code>Iterator<E> iterator</code>

##### <a name="join"></a><code>String join([String separator = ""])</code>

##### <a name="last"></a><code>E last</code>

##### <a name="lastwhere"></a><code>E lastWhere(bool Function(E element) test, {E Function()? orElse})</code>

##### <a name="length"></a><code>int length</code>

##### <a name="map"></a><code>Iterable<R> map(R Function(E e) toElement)</code>

##### <a name="reduce"></a><code>E reduce(E Function(E value, E element) combine)</code>

##### <a name="single"></a><code>E single</code>

##### <a name="singlewhere"></a><code>E singleWhere(bool Function(E element) test, {E Function()? orElse})</code>

##### <a name="skip"></a><code>Iterable<E> skip(int count)</code>

##### <a name="skipwhile"></a><code>Iterable<E> skipWhile(bool Function(E value) test)</code>

##### <a name="take"></a><code>Iterable<E> take(int count)</code>

##### <a name="takewhile"></a><code>Iterable<E> takeWhile(bool Function(E value) test)</code>

##### <a name="tolist"></a><code>List<E> toList({bool growable = true})</code>

##### <a name="toset"></a><code>Set<E> toSet()</code>

##### <a name="where"></a><code>Iterable<E> where(bool Function(E element) test)</code>

##### <a name="wheretype"></a><code>Iterable<R> whereType()</code>

</details>
