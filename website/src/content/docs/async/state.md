---
title: AsyncState
description: Async states for a signal value
---

`AsyncState` is class commonly used with Future/Stream signals to represent the states the signal can be in.

## AsyncSignal

`AsyncState` is the default state if you want to create a `AsyncSignal` directly:

```dart
final s = asyncSignal(AsyncState.data(1));
s.value = AsyncState.loading(); // or AsyncLoading();
s.value = AsyncState.error('Error', null); // or AsyncError();
```

## AsyncState

`AsyncState` is a sealed union made up of `AsyncLoading`, `AsyncData` and `AsyncError`.

### .future

Sometimes you need to await a signal value in a async function until a value is completed and in this case use the .future getter.

```dart
final s = asyncSignal<int>(AsyncState.loading());
s.value = AsyncState.data(1);
await s.future; // Waits until data or error is set
```

### .isCompleted

Returns true if the future has completed with an error or value:

```dart
final s = asyncSignal<int>(AsyncState.loading());
s.value = AsyncState.data(1);
print(s.isCompleted); // true
```

### .hasValue

Returns true if a value has been set regardless of the state.

```dart
final s = asyncSignal<int>(AsyncState.loading());
print(s.hasValue); // false
s.value = AsyncState.data(1);
print(s.hasValue); // true
```

### .hasError

Returns true if a error has been set regardless of the state.

```dart
final s = asyncSignal<int>(AsyncState.loading());
print(s.hasError); // false
s.value = AsyncState.error('error', null);
print(s.hasError); // true
```

### .isRefreshing

Returns true if the state is refreshing with a loading flag, has a value or error and is not the loading state.

```dart
final s = asyncSignal<int>(AsyncState.loading());
print(s.isRefreshing); // false
s.value = AsyncState.error('error', null, isLoading: true);
print(s.isRefreshing); // true
s.value = AsyncData(1, isLoading: true);
print(s.isRefreshing); // true
```

### .isReloading

Returns true if the state is reloading with having a value or error, and is the loading state.

```dart
final s = asyncSignal<int>(AsyncState.loading());
print(s.isReloading); // false
s.value = AsyncState.loading(data: 1);
print(s.isReloading); // true
s.value = AsyncState.loading(error: ('error', null));
print(s.isReloading); // true
```

### .requireValue

Force unwrap the value of the state and throw an error if it has an error or is null.

```dart
final s = asyncSignal<int>(AsyncState.data(1));
print(s.requireValue); // 1
```

### .value

Return the current value if exists.

```dart
final s = asyncSignal<int>(AsyncState.data(1));
print(s.value); // 1 or null
```

### .error

Return the current error if exists.

```dart
final s = asyncSignal<int>(AsyncState.error('error', null));
print(s.error); // 'error' or null
```

### .stackTrace

Return the current stack trace if exists.

```dart
final s = asyncSignal<int>(AsyncState.error('error', StackTrace(...)));
print(s.stackTrace); // StackTrace(...) or null
```

### .map

If you want to handle the states of the signal `map` will enforce all branching.

```dart
final signal = asyncSignal<int>(AsyncState.data(1));
signal.value.map(
 data: (value) => 'Value: $value',
 error: (error, stackTrace) => 'Error: $error',
 loading: () => 'Loading...',
);
```

### .maybeMap

If you want to handle some of the states of the signal `maybeMap` will provide a default and optional overrides.

```dart
final signal = asyncSignal<int>(AsyncState.data(1));
signal.value.maybeMap(
 data: (value) => 'Value: $value',
 orElse: () => 'Loading...',
);
```

### Pattern Matching

Instead of `map` and `maybeMap` it is also possible to use [dart switch expressions](https://dart.dev/language/patterns) to handle the branching.

```dart
final signal = asyncSignal<int>(AsyncState.data(1));
final value = switch (signal.value) {
    AsyncData<int> data => 'value: ${data.value}',
    AsyncError<int> error => 'error: ${error.error}',
    AsyncLoading<int>() => 'loading',
};
```
