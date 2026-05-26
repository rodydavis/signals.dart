---
title: StreamSignalMixin
description: A mixin that implements the standard **Stream** interface for a ReadonlySignal.
---

A mixin that implements the standard **Stream** interface for a [ReadonlySignal](/packages/preact_signals/core/readonly).

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
Since [StreamSignalMixin](/packages/signals/mixins/stream) creates an internal broadcast **StreamController**, multiple listeners
can subscribe simultaneously. All subscriptions are closed and resources are released
automatically when the signal is disposed.
</Success>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="any"></a>`Future<bool> any(bool Function(T element) test)`

##### <a name="asbroadcaststream"></a>`Stream<T> asBroadcastStream({void Function(StreamSubscription<T> subscription)? onListen, void Function(StreamSubscription<T> subscription)? onCancel})`

##### <a name="asyncexpand"></a>`Stream<E> asyncExpand(Stream<E>? Function(T event) convert)`

##### <a name="asyncmap"></a>`Stream<E> asyncMap(FutureOr<E> Function(T event) convert)`

##### <a name="cast"></a>`Stream<R> cast()`

##### <a name="contains"></a>`Future<bool> contains(Object? needle)`

##### <a name="distinct"></a>`Stream<T> distinct([bool Function(T previous, T next)? equals])`

##### <a name="drain"></a>`Future<E> drain([E? futureValue])`

##### <a name="elementat"></a>`Future<T> elementAt(int index)`

##### <a name="every"></a>`Future<bool> every(bool Function(T element) test)`

##### <a name="expand"></a>`Stream<S> expand(Iterable<S> Function(T element) convert)`

##### <a name="first"></a>`Future<T> first`

##### <a name="firstwhere"></a>`Future<T> firstWhere(bool Function(T element) test, {T Function()? orElse})`

##### <a name="fold"></a>`Future<S> fold(S initialValue, S Function(S previous, T element) combine)`

##### <a name="foreach"></a>`Future<void> forEach(void Function(T element) action)`

##### <a name="handleerror"></a>`Stream<T> handleError(Function onError, {bool Function(dynamic error)? test})`

##### <a name="isbroadcast"></a>`bool isBroadcast`

##### <a name="isempty"></a>`Future<bool> isEmpty`

##### <a name="join"></a>`Future<String> join([String separator = ""])`

##### <a name="last"></a>`Future<T> last`

##### <a name="lastwhere"></a>`Future<T> lastWhere(bool Function(T element) test, {T Function()? orElse})`

##### <a name="length"></a>`Future<int> length`

##### <a name="listen"></a>`StreamSubscription<T> listen(void Function(T event)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError})`

##### <a name="map"></a>`Stream<S> map(S Function(T event) convert)`

##### <a name="pipe"></a>`Future pipe(StreamConsumer<T> streamConsumer)`

##### <a name="reduce"></a>`Future<T> reduce(T Function(T previous, T element) combine)`

##### <a name="single"></a>`Future<T> single`

##### <a name="singlewhere"></a>`Future<T> singleWhere(bool Function(T element) test, {T Function()? orElse})`

##### <a name="skip"></a>`Stream<T> skip(int count)`

##### <a name="skipwhile"></a>`Stream<T> skipWhile(bool Function(T element) test)`

##### <a name="take"></a>`Stream<T> take(int count)`

##### <a name="takewhile"></a>`Stream<T> takeWhile(bool Function(T element) test)`

##### <a name="timeout"></a>`Stream<T> timeout(Duration timeLimit, {void Function(EventSink<T> sink)? onTimeout})`

##### <a name="tolist"></a>`Future<List<T>> toList()`

##### <a name="toset"></a>`Future<Set<T>> toSet()`

##### <a name="transform"></a>`Stream<S> transform(StreamTransformer<T, S> streamTransformer)`

##### <a name="where"></a>`Stream<T> where(bool Function(T event) test)`

</details>
