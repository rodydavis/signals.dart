---
title: StreamSignal
description: Creates a signal that contains a stream
---

Stream signals can be created by extension or method.

### streamSignal

```dart
final stream = () async* {
    yield 1;
};
final s = streamSignal(stream);
```

### toSignal()

```dart
final stream = () async* {
    yield 1;
};
final s = stream.toSignal();
```

## .value, .peek()

Returns [`AsyncState<T>`](/signals.dart/dart/async/state) for the value and can handle the various states.

The `value` getter returns the value of the stream if it completed successfully.

> .peek() can also be used to not subscribe in an effect

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(stream);
final value = s.value.value; // 1 or null
```

## .reset()

The `reset` method resets the stream to its initial state to recall on the next evaluation.

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(stream);
s.reset();
```

## .addStream

If you want to listen to multiple streams and have a single value then call addStream.

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(stream(0));
s.addStream(stream(1));
```

## .resetStream

If you need to change the stream you can call `resetStream` to reset and provide a new Stream callback.

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(stream(0));
s.resetStream(stream(1));
```
