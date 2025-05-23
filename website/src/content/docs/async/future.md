---
title: FutureSignal
description: Creates a signal that contains a future
sidebar:
  order: 1
---

Future signals can be created by extension or method.

### futureSignal

```dart
final s = futureSignal(() async => 1);
```

### toSignal()

```dart
final s = Future(() => 1).toSignal();
```

## .value, .peek()

Returns [`AsyncState<T>`](/dart/async/state) for the value and can handle the various states.

The `value` getter returns the value of the future if it completed successfully.

> .peek() can also be used to not subscribe in an effect

```dart
final s = futureSignal(() => Future(() => 1));
final value = s.value.value; // 1 or null
```

## .reset()

The `reset` method resets the future to its initial state to recall on the next evaluation.

```dart
final s = futureSignal(() => Future(() => 1));
s.reset();
```

## .refresh()

Refresh the future value by setting `isLoading` to true, but maintain the current state (AsyncData, AsyncLoading, AsyncError).

```dart
final s = futureSignal(() => Future(() => 1));
s.refresh();
print(s.value.isLoading); // true
```

## .reload()

Reload the future value by setting the state to `AsyncLoading` and pass in the value or error as data.

```dart
final s = futureSignal(() => Future(() => 1));
s.reload();
print(s.value is AsyncLoading); // true
```

## Dependencies

By default the callback will be called once and the future will be cached unless a signal is read in the callback.

```dart
final count = signal(0);
final s = futureSignal(() async => count.value);

await s.future; // 0
count.value = 1;
await s.future; // 1
```

If there are signals that need to be tracked across an async gap then use the `dependencies` when creating the `futureSignal` to [`reset`](#.reset()) every time any signal in the dependency array changes.

```dart
final count = signal(0);
final s = futureSignal(
    () async => count.value,
    dependencies: [count],
);
s.value; // state with count 0
count.value = 1; // resets the future
s.value; // state with count 1
```
