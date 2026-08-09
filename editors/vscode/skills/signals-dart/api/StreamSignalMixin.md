# class `StreamSignalMixin`

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

---

## Members of `StreamSignalMixin`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **any** | `method` | `Future<bool> any(bool Function(T element) test)` |  |
| **asBroadcastStream** | `method` | `Stream<T> asBroadcastStream({void Function(StreamSubscription<T> subscription)? onListen, void Function(StreamSubscription<T> subscription)? onCancel})` |  |
| **asyncExpand** | `method` | `Stream<E> asyncExpand(Stream<E>? Function(T event) convert)` |  |
| **asyncMap** | `method` | `Stream<E> asyncMap(FutureOr<E> Function(T event) convert)` |  |
| **cast** | `method` | `Stream<R> cast()` |  |
| **contains** | `method` | `Future<bool> contains(Object? needle)` |  |
| **distinct** | `method` | `Stream<T> distinct([bool Function(T previous, T next)? equals])` |  |
| **drain** | `method` | `Future<E> drain([E? futureValue])` |  |
| **elementAt** | `method` | `Future<T> elementAt(int index)` |  |
| **every** | `method` | `Future<bool> every(bool Function(T element) test)` |  |
| **expand** | `method` | `Stream<S> expand(Iterable<S> Function(T element) convert)` |  |
| **first** | `method` | `Future<T> first` |  |
| **firstWhere** | `method` | `Future<T> firstWhere(bool Function(T element) test, {T Function()? orElse})` |  |
| **fold** | `method` | `Future<S> fold(S initialValue, S Function(S previous, T element) combine)` |  |
| **forEach** | `method` | `Future<void> forEach(void Function(T element) action)` |  |
| **handleError** | `method` | `Stream<T> handleError(Function onError, {bool Function(dynamic error)? test})` |  |
| **isBroadcast** | `method` | `bool isBroadcast` |  |
| **isEmpty** | `method` | `Future<bool> isEmpty` |  |
| **join** | `method` | `Future<String> join([String separator = ""])` |  |
| **last** | `method` | `Future<T> last` |  |
| **lastWhere** | `method` | `Future<T> lastWhere(bool Function(T element) test, {T Function()? orElse})` |  |
| **length** | `method` | `Future<int> length` |  |
| **listen** | `method` | `StreamSubscription<T> listen(void Function(T event)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError})` |  |
| **map** | `method` | `Stream<S> map(S Function(T event) convert)` |  |
| **pipe** | `method` | `Future pipe(StreamConsumer<T> streamConsumer)` |  |
| **reduce** | `method` | `Future<T> reduce(T Function(T previous, T element) combine)` |  |
| **single** | `method` | `Future<T> single` |  |
| **singleWhere** | `method` | `Future<T> singleWhere(bool Function(T element) test, {T Function()? orElse})` |  |
| **skip** | `method` | `Stream<T> skip(int count)` |  |
| **skipWhile** | `method` | `Stream<T> skipWhile(bool Function(T element) test)` |  |
| **take** | `method` | `Stream<T> take(int count)` |  |
| **takeWhile** | `method` | `Stream<T> takeWhile(bool Function(T element) test)` |  |
| **timeout** | `method` | `Stream<T> timeout(Duration timeLimit, {void Function(EventSink<T> sink)? onTimeout})` |  |
| **toList** | `method` | `Future<List<T>> toList()` |  |
| **toSet** | `method` | `Future<Set<T>> toSet()` |  |
| **transform** | `method` | `Stream<S> transform(StreamTransformer<T, S> streamTransformer)` |  |
| **where** | `method` | `Stream<T> where(bool Function(T event) test)` |  |
