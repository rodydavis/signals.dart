---
title: FutureSignal
description: Future signals wrap a standard asynchronous Future and bridge it into the reactive state framework, exposing its lifecycle and value as a reactive ...
---

Future signals wrap a standard asynchronous **Future** and bridge it into the reactive state framework, exposing its lifecycle and value as a reactive [AsyncState](/types/asyncstate).

You can construct a future signal via the helper function [futureSignal](/types/futuresignal) or by calling the <code>.toSignal()</code> extension method on any standard **Future**.

### 1. Basic Async Fetching
```dart
final s = futureSignal(() async {
  final data = await fetchUserData(123);
  return data;
});
```

Or via the extension:
```dart
final s = fetchUserData(123).toSignal();
```

### 2. Consuming and Pattern Matching <code>AsyncState</code>
Reading <code>.value</code> on a [FutureSignal](/types/futuresignal) returns an [AsyncState](/types/asyncstate) object. You can safely pattern-match or map this state to reactively build your user interface or perform side-effects:

```dart
effect(() {
  s.value.map(
    data: (user) => print('User fetched successfully: ${user.name}'),
    error: (err, stack) => print('Failed to fetch user: $err'),
    loading: () => print('Loading user...'),
  );
});
```

### 3. Reset, Refresh, and Reload
- **<code>reset()</code>**: Reverts the signal back to its initial/loading state.
- **<code>refresh()</code>**: Triggers a new evaluation of the future while maintaining the current data in the meantime (sets <code>isLoading</code> to true but does not discard existing data/error).
- **<code>reload()</code>**: Discards current state, sets the signal to <code>AsyncLoading</code>, and executes a fresh evaluation of the future.

```dart
final s = futureSignal(() => fetchConfig());
s.refresh(); // Triggers reload under the hood
```

### 4. Reactive Dependencies
Any reactive signals read *synchronously* inside the future callback are registered as dependencies. When they mutate, the future signal automatically invalidates and schedules a fresh fetch.

```dart
final userId = signal(123);
final userProfile = futureSignal(() async {
  // Subscribes to userId! Mutating userId automatically re-runs this future.
  final currentId = userId.value;
  return fetchUserProfile(currentId);
});
```

<Info>
  If you need to track dependencies across an asynchronous gap (i.e. reading a signal's value <em>after</em> an <code>await</code>), pass them explicitly in the <code>dependencies</code> list inside <code>AsyncSignalOptions</code> or the constructor to guarantee they are properly subscribed.
</Info>


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="futuresignal"></a><a name="futuresignal"></a><code>FutureSignal(Future<T> Function() fn, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead') List<ReadonlySignal<dynamic>>? dependencies, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})</code>

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

Returns [<code>AsyncState<T></code>](/dart/async/state) for the value and can handle the various states.

The <code>value</code> getter returns the value of the future if it completed successfully.

> .peek() can also be used to not subscribe in an effect

```dart
final s = futureSignal(() => Future(() => 1));
final value = s.value.value; // 1 or null
```

## .reset()

The <code>reset</code> method resets the future to its initial state to recall on the next evaluation.

```dart
final s = futureSignal(() => Future(() => 1));
s.reset();
```

## .refresh()

Refresh the future value by setting <code>isLoading</code> to true, but maintain the current state (AsyncData, AsyncLoading, AsyncError).

```dart
final s = futureSignal(() => Future(() => 1));
s.refresh();
print(s.value.isLoading); // true
```

## .reload()

Reload the future value by setting the state to <code>AsyncLoading</code> and pass in the value or error as data.

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

If there are signals that need to be tracked across an async gap then use the <code>dependencies</code> when creating the <code>futureSignal</code> to [<code>reset</code>](#.reset()) every time any signal in the dependency array changes.

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

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="dependencies"></a><code>List<ReadonlySignal<dynamic>> dependencies</code>

List of dependencies to recompute the future

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="dispose"></a><code>void dispose()</code>

##### <a name="reset"></a><code>void reset([AsyncState<T>? value])</code>

##### <a name="init"></a><code>void init()</code>

##### <a name="value"></a><code>AsyncState<T> value</code>

##### <a name="reload"></a><code>Future<void> reload()</code>

##### <a name="refresh"></a><code>Future<void> refresh()</code>

</details>



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

Returns [<code>AsyncState<T></code>](/dart/async/state) for the value and can handle the various states.

The <code>value</code> getter returns the value of the future if it completed successfully.

> .peek() can also be used to not subscribe in an effect

```dart
final s = futureSignal(() => Future(() => 1));
final value = s.value.value; // 1 or null
```

## .reset()

The <code>reset</code> method resets the future to its initial state to recall on the next evaluation.

```dart
final s = futureSignal(() => Future(() => 1));
s.reset();
```

## .refresh()

Refresh the future value by setting <code>isLoading</code> to true, but maintain the current state (AsyncData, AsyncLoading, AsyncError).

```dart
final s = futureSignal(() => Future(() => 1));
s.refresh();
print(s.value.isLoading); // true
```

## .reload()

Reload the future value by setting the state to <code>AsyncLoading</code> and pass in the value or error as data.

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

If there are signals that need to be tracked across an async gap then use the <code>dependencies</code> when creating the <code>futureSignal</code> to [<code>reset</code>](#.reset()) every time any signal in the dependency array changes.

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
