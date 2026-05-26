---
title: QueueSignalMixin
description: A mixin that adds reactive <code>Queue</code> methods and operations to a Signal.
---

A mixin that adds reactive <code>Queue</code> methods and operations to a [Signal](/packages/signals/core/signal)
holding a **Queue** value.

This mixin delegates all standard **Queue** operations (such as mutations like <code>add</code>,
<code>addAll</code>, <code>addFirst</code>, <code>addLast</code>, <code>removeFirst</code>, <code>removeLast</code>, and <code>clear</code>) to the
underlying queue, while ensuring that any reads register a dependency and any
mutations automatically trigger reactive updates.

<Info>
This mixin only works with signals that have a value type extending **Queue<T>**.
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


### Methods

<details>
<summary> View Methods </summary>

##### <a name="add"></a>`void add(T value)`

##### <a name="addall"></a>`void addAll(Iterable<T> iterable)`

##### <a name="addfirst"></a>`void addFirst(T value)`

##### <a name="addlast"></a>`void addLast(T value)`

##### <a name="any"></a>`bool any(bool Function(T element) test)`

##### <a name="cast"></a>`Queue<R> cast()`

##### <a name="clear"></a>`void clear()`

##### <a name="contains"></a>`bool contains(Object? element)`

##### <a name="elementat"></a>`T elementAt(int index)`

##### <a name="every"></a>`bool every(bool Function(T element) test)`

##### <a name="expand"></a>`Iterable<U> expand(Iterable<U> Function(T element) toElements)`

##### <a name="first"></a>`T first`

##### <a name="firstwhere"></a>`T firstWhere(bool Function(T element) test, {T Function()? orElse})`

##### <a name="fold"></a>`U fold(U initialValue, U Function(U previousValue, T element) combine)`

##### <a name="followedby"></a>`Iterable<T> followedBy(Iterable<T> other)`

##### <a name="foreach"></a>`void forEach(void Function(T element) action)`

##### <a name="isempty"></a>`bool isEmpty`

##### <a name="isnotempty"></a>`bool isNotEmpty`

##### <a name="iterator"></a>`Iterator<T> iterator`

##### <a name="join"></a>`String join([String separator = ""])`

##### <a name="last"></a>`T last`

##### <a name="lastwhere"></a>`T lastWhere(bool Function(T element) test, {T Function()? orElse})`

##### <a name="length"></a>`int length`

##### <a name="map"></a>`Iterable<U> map(U Function(T e) toElement)`

##### <a name="reduce"></a>`T reduce(T Function(T value, T element) combine)`

##### <a name="remove"></a>`bool remove(Object? value)`

##### <a name="removefirst"></a>`T removeFirst()`

##### <a name="removelast"></a>`T removeLast()`

##### <a name="removewhere"></a>`void removeWhere(bool Function(T element) test)`

##### <a name="retainwhere"></a>`void retainWhere(bool Function(T element) test)`

##### <a name="single"></a>`T single`

##### <a name="singlewhere"></a>`T singleWhere(bool Function(T element) test, {T Function()? orElse})`

##### <a name="skip"></a>`Iterable<T> skip(int count)`

##### <a name="skipwhile"></a>`Iterable<T> skipWhile(bool Function(T value) test)`

##### <a name="take"></a>`Iterable<T> take(int count)`

##### <a name="takewhile"></a>`Iterable<T> takeWhile(bool Function(T value) test)`

##### <a name="tolist"></a>`List<T> toList({bool growable = true})`

##### <a name="toset"></a>`Set<T> toSet()`

##### <a name="where"></a>`Iterable<T> where(bool Function(T element) test)`

##### <a name="wheretype"></a>`Iterable<U> whereType()`

</details>
