---
title: "Type: QueueSignalMixin"
description: "API reference and details for QueueSignalMixin from signals.dart."
---

# QueueSignalMixin

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: QueueSignalMixin

A mixin that adds reactive <code>Queue</code> methods and operations to a [Signal](/types/signal)
holding a **Queue** value.

This mixin delegates all standard **Queue** operations (such as mutations like <code>add</code>,
<code>addAll</code>, <code>addFirst</code>, <code>addLast</code>, <code>removeFirst</code>, <code>removeLast</code>, and <code>clear</code>) to the
underlying queue, while ensuring that any reads register a dependency and any
mutations automatically trigger reactive updates.

<Info>
This mixin only works with signals that have a value type extending <strong>Queue<T></strong>.
</Info>

### Example Usage

```dart
import 'dart:collection';
import 'package:signals/signals.dart';

class MyQueueSignal extends Signal<Queue<int>>
    with QueueSignalMixin<int, Queue<int>> {
  MyQueueSignal(super.internalValue);
}

void main() {
  final q = Queue<int>()..add(1);
  final signal = MyQueueSignal(q);

  effect(() {
    print('Queue elements: $signal, Length: ${signal.length}');
  }); // Prints: "Queue elements: {1}, Length: 1"

  // Adding to the front of the queue (triggers updates)
  signal.addFirst(0); // Prints: "Queue elements: {0, 1}, Length: 2"

  // Adding to the back of the queue (triggers updates)
  signal.addLast(2); // Prints: "Queue elements: {0, 1, 2}, Length: 3"

  // Removing from the front of the queue (triggers updates)
  final first = signal.removeFirst(); // Prints: "Queue elements: {1, 2}, Length: 2"
}
```

<Success>
Since mutations on <code>QueueSignalMixin</code> notify listeners automatically, you do not
need to assign <code>signal.value = ...</code> to force updates. Methods like <code>addFirst</code>,
<code>addLast</code>, <code>removeFirst</code>, and <code>removeLast</code> take care of notification.
</Success>

### Members of QueueSignalMixin

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **add** | <code>method</code> | <code>dart void add(T value)</code> |  |
| **addAll** | <code>method</code> | <code>dart void addAll(Iterable<T> iterable)</code> |  |
| **addFirst** | <code>method</code> | <code>dart void addFirst(T value)</code> |  |
| **addLast** | <code>method</code> | <code>dart void addLast(T value)</code> |  |
| **any** | <code>method</code> | <code>dart bool any(bool Function(T element) test)</code> |  |
| **cast** | <code>method</code> | <code>dart Queue<R> cast()</code> |  |
| **clear** | <code>method</code> | <code>dart void clear()</code> |  |
| **contains** | <code>method</code> | <code>dart bool contains(Object? element)</code> |  |
| **elementAt** | <code>method</code> | <code>dart T elementAt(int index)</code> |  |
| **every** | <code>method</code> | <code>dart bool every(bool Function(T element) test)</code> |  |
| **expand** | <code>method</code> | <code>dart Iterable<U> expand(Iterable<U> Function(T element) toElements)</code> |  |
| **first** | <code>method</code> | <code>dart T first</code> |  |
| **firstWhere** | <code>method</code> | <code>dart T firstWhere(bool Function(T element) test, {T Function()? orElse})</code> |  |
| **fold** | <code>method</code> | <code>dart U fold(U initialValue, U Function(U previousValue, T element) combine)</code> |  |
| **followedBy** | <code>method</code> | <code>dart Iterable<T> followedBy(Iterable<T> other)</code> |  |
| **forEach** | <code>method</code> | <code>dart void forEach(void Function(T element) action)</code> |  |
| **isEmpty** | <code>method</code> | <code>dart bool isEmpty</code> |  |
| **isNotEmpty** | <code>method</code> | <code>dart bool isNotEmpty</code> |  |
| **iterator** | <code>method</code> | <code>dart Iterator<T> iterator</code> |  |
| **join** | <code>method</code> | <code>dart String join([String separator = ""])</code> |  |
| **last** | <code>method</code> | <code>dart T last</code> |  |
| **lastWhere** | <code>method</code> | <code>dart T lastWhere(bool Function(T element) test, {T Function()? orElse})</code> |  |
| **length** | <code>method</code> | <code>dart int length</code> |  |
| **map** | <code>method</code> | <code>dart Iterable<U> map(U Function(T e) toElement)</code> |  |
| **reduce** | <code>method</code> | <code>dart T reduce(T Function(T value, T element) combine)</code> |  |
| **remove** | <code>method</code> | <code>dart bool remove(Object? value)</code> |  |
| **removeFirst** | <code>method</code> | <code>dart T removeFirst()</code> |  |
| **removeLast** | <code>method</code> | <code>dart T removeLast()</code> |  |
| **removeWhere** | <code>method</code> | <code>dart void removeWhere(bool Function(T element) test)</code> |  |
| **retainWhere** | <code>method</code> | <code>dart void retainWhere(bool Function(T element) test)</code> |  |
| **single** | <code>method</code> | <code>dart T single</code> |  |
| **singleWhere** | <code>method</code> | <code>dart T singleWhere(bool Function(T element) test, {T Function()? orElse})</code> |  |
| **skip** | <code>method</code> | <code>dart Iterable<T> skip(int count)</code> |  |
| **skipWhile** | <code>method</code> | <code>dart Iterable<T> skipWhile(bool Function(T value) test)</code> |  |
| **take** | <code>method</code> | <code>dart Iterable<T> take(int count)</code> |  |
| **takeWhile** | <code>method</code> | <code>dart Iterable<T> takeWhile(bool Function(T value) test)</code> |  |
| **toList** | <code>method</code> | <code>dart List<T> toList({bool growable = true})</code> |  |
| **toSet** | <code>method</code> | <code>dart Set<T> toSet()</code> |  |
| **where** | <code>method</code> | <code>dart Iterable<T> where(bool Function(T element) test)</code> |  |
| **whereType** | <code>method</code> | <code>dart Iterable<U> whereType()</code> |  |

## References

The **QueueSignalMixin** type is referenced and used in the following pages:

* [QueueSignalMixin](/packages/signals_flutter/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [signals_flutter](/packages/signals_flutter)
* [QueueSignalMixin](/packages/signals_core/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [signals_core](/packages/signals_core)
* [QueueSignalMixin](/packages/signals/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [signals](/packages/signals)

