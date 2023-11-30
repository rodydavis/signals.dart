---
title: Future Signal
description: Creates a signal that contains a future
---

Future signals can be created by extension or method.

### futureSignal

```dart
final s = futureSignal(Future(() => 1));
```

### toSignal()

```dart
final s = Future(() => 1).toSignal();
```

## .result

The `result` getter returns the result of the future and error if present.

```dart
final s = futureSignal(Future(() => 1));
final (val, err) = await s.result;
if (err != null) {
    // handle error
} else {
    // handle value
}
```

## .isSuccess

The `isSuccess` getter returns true if the future completed successfully.

```dart
final s = futureSignal(Future(() => 1));
final success = s.isSuccess; // true
```

## .isError

The `isError` getter returns true if the future completed with an error.

```dart
final s = futureSignal(Future.error('error'));
final error = s.isError; // true
```

## .isLoading

The `isLoading` getter returns true if the future has not completed.

```dart
final s = futureSignal(Future(() => 1));
final loading = s.isLoading; // true
```

## .isTimeout

The `isTimeout` getter returns true if the future timed out with the optional timeout parameter.

```dart
final s = futureSignal(Future(() => 1), timeout: Duration(seconds: 1));
final timeout = s.isTimeout; // true
```

## .value

The `value` getter returns the value of the future if it completed successfully.

```dart
final s = futureSignal(Future(() => 1));
if (s.isSuccess) {
    final value = s.value; // 1
}
```

## .error

The `error` getter returns the error of the future if it completed with an error.

```dart
final s = futureSignal(Future.error('error'));
if (s.isError) {
    final error = s.error; // 'error'
}
```

## .peek()

The `peek` method returns the value of the future if it completed successfully.

```dart
final s = futureSignal(Future(() => 1));
final value = s.peek(); // 1
```

## .reset()

The `reset` method resets the future to its initial state to recall on the next evaluation.

```dart
final s = futureSignal(Future(() => 1));
s.reset();
```

## .map(...)

The `map` method is a convenience method to map the states of the future to a signal.

```dart
final s = futureSignal(Future(() => 1));
final mapped = s.map(
    value: (value) => 'value: $value',
    error: (error) => 'error: $error',
    loading: () => 'loading',
    timeout: () => 'timeout',
);
```

## .maybeMap(...)

The `maybeMap` method is a convenience method to map the states of the future to a signal.

```dart
final s = futureSignal(Future(() => 1));
final mapped = s.maybeMap(
    value: (value) => 'value: $value',
    orElse: () => 'loading',
);
```