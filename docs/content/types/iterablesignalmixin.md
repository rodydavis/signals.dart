---
title: "Type: IterableSignalMixin"
description: "API reference and details for IterableSignalMixin from signals.dart."
---

# IterableSignalMixin

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: IterableSignalMixin

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

### Members of IterableSignalMixin

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **any** | <code>method</code> | <code>dart bool any(bool Function(E element) test)</code> |  |
| **cast** | <code>method</code> | <code>dart Iterable<R> cast()</code> |  |
| **contains** | <code>method</code> | <code>dart bool contains(Object? value)</code> |  |
| **elementAt** | <code>method</code> | <code>dart E elementAt(int index)</code> |  |
| **every** | <code>method</code> | <code>dart bool every(bool Function(E element) test)</code> |  |
| **expand** | <code>method</code> | <code>dart Iterable<R> expand(Iterable<R> Function(E element) toElements)</code> |  |
| **first** | <code>method</code> | <code>dart E first</code> |  |
| **firstWhere** | <code>method</code> | <code>dart E firstWhere(bool Function(E element) test, {E Function()? orElse})</code> |  |
| **fold** | <code>method</code> | <code>dart R fold(R initialValue, R Function(R previousValue, E element) combine)</code> |  |
| **followedBy** | <code>method</code> | <code>dart Iterable<E> followedBy(Iterable<E> other)</code> |  |
| **forEach** | <code>method</code> | <code>dart void forEach(void Function(E element) action)</code> |  |
| **isEmpty** | <code>method</code> | <code>dart bool isEmpty</code> |  |
| **isNotEmpty** | <code>method</code> | <code>dart bool isNotEmpty</code> |  |
| **iterator** | <code>method</code> | <code>dart Iterator<E> iterator</code> |  |
| **join** | <code>method</code> | <code>dart String join([String separator = ""])</code> |  |
| **last** | <code>method</code> | <code>dart E last</code> |  |
| **lastWhere** | <code>method</code> | <code>dart E lastWhere(bool Function(E element) test, {E Function()? orElse})</code> |  |
| **length** | <code>method</code> | <code>dart int length</code> |  |
| **map** | <code>method</code> | <code>dart Iterable<R> map(R Function(E e) toElement)</code> |  |
| **reduce** | <code>method</code> | <code>dart E reduce(E Function(E value, E element) combine)</code> |  |
| **single** | <code>method</code> | <code>dart E single</code> |  |
| **singleWhere** | <code>method</code> | <code>dart E singleWhere(bool Function(E element) test, {E Function()? orElse})</code> |  |
| **skip** | <code>method</code> | <code>dart Iterable<E> skip(int count)</code> |  |
| **skipWhile** | <code>method</code> | <code>dart Iterable<E> skipWhile(bool Function(E value) test)</code> |  |
| **take** | <code>method</code> | <code>dart Iterable<E> take(int count)</code> |  |
| **takeWhile** | <code>method</code> | <code>dart Iterable<E> takeWhile(bool Function(E value) test)</code> |  |
| **toList** | <code>method</code> | <code>dart List<E> toList({bool growable = true})</code> |  |
| **toSet** | <code>method</code> | <code>dart Set<E> toSet()</code> |  |
| **where** | <code>method</code> | <code>dart Iterable<E> where(bool Function(E element) test)</code> |  |
| **whereType** | <code>method</code> | <code>dart Iterable<R> whereType()</code> |  |

## References

The **IterableSignalMixin** type is referenced and used in the following pages:

* [SetSignalMixin](/packages/signals_flutter/mixins/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [ListSignalMixin](/packages/signals_flutter/mixins/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [IterableSignalMixin](/packages/signals_flutter/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [signals_flutter](/packages/signals_flutter)
* [SetSignalMixin](/packages/signals_core/mixins/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [ListSignalMixin](/packages/signals_core/mixins/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [IterableSignalMixin](/packages/signals_core/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [signals_core](/packages/signals_core)
* [SetSignalMixin](/packages/signals/mixins/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [ListSignalMixin](/packages/signals/mixins/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [IterableSignalMixin](/packages/signals/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [signals](/packages/signals)

