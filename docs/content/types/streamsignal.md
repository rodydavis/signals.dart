---
title: "Type: StreamSignal"
description: "API reference and details for StreamSignal from signals.dart."
---

# StreamSignal

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: StreamSignal

Stream signals wrap a standard asynchronous **Stream** and bridge it into the reactive state framework, exposing its emissions as a reactive [AsyncState](/types/asyncstate).

You can construct a stream signal via the helper function [streamSignal](/types/streamsignal) or by calling the <code>.toSignal()</code> extension method on any standard **Stream**.

### 1. Basic Stream Binding
```dart
final s = streamSignal(() => countStream());
```

Or via the extension:
```dart
final s = countStream().toSignal();
```

### 2. Consuming stream emissions reactively
Reading <code>.value</code> on a [StreamSignal](/types/streamsignal) returns an [AsyncState](/types/asyncstate) object:

```dart
effect(() {
  s.value.map(
    data: (val) => print('Stream emitted: $val'),
    error: (err, stack) => print('Stream encountered error: $err'),
    loading: () => print('Waiting for first stream emission...'),
  );
});
```

### 3. Subscription Lifecycle and Manual Control
A stream signal automatically manages the underlying **StreamSubscription**. It listens when the signal has active subscribers and automatically cleans up/cancels when disposed to prevent memory leaks.

You can also manually control the subscription state:
- **<code>pause()</code>**: Pauses the underlying stream subscription.
- **<code>resume()</code>**: Resumes a paused subscription.
- **<code>cancel()</code>**: Cancels the subscription and marks the stream signal as done.
- **<code>isDone</code>**: Returns whether the stream has finished emitting or has been cancelled.

```dart
final s = streamSignal(() => countStream());
s.pause(); // Temporarily halt stream values
```

### 4. Reactive Dependencies
Any reactive signals read synchronously inside the stream callback act as dependencies. When they mutate, the stream signal automatically cancels the current stream subscription, recreates a new stream using the updated values, and starts listening.

```dart
final query = signal('flutter');
final s = streamSignal(() {
  // Re-subscribes to a new database query stream every time the query changes!
  return db.watchItems(query.value);
});
```

### Members of StreamSignal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **StreamSignal** | <code>constructor</code> | <code>dart StreamSignal(Stream<T> Function() fn, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(cancelOnError: ...) instead') bool? cancelOnError, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead') List<ReadonlySignal<dynamic>>? dependencies, @Deprecated('Use options: AsyncSignalOptions(onDone: ...) instead') void Function()? onDone, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})</code> | Stream signals can be created by extension or method. |
| **isDone** | <code>method</code> | <code>dart bool isDone</code> | Check if the signal is done |
| **cancelOnError** | <code>field</code> | <code>dart bool? cancelOnError</code> | Cancel the subscription on error |
| **dependencies** | <code>field</code> | <code>dart List<ReadonlySignal<dynamic>> dependencies</code> | List of dependencies to recompute the stream |
| **last** | <code>method</code> | <code>dart Future<T> last</code> | First value of the stream |
| **first** | <code>method</code> | <code>dart Future<T> first</code> | Last value of the stream |
| **execute** | <code>method</code> | <code>dart Future<void> execute(Stream<T> src)</code> | Execute the stream |
| **isPaused** | <code>method</code> | <code>dart bool isPaused</code> | Check if the subscription is paused |
| **pause** | <code>method</code> | <code>dart void pause([Future<void>? resume])</code> | Pause the subscription |
| **resume** | <code>method</code> | <code>dart void resume()</code> | Resume the subscription |
| **cancel** | <code>method</code> | <code>dart Future<void> cancel()</code> | Cancel the subscription |
| **reload** | <code>method</code> | <code>dart Future<void> reload()</code> |  |
| **refresh** | <code>method</code> | <code>dart Future<void> refresh()</code> |  |
| **reset** | <code>method</code> | <code>dart void reset([AsyncState<T>? value])</code> |  |
| **dispose** | <code>method</code> | <code>dart void dispose()</code> |  |
| **value** | <code>method</code> | <code>dart AsyncState<T> value</code> |  |
| **setError** | <code>method</code> | <code>dart void setError(Object error, [StackTrace? stackTrace])</code> |  |

## Function: streamSignal

```dart
StreamSignal<T> streamSignal(Stream<T> Function() callback, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(initialValue: ...) instead') T? initialValue, @Deprecated('Use options: AsyncSignalOptions(dependencies: ...) instead') List<ReadonlySignal<dynamic>>? dependencies, @Deprecated('Use options: AsyncSignalOptions(onDone: ...) instead') void Function()? onDone, @Deprecated('Use options: AsyncSignalOptions(cancelOnError: ...) instead') bool? cancelOnError, @Deprecated('Use options: AsyncSignalOptions(lazy: ...) instead') bool? lazy, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})
```

Stream signals can be created by extension or method.

### streamSignal

```dart
final stream = () async* {
    yield 1;
};
final s = streamSignal(() => stream);
```

### toSignal()

```dart
final stream = () async* {
    yield 1;
};
final s = stream.toSignal();
```

## .value, .peek()

Returns [<code>AsyncState<T></code>](/dart/async/state) for the value and can handle the various states.

The <code>value</code> getter returns the value of the stream if it completed successfully.

> .peek() can also be used to not subscribe in an effect

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
final value = s.value.value; // 1 or null
```

## .reset()

The <code>reset</code> method resets the stream to its initial state to recall on the next evaluation.

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
s.reset();
```

## .refresh()

Refresh the stream value by setting <code>isLoading</code> to true, but maintain the current state (AsyncData, AsyncLoading, AsyncError).

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
s.refresh();
print(s.value.isLoading); // true
```

## .reload()

Reload the stream value by setting the state to <code>AsyncLoading</code> and pass in the value or error as data.

```dart
final stream = (int value) async* {
    yield value;
};
final s = streamSignal(() => stream);
s.reload();
print(s.value is AsyncLoading); // true
```

## Dependencies

By default the callback will be called once and the stream will be cached unless a signal is read in the callback.

```dart
final count = signal(0);
final s = streamSignal(() async* {
    final value = count();
    yield value;
});

await s.future; // 0
count.value = 1;
await s.future; // 1
```

If there are signals that need to be tracked across an async gap then use the <code>dependencies</code> when creating the <code>streamSignal</code> to [<code>reset</code>](#.reset()) every time any signal in the dependency array changes.

```dart
final count = signal(0);
final s = streamSignal(
    () async* {
        final value = count();
        yield value;
    },
    dependencies: [count],
);
s.value; // state with count 0
count.value = 1; // resets the future
s.value; // state with count 1
```

## References

The **StreamSignal** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [AsyncState](/packages/signals_flutter/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [AsyncSignal](/packages/signals_flutter/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Stream](/packages/signals_flutter/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [SignalContainer](/packages/signals_flutter/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [AsyncState](/packages/signals_core/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [AsyncSignal](/packages/signals_core/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [Stream](/packages/signals_core/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [SignalContainer](/packages/signals_core/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [signals_core](/packages/signals_core)
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [AsyncState](/packages/signals/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [AsyncSignal](/packages/signals/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [Stream](/packages/signals/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [SignalContainer](/packages/signals/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [useStreamSignal](/packages/signals_hooks/hooks/use-stream-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-hooks AI Skill](/skills/signals-hooks) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-migration-6-to-7 AI Skill](/skills/signals-migration-6-to-7) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [AI Integration](/reference/ai) <span style="opacity: 0.6; font-size: 0.85em;">(reference)</span>

