---
title: "Type: FutureSignal"
description: "API reference and details for FutureSignal from signals.dart."
---

# FutureSignal

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: FutureSignal

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

### Members of FutureSignal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **FutureSignal** | <code>constructor</code> | <code>dart FutureSignal(Future<T> Function() fn, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead') List<ReadonlySignal<dynamic>>? dependencies, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})</code> | Future signals can be created by extension or method. |
| **dependencies** | <code>field</code> | <code>dart List<ReadonlySignal<dynamic>> dependencies</code> | List of dependencies to recompute the future |
| **dispose** | <code>method</code> | <code>dart void dispose()</code> |  |
| **reset** | <code>method</code> | <code>dart void reset([AsyncState<T>? value])</code> |  |
| **init** | <code>method</code> | <code>dart void init()</code> |  |
| **value** | <code>method</code> | <code>dart AsyncState<T> value</code> |  |
| **reload** | <code>method</code> | <code>dart Future<void> reload()</code> |  |
| **refresh** | <code>method</code> | <code>dart Future<void> refresh()</code> |  |

## Function: futureSignal

```dart
FutureSignal<T> futureSignal(Future<T> Function() fn, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead') List<ReadonlySignal<dynamic>>? dependencies, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})
```

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

## References

The **FutureSignal** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [FutureSignal](/packages/signals_flutter/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [AsyncSignal](/packages/signals_flutter/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Computed](/packages/signals_flutter/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [SignalContainer](/packages/signals_flutter/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [signals_flutter](/packages/signals_flutter)
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [FutureSignal](/packages/signals_core/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [AsyncSignal](/packages/signals_core/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [Computed](/packages/signals_core/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [SignalContainer](/packages/signals_core/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [signals_core](/packages/signals_core)
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [FutureSignal](/packages/signals/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [AsyncSignal](/packages/signals/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [Computed](/packages/signals/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [SignalContainer](/packages/signals/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals](/packages/signals)
* [useFutureSignal](/packages/signals_hooks/hooks/use-future-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useAsyncComputed](/packages/signals_hooks/hooks/use-async-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [AI Integration](/reference/ai) <span style="opacity: 0.6; font-size: 0.85em;">(reference)</span>

