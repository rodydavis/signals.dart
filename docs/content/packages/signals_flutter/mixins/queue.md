---
title: QueueSignalMixin
description: A mixin that adds reactive <code>Queue</code> methods and operations to a Signal.
---

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


### Methods

<details>
<summary> View Methods </summary>

##### <a name="add"></a><code>void add(T value)</code>

##### <a name="addall"></a><code>void addAll(Iterable<T> iterable)</code>

##### <a name="addfirst"></a><code>void addFirst(T value)</code>

##### <a name="addlast"></a><code>void addLast(T value)</code>

##### <a name="any"></a><code>bool any(bool Function(T element) test)</code>

##### <a name="cast"></a><code>Queue<R> cast()</code>

##### <a name="clear"></a><code>void clear()</code>

##### <a name="contains"></a><code>bool contains(Object? element)</code>

##### <a name="elementat"></a><code>T elementAt(int index)</code>

##### <a name="every"></a><code>bool every(bool Function(T element) test)</code>

##### <a name="expand"></a><code>Iterable<U> expand(Iterable<U> Function(T element) toElements)</code>

##### <a name="first"></a><code>T first</code>

##### <a name="firstwhere"></a><code>T firstWhere(bool Function(T element) test, {T Function()? orElse})</code>

##### <a name="fold"></a><code>U fold(U initialValue, U Function(U previousValue, T element) combine)</code>

##### <a name="followedby"></a><code>Iterable<T> followedBy(Iterable<T> other)</code>

##### <a name="foreach"></a><code>void forEach(void Function(T element) action)</code>

##### <a name="isempty"></a><code>bool isEmpty</code>

##### <a name="isnotempty"></a><code>bool isNotEmpty</code>

##### <a name="iterator"></a><code>Iterator<T> iterator</code>

##### <a name="join"></a><code>String join([String separator = ""])</code>

##### <a name="last"></a><code>T last</code>

##### <a name="lastwhere"></a><code>T lastWhere(bool Function(T element) test, {T Function()? orElse})</code>

##### <a name="length"></a><code>int length</code>

##### <a name="map"></a><code>Iterable<U> map(U Function(T e) toElement)</code>

##### <a name="reduce"></a><code>T reduce(T Function(T value, T element) combine)</code>

##### <a name="remove"></a><code>bool remove(Object? value)</code>

##### <a name="removefirst"></a><code>T removeFirst()</code>

##### <a name="removelast"></a><code>T removeLast()</code>

##### <a name="removewhere"></a><code>void removeWhere(bool Function(T element) test)</code>

##### <a name="retainwhere"></a><code>void retainWhere(bool Function(T element) test)</code>

##### <a name="single"></a><code>T single</code>

##### <a name="singlewhere"></a><code>T singleWhere(bool Function(T element) test, {T Function()? orElse})</code>

##### <a name="skip"></a><code>Iterable<T> skip(int count)</code>

##### <a name="skipwhile"></a><code>Iterable<T> skipWhile(bool Function(T value) test)</code>

##### <a name="take"></a><code>Iterable<T> take(int count)</code>

##### <a name="takewhile"></a><code>Iterable<T> takeWhile(bool Function(T value) test)</code>

##### <a name="tolist"></a><code>List<T> toList({bool growable = true})</code>

##### <a name="toset"></a><code>Set<T> toSet()</code>

##### <a name="where"></a><code>Iterable<T> where(bool Function(T element) test)</code>

##### <a name="wheretype"></a><code>Iterable<U> whereType()</code>

</details>



---

## SignalQueueUtils

Utility extension methods on **Queue** to convert them to [QueueSignal](/types/queuesignal)s.


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tosignal"></a><code>QueueSignal<T> toSignal({QueueSignalOptions<T>? options, @Deprecated('Use options: QueueSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: QueueSignalOptions(name: ...) instead') String? debugLabel})</code>

Convert an existing list to [QueueSignal](/types/queuesignal)

</details>



---

## queueSignal

Creates a [QueueSignal](/types/queuesignal) with the given **list** (Queue).


---

## QueueSignalOptions

Configuration options for a [QueueSignal](/types/queuesignal).


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="queuesignaloptions"></a><a name="queuesignaloptions"></a><code>QueueSignalOptions({super.name, super.autoDispose, super.watched, super.unwatched, super.equality = const SignalDeepEquality()})</code>

Creates a new [QueueSignalOptions](/types/queuesignaloptions) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a><code>QueueSignalOptions<T> copyWith({String? name, bool? autoDispose, void Function()? watched, void Function()? unwatched, SignalEquality<Queue<T>>? equality})</code>

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## QueueSignal

A [Signal](/types/signal) that holds a **Queue**.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="queuesignal"></a><a name="queuesignal"></a><code>QueueSignal(super.value, {QueueSignalOptions<T>? options, @Deprecated('Use options: QueueSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: QueueSignalOptions(name: ...) instead') String? debugLabel})</code>

Creates a [QueueSignal](/types/queuesignal) with the given **value**.

</details>
