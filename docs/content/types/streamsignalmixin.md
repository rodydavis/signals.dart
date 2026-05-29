---
title: "Type: StreamSignalMixin"
description: "API reference and details for StreamSignalMixin from signals.dart."
---

# StreamSignalMixin

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: StreamSignalMixin

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

### Members of StreamSignalMixin

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **any** | <code>method</code> | <code>dart Future<bool> any(bool Function(T element) test)</code> |  |
| **asBroadcastStream** | <code>method</code> | <code>dart Stream<T> asBroadcastStream({void Function(StreamSubscription<T> subscription)? onListen, void Function(StreamSubscription<T> subscription)? onCancel})</code> |  |
| **asyncExpand** | <code>method</code> | <code>dart Stream<E> asyncExpand(Stream<E>? Function(T event) convert)</code> |  |
| **asyncMap** | <code>method</code> | <code>dart Stream<E> asyncMap(FutureOr<E> Function(T event) convert)</code> |  |
| **cast** | <code>method</code> | <code>dart Stream<R> cast()</code> |  |
| **contains** | <code>method</code> | <code>dart Future<bool> contains(Object? needle)</code> |  |
| **distinct** | <code>method</code> | <code>dart Stream<T> distinct([bool Function(T previous, T next)? equals])</code> |  |
| **drain** | <code>method</code> | <code>dart Future<E> drain([E? futureValue])</code> |  |
| **elementAt** | <code>method</code> | <code>dart Future<T> elementAt(int index)</code> |  |
| **every** | <code>method</code> | <code>dart Future<bool> every(bool Function(T element) test)</code> |  |
| **expand** | <code>method</code> | <code>dart Stream<S> expand(Iterable<S> Function(T element) convert)</code> |  |
| **first** | <code>method</code> | <code>dart Future<T> first</code> |  |
| **firstWhere** | <code>method</code> | <code>dart Future<T> firstWhere(bool Function(T element) test, {T Function()? orElse})</code> |  |
| **fold** | <code>method</code> | <code>dart Future<S> fold(S initialValue, S Function(S previous, T element) combine)</code> |  |
| **forEach** | <code>method</code> | <code>dart Future<void> forEach(void Function(T element) action)</code> |  |
| **handleError** | <code>method</code> | <code>dart Stream<T> handleError(Function onError, {bool Function(dynamic error)? test})</code> |  |
| **isBroadcast** | <code>method</code> | <code>dart bool isBroadcast</code> |  |
| **isEmpty** | <code>method</code> | <code>dart Future<bool> isEmpty</code> |  |
| **join** | <code>method</code> | <code>dart Future<String> join([String separator = ""])</code> |  |
| **last** | <code>method</code> | <code>dart Future<T> last</code> |  |
| **lastWhere** | <code>method</code> | <code>dart Future<T> lastWhere(bool Function(T element) test, {T Function()? orElse})</code> |  |
| **length** | <code>method</code> | <code>dart Future<int> length</code> |  |
| **listen** | <code>method</code> | <code>dart StreamSubscription<T> listen(void Function(T event)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError})</code> |  |
| **map** | <code>method</code> | <code>dart Stream<S> map(S Function(T event) convert)</code> |  |
| **pipe** | <code>method</code> | <code>dart Future pipe(StreamConsumer<T> streamConsumer)</code> |  |
| **reduce** | <code>method</code> | <code>dart Future<T> reduce(T Function(T previous, T element) combine)</code> |  |
| **single** | <code>method</code> | <code>dart Future<T> single</code> |  |
| **singleWhere** | <code>method</code> | <code>dart Future<T> singleWhere(bool Function(T element) test, {T Function()? orElse})</code> |  |
| **skip** | <code>method</code> | <code>dart Stream<T> skip(int count)</code> |  |
| **skipWhile** | <code>method</code> | <code>dart Stream<T> skipWhile(bool Function(T element) test)</code> |  |
| **take** | <code>method</code> | <code>dart Stream<T> take(int count)</code> |  |
| **takeWhile** | <code>method</code> | <code>dart Stream<T> takeWhile(bool Function(T element) test)</code> |  |
| **timeout** | <code>method</code> | <code>dart Stream<T> timeout(Duration timeLimit, {void Function(EventSink<T> sink)? onTimeout})</code> |  |
| **toList** | <code>method</code> | <code>dart Future<List<T>> toList()</code> |  |
| **toSet** | <code>method</code> | <code>dart Future<Set<T>> toSet()</code> |  |
| **transform** | <code>method</code> | <code>dart Stream<S> transform(StreamTransformer<T, S> streamTransformer)</code> |  |
| **where** | <code>method</code> | <code>dart Stream<T> where(bool Function(T event) test)</code> |  |

## References

The **StreamSignalMixin** type is referenced and used in the following pages:

* [ValueNotifier](/guides/value-notifier) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [StreamSignalMixin](/packages/signals_flutter/mixins/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [signals_flutter](/packages/signals_flutter)
* [StreamSignalMixin](/packages/signals_core/mixins/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [signals_core](/packages/signals_core)
* [StreamSignalMixin](/packages/signals/mixins/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [signals](/packages/signals)
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

