---
title: StreamSignalMixin
description: A mixin that implements the standard Stream interface for a ReadonlySignal.
---

A mixin that implements the standard **Stream** interface for a [ReadonlySignal](/types/readonlysignal).

This mixin allows you to treat a read-only or writable signal as a standard asynchronous
**Stream**, where updates to the signal's value are pushed as stream events.
This provides out-of-the-box compatibility with the entire asynchronous Dart SDK,
such as stream transformers, <code>await for</code> loops, and Flutter's **StreamBuilder**.

### Example Usage

```dart
import 'package:signals/signals.dart';

class MyStreamSignal extends Signal<int> with StreamSignalMixin<int> {
  MyStreamSignal(super.internalValue);
}

void main() async {
  final counter = MyStreamSignal(0);

  // Standard stream subscription
  final subscription = counter.listen((val) {
    print('Stream emitted: $val');
  }); // Prints: "Stream emitted: 0" (if listened immediately)

  counter.value = 1; // Prints: "Stream emitted: 1"
  counter.value = 2; // Prints: "Stream emitted: 2"

  await subscription.cancel();
}
```

### Flutter StreamBuilder Example

```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class CounterSignal extends Signal<int> with StreamSignalMixin<int> {
  CounterSignal(int value) : super(value);
}

final counter = CounterSignal(0);

Widget build(BuildContext context) {
  return StreamBuilder<int>(
    stream: counter,
    builder: (context, snapshot) {
      return Text('Count: ${snapshot.data}');
    },
  );
}
```

<Success>
Since <a href="/types/streamsignalmixin">StreamSignalMixin</a> creates an internal broadcast <strong>StreamController</strong>, multiple listeners
can subscribe simultaneously. All subscriptions are closed and resources are released
automatically when the signal is disposed.
</Success>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="any"></a><code>Future<bool> any(bool Function(T element) test)</code>

##### <a name="asbroadcaststream"></a><code>Stream<T> asBroadcastStream({void Function(StreamSubscription<T> subscription)? onListen, void Function(StreamSubscription<T> subscription)? onCancel})</code>

##### <a name="asyncexpand"></a><code>Stream<E> asyncExpand(Stream<E>? Function(T event) convert)</code>

##### <a name="asyncmap"></a><code>Stream<E> asyncMap(FutureOr<E> Function(T event) convert)</code>

##### <a name="cast"></a><code>Stream<R> cast()</code>

##### <a name="contains"></a><code>Future<bool> contains(Object? needle)</code>

##### <a name="distinct"></a><code>Stream<T> distinct([bool Function(T previous, T next)? equals])</code>

##### <a name="drain"></a><code>Future<E> drain([E? futureValue])</code>

##### <a name="elementat"></a><code>Future<T> elementAt(int index)</code>

##### <a name="every"></a><code>Future<bool> every(bool Function(T element) test)</code>

##### <a name="expand"></a><code>Stream<S> expand(Iterable<S> Function(T element) convert)</code>

##### <a name="first"></a><code>Future<T> first</code>

##### <a name="firstwhere"></a><code>Future<T> firstWhere(bool Function(T element) test, {T Function()? orElse})</code>

##### <a name="fold"></a><code>Future<S> fold(S initialValue, S Function(S previous, T element) combine)</code>

##### <a name="foreach"></a><code>Future<void> forEach(void Function(T element) action)</code>

##### <a name="handleerror"></a><code>Stream<T> handleError(Function onError, {bool Function(dynamic error)? test})</code>

##### <a name="isbroadcast"></a><code>bool isBroadcast</code>

##### <a name="isempty"></a><code>Future<bool> isEmpty</code>

##### <a name="join"></a><code>Future<String> join([String separator = ""])</code>

##### <a name="last"></a><code>Future<T> last</code>

##### <a name="lastwhere"></a><code>Future<T> lastWhere(bool Function(T element) test, {T Function()? orElse})</code>

##### <a name="length"></a><code>Future<int> length</code>

##### <a name="listen"></a><code>StreamSubscription<T> listen(void Function(T event)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError})</code>

##### <a name="map"></a><code>Stream<S> map(S Function(T event) convert)</code>

##### <a name="pipe"></a><code>Future pipe(StreamConsumer<T> streamConsumer)</code>

##### <a name="reduce"></a><code>Future<T> reduce(T Function(T previous, T element) combine)</code>

##### <a name="single"></a><code>Future<T> single</code>

##### <a name="singlewhere"></a><code>Future<T> singleWhere(bool Function(T element) test, {T Function()? orElse})</code>

##### <a name="skip"></a><code>Stream<T> skip(int count)</code>

##### <a name="skipwhile"></a><code>Stream<T> skipWhile(bool Function(T element) test)</code>

##### <a name="take"></a><code>Stream<T> take(int count)</code>

##### <a name="takewhile"></a><code>Stream<T> takeWhile(bool Function(T element) test)</code>

##### <a name="timeout"></a><code>Stream<T> timeout(Duration timeLimit, {void Function(EventSink<T> sink)? onTimeout})</code>

##### <a name="tolist"></a><code>Future<List<T>> toList()</code>

##### <a name="toset"></a><code>Future<Set<T>> toSet()</code>

##### <a name="transform"></a><code>Stream<S> transform(StreamTransformer<T, S> streamTransformer)</code>

##### <a name="where"></a><code>Stream<T> where(bool Function(T event) test)</code>

</details>
