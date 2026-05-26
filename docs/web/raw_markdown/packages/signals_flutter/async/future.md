---
title: Future
description: Future signals can be created by extension or method.
---

## futureSignal

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


---

## FutureSignal

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


### Constructors

##### <a name="futuresignal"></a><a name="futuresignal"></a>`FutureSignal(Future<T> Function() fn, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead') List<ReadonlySignal<dynamic>>? dependencies, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})`

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


### Properties

##### <a name="dependencies"></a>`List<ReadonlySignal<dynamic>> dependencies`

List of dependencies to recompute the future


### Methods

##### <a name="dispose"></a>`void dispose()`

##### <a name="reset"></a>`void reset([AsyncState<T>? value])`

##### <a name="init"></a>`void init()`

##### <a name="value"></a>`AsyncState<T> value`

##### <a name="reload"></a>`Future<void> reload()`

##### <a name="refresh"></a>`Future<void> refresh()`
