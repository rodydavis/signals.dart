---
title: "Type: MutationSignal"
description: "API reference and details for MutationSignal from signals.dart."
---

# MutationSignal

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: MutationSignal

A [Signal](/types/signal) for imperative, on-demand asynchronous side effects (mutations).

Where [futureSignal](/types/futuresignal) models *reading* data that begins loading immediately,
a <code>MutationSignal</code> models *writing* data triggered by a user action (saving
a form, calling a <code>POST</code>/<code>PUT</code>/<code>DELETE</code>, etc). It therefore starts in an
extra [MutationIdle](/types/mutationidle) state ("not run yet") on top of the standard
pending/success/error lifecycle exposed by [MutationState](/types/mutationstate).

The mutation function is supplied once at creation and receives a single
typed argument <code>A</code>. Use a Dart record for multiple arguments, or <code>void</code>/a
unit type when none are needed.

```dart
final addTodo = mutationSignal<Todo, void>((todo) async {
  await api.add(todo);
});

// Fire-and-forget (drive the UI from state):
addTodo.mutate(myTodo);

// Or await the result directly:
await addTodo.mutateAsync(myTodo);

// Reset back to idle:
addTodo.reset();
```

Rendering with pattern matching:
```dart
final widget = addTodo.value.map(
  idle: () => const Text('Ready'),
  pending: () => const CircularProgressIndicator(),
  data: (_) => const Text('Saved!'),
  error: (err, _) => Text('Failed: $err'),
);
```

### Race protection
If **mutate**/**mutateAsync** is called again before a previous run finishes,
only the **latest** invocation is allowed to update the signal state. Stale
invocations still resolve their own returned future, but they will not
overwrite a newer result.

### Members of MutationSignal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **MutationSignal** | <code>constructor</code> | <code>dart MutationSignal(this._mutator, {SignalOptions<MutationState<T>>? options})</code> | Create a [MutationSignal](/types/mutationsignal) from an async mutation function. |
| **variables** | <code>method</code> | <code>dart A? variables</code> | The argument passed to the most recent **mutate**/**mutateAsync** call. |
| **isCompleted** | <code>method</code> | <code>dart bool isCompleted</code> | Whether the shared **future** has completed with a value or error. |
| **future** | <code>method</code> | <code>dart Future<T> future</code> | A future that resolves with the result of the in-flight (or next) |
| **mutateAsync** | <code>method</code> | <code>dart Future<T> mutateAsync(A arg)</code> | Run the mutation and await its result. |
| **mutate** | <code>method</code> | <code>dart void mutate(A arg)</code> | Run the mutation without awaiting it (fire-and-forget). |
| **reset** | <code>method</code> | <code>dart void reset()</code> | Reset the signal back to [MutationIdle](/types/mutationidle). |

## Function: mutationSignal

```dart
MutationSignal<A, T> mutationSignal(Future<T> Function(A arg) mutation, {SignalOptions<MutationState<T>>? options})
```

Create a [MutationSignal](/types/mutationsignal) from a mutation function.

The function receives a single typed argument <code>A</code> (use a record for multiple
values) and returns the mutation result <code>T</code>. Configure naming, auto-dispose,
and other behavior via **options**.

```dart
final rename = mutationSignal<String, void>((name) => api.rename(name));
rename.mutate('New name');
```

## References

The **MutationSignal** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [AsyncState](/packages/signals_flutter/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [MutationSignal](/packages/signals_flutter/async/mutation) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [SignalContainer](/packages/signals_flutter/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [signals_flutter](/packages/signals_flutter)
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [AsyncState](/packages/signals_core/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [MutationSignal](/packages/signals_core/async/mutation) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [SignalContainer](/packages/signals_core/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [signals_core](/packages/signals_core)
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [AsyncState](/packages/signals/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [MutationSignal](/packages/signals/async/mutation) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [SignalContainer](/packages/signals/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals](/packages/signals)
* [useMutationSignal](/packages/signals_hooks/hooks/use-mutation-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

