# class `QueueSignalMixin`

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

---

## Members of `QueueSignalMixin`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **add** | `method` | `void add(T value)` |  |
| **addAll** | `method` | `void addAll(Iterable<T> iterable)` |  |
| **addFirst** | `method` | `void addFirst(T value)` |  |
| **addLast** | `method` | `void addLast(T value)` |  |
| **any** | `method` | `bool any(bool Function(T element) test)` |  |
| **cast** | `method` | `Queue<R> cast()` |  |
| **clear** | `method` | `void clear()` |  |
| **contains** | `method` | `bool contains(Object? element)` |  |
| **elementAt** | `method` | `T elementAt(int index)` |  |
| **every** | `method` | `bool every(bool Function(T element) test)` |  |
| **expand** | `method` | `Iterable<U> expand(Iterable<U> Function(T element) toElements)` |  |
| **first** | `method` | `T first` |  |
| **firstWhere** | `method` | `T firstWhere(bool Function(T element) test, {T Function()? orElse})` |  |
| **fold** | `method` | `U fold(U initialValue, U Function(U previousValue, T element) combine)` |  |
| **followedBy** | `method` | `Iterable<T> followedBy(Iterable<T> other)` |  |
| **forEach** | `method` | `void forEach(void Function(T element) action)` |  |
| **isEmpty** | `method` | `bool isEmpty` |  |
| **isNotEmpty** | `method` | `bool isNotEmpty` |  |
| **iterator** | `method` | `Iterator<T> iterator` |  |
| **join** | `method` | `String join([String separator = ""])` |  |
| **last** | `method` | `T last` |  |
| **lastWhere** | `method` | `T lastWhere(bool Function(T element) test, {T Function()? orElse})` |  |
| **length** | `method` | `int length` |  |
| **map** | `method` | `Iterable<U> map(U Function(T e) toElement)` |  |
| **reduce** | `method` | `T reduce(T Function(T value, T element) combine)` |  |
| **remove** | `method` | `bool remove(Object? value)` |  |
| **removeFirst** | `method` | `T removeFirst()` |  |
| **removeLast** | `method` | `T removeLast()` |  |
| **removeWhere** | `method` | `void removeWhere(bool Function(T element) test)` |  |
| **retainWhere** | `method` | `void retainWhere(bool Function(T element) test)` |  |
| **single** | `method` | `T single` |  |
| **singleWhere** | `method` | `T singleWhere(bool Function(T element) test, {T Function()? orElse})` |  |
| **skip** | `method` | `Iterable<T> skip(int count)` |  |
| **skipWhile** | `method` | `Iterable<T> skipWhile(bool Function(T value) test)` |  |
| **take** | `method` | `Iterable<T> take(int count)` |  |
| **takeWhile** | `method` | `Iterable<T> takeWhile(bool Function(T value) test)` |  |
| **toList** | `method` | `List<T> toList({bool growable = true})` |  |
| **toSet** | `method` | `Set<T> toSet()` |  |
| **where** | `method` | `Iterable<T> where(bool Function(T element) test)` |  |
| **whereType** | `method` | `Iterable<U> whereType()` |  |
