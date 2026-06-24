---
title: "Type: MutationState"
description: "API reference and details for MutationState from signals.dart."
---

# MutationState

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: MutationState

A sealed union representing the lifecycle states of an imperative mutation
(a side-effecting async operation triggered on demand, e.g. submitting a
form or calling a <code>POST</code>/<code>PUT</code>/<code>DELETE</code> endpoint).

<code>MutationState<T></code> is wrapped by [MutationSignal](/types/mutationsignal). Unlike
[AsyncState](/types/asyncstate) (which has no "not started yet" representation because a future
or stream begins executing immediately), a mutation begins in an [MutationIdle](/types/mutationidle)
state and only transitions once it has been run.

### State Hierarchy
- [MutationIdle](/types/mutationidle): The mutation has not been run yet (the extra state on top of
  the standard loading/data/error lifecycle).
- [MutationPending](/types/mutationpending): The mutation is currently running.
- [MutationSuccess](/types/mutationsuccess): The mutation completed successfully with a value of type <code>T</code>.
- [MutationError](/types/mutationerror): The mutation failed with an error and stack trace.

### Pattern Matching & Switch Expressions
```dart
final label = switch (mutation.value) {
  MutationIdle<int>() => 'Not run yet',
  MutationPending<int>() => 'Saving...',
  MutationSuccess<int>(:final value) => 'Saved: $value',
  MutationError<int>(:final error) => 'Failed: $error',
};
```

### Standard Branching Methods (<code>map</code> and <code>maybeMap</code>)
```dart
mutation.value.map(
  idle: () => 'Not run yet',
  pending: () => 'Saving...',
  data: (value) => 'Saved: $value',
  error: (error, stackTrace) => 'Failed: $error',
);
```

### Members of MutationState

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **MutationState** | <code>constructor</code> | <code>dart MutationState()</code> | Const constructor for [MutationState](/types/mutationstate) subclasses. |
| **MutationState.idle** | <code>constructor</code> | <code>dart MutationState.idle()</code> | Create an [MutationIdle](/types/mutationidle) state (the mutation has not been run yet). |
| **MutationState.pending** | <code>constructor</code> | <code>dart MutationState.pending()</code> | Create a [MutationPending](/types/mutationpending) state (the mutation is running). |
| **MutationState.data** | <code>constructor</code> | <code>dart MutationState.data(T data)</code> | Create a [MutationSuccess](/types/mutationsuccess) state with a resolved value. |
| **MutationState.error** | <code>constructor</code> | <code>dart MutationState.error(Object error, [StackTrace? stackTrace])</code> | Create a [MutationError](/types/mutationerror) state with an error and optional stack trace. |
| **isIdle** | <code>method</code> | <code>dart bool isIdle</code> | Returns true if the mutation has not been run yet. |
| **isPending** | <code>method</code> | <code>dart bool isPending</code> | Returns true if the mutation is currently running. |
| **hasValue** | <code>method</code> | <code>dart bool hasValue</code> | Returns true if the state holds a resolved value. |
| **hasError** | <code>method</code> | <code>dart bool hasError</code> | Returns true if the state holds an error. |
| **value** | <code>method</code> | <code>dart T? value</code> | Returns the resolved value of the state, or null. |
| **error** | <code>method</code> | <code>dart Object? error</code> | Returns the error of the state, or null. |
| **stackTrace** | <code>method</code> | <code>dart StackTrace? stackTrace</code> | Returns the stack trace of the state, or null. |
| **requireValue** | <code>method</code> | <code>dart T requireValue</code> | Force unwrap the value of the state. |
| **map** | <code>method</code> | <code>dart E map({required MutationStateBuilder<E> idle, required MutationStateBuilder<E> pending, required MutationDataBuilder<E, T> data, required MutationErrorBuilder<E> error})</code> | Map the state to a value, handling every branch. |
| **maybeMap** | <code>method</code> | <code>dart E maybeMap({MutationStateBuilder<E>? idle, MutationStateBuilder<E>? pending, MutationDataBuilder<E, T>? data, MutationErrorBuilder<E>? error, required MutationStateBuilder<E> orElse})</code> | Map the state to a value with an **orElse** fallback for unhandled branches. |
| **==** | <code>method</code> | <code>dart bool ==(covariant MutationState<T> other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## References

The **MutationState** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [AsyncState](/packages/signals_flutter/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [MutationSignal](/packages/signals_flutter/async/mutation) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [AsyncState](/packages/signals_core/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [MutationSignal](/packages/signals_core/async/mutation) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [AsyncState](/packages/signals/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [MutationSignal](/packages/signals/async/mutation) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>

