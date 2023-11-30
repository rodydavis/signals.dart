---
title: Stream Signal
description: Creates a signal that contains a stream
---

Stream signals can be created by extension or method.

### streamSignal

```dart
final stream = () async* {...};
final s = streamSignal(stream);
```

### toSignal()

```dart
final stream = () async* {...};
final s = stream.toSignal();
```

## Signal to Stream

```dart
final s = Signal(10);
final stream = s.toStream();
```

## .isSuccess

The `isSuccess` getter returns true if the stream completed successfully.

```dart
final s = streamSignal(() async* {
    yield 1;
    yield 2;
    yield 3;
});
final success = s.isSuccess; // true
```

## .isError

The `isError` getter returns true if the stream completed with an error.

```dart
final s = streamSignal(() async* {
    yield 1;
    yield 2;
    yield 3;
    throw 'error';
});
final error = s.isError; // true
```

## .isLoading

The `isLoading` getter returns true if the stream has not completed.

```dart
final s = streamSignal(() async* {
    yield 1;
    yield 2;
    yield 3;
});
final loading = s.isLoading; // true
```

## .value

The `value` getter returns the last value emitted by the stream.

```dart
final s = streamSignal(() async* {
    yield 1;
    yield 2;
    yield 3;
});
final value = s.value; // 3
```

## .error

The `error` getter returns the last error emitted by the stream.

```dart
final s = streamSignal(() async* {
    yield 1;
    yield 2;
    yield 3;
    throw 'error';
});
final error = s.error; // 'error'
```

## .peek()

The `peek` method returns the last value emitted by the stream without subscribing to it.

```dart
final s = streamSignal(() async* {
    yield 1;
    yield 2;
    yield 3;
});
final value = s.peek(); // 3
```

## .reset()

The `reset` method resets the stream to its initial state to recall on the next evaluation.

```dart
final s = streamSignal(() async* {
    yield 1;
    yield 2;
    yield 3;
});
s.reset();
```

## .map(...)

The `map` method is a convenience method to map the states of the stream to a signal.

```dart
final s = streamSignal(() async* {
    yield 1;
    yield 2;
    yield 3;
});
final mapped = s.map(
    value: (value) => 'value: $value',
    error: (error) => 'error: $error',
    loading: () => 'loading',
);
```

## .maybeMap(...)

The `maybeMap` method is a convenience method to map the states of the stream to a signal.

```dart
final s = streamSignal(() async* {
    yield 1;
    yield 2;
    yield 3;
});
final mapped = s.maybeMap(
    value: (value) => 'value: $value',
    orElse: () => 'loading',
);
```
