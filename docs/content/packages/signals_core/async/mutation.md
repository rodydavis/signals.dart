---
title: MutationSignal
description: A Signal for imperative, on-demand asynchronous side effects (mutations).
---

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


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="mutationsignal"></a><a name="mutationsignal"></a><code>MutationSignal(this._mutator, {SignalOptions<MutationState<T>>? options})</code>

Create a [MutationSignal](/types/mutationsignal) from an async mutation function.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="variables"></a><code>A? variables</code>

The argument passed to the most recent **mutate**/**mutateAsync** call.

<code>null</code> before the first run and after **reset**.

##### <a name="iscompleted"></a><code>bool isCompleted</code>

Whether the shared **future** has completed with a value or error.

##### <a name="future"></a><code>Future<T> future</code>

A future that resolves with the result of the in-flight (or next)
mutation, or throws if it fails. A fresh future is created each time a new
mutation is started after the previous one settled, and on **reset**.

##### <a name="mutateasync"></a><code>Future<T> mutateAsync(A arg)</code>

Run the mutation and await its result.

Transitions the state to [MutationPending](/types/mutationpending) synchronously, then to
[MutationSuccess](/types/mutationsuccess) or [MutationError](/types/mutationerror) once it settles. Returns the result
of *this* invocation (or throws its error) even when a newer mutation
supersedes it; only the latest invocation updates the shared signal state
and **future**.

##### <a name="mutate"></a><code>void mutate(A arg)</code>

Run the mutation without awaiting it (fire-and-forget).

Errors are captured into [MutationError](/types/mutationerror) state rather than thrown, so this
never produces an unhandled async error.

##### <a name="reset"></a><code>void reset()</code>

Reset the signal back to [MutationIdle](/types/mutationidle).

Any in-flight mutation is detached and will no longer update the state.
A **future** obtained before the reset is settled with a **StateError** so it
never hangs, and a fresh **future** is prepared for the next mutation.

</details>



---

## MutationState

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


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="mutationstate"></a><a name="mutationstate"></a><code>MutationState()</code>

Const constructor for [MutationState](/types/mutationstate) subclasses.

##### <a name="mutationstate-idle"></a><a name="idle"></a><code>MutationState.idle()</code>

Create an [MutationIdle](/types/mutationidle) state (the mutation has not been run yet).

##### <a name="mutationstate-pending"></a><a name="pending"></a><code>MutationState.pending()</code>

Create a [MutationPending](/types/mutationpending) state (the mutation is running).

##### <a name="mutationstate-data"></a><a name="data"></a><code>MutationState.data(T data)</code>

Create a [MutationSuccess](/types/mutationsuccess) state with a resolved value.

##### <a name="mutationstate-error"></a><a name="error"></a><code>MutationState.error(Object error, [StackTrace? stackTrace])</code>

Create a [MutationError](/types/mutationerror) state with an error and optional stack trace.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="isidle"></a><code>bool isIdle</code>

Returns true if the mutation has not been run yet.

##### <a name="ispending"></a><code>bool isPending</code>

Returns true if the mutation is currently running.

##### <a name="hasvalue"></a><code>bool hasValue</code>

Returns true if the state holds a resolved value.

##### <a name="haserror"></a><code>bool hasError</code>

Returns true if the state holds an error.

##### <a name="value"></a><code>T? value</code>

Returns the resolved value of the state, or null.

##### <a name="error"></a><code>Object? error</code>

Returns the error of the state, or null.

##### <a name="stacktrace"></a><code>StackTrace? stackTrace</code>

Returns the stack trace of the state, or null.

##### <a name="requirevalue"></a><code>T requireValue</code>

Force unwrap the value of the state.

Throws an **UnsupportedError** if the state does not hold a value.

##### <a name="map"></a><code>E map({required MutationStateBuilder<E> idle, required MutationStateBuilder<E> pending, required MutationDataBuilder<E, T> data, required MutationErrorBuilder<E> error})</code>

Map the state to a value, handling every branch.

The error <code>Function</code> can be one of three types:
- () -> E
- (dynamic) -> E
- (dynamic, StackTrace) -> E

##### <a name="maybemap"></a><code>E maybeMap({MutationStateBuilder<E>? idle, MutationStateBuilder<E>? pending, MutationDataBuilder<E, T>? data, MutationErrorBuilder<E>? error, required MutationStateBuilder<E> orElse})</code>

Map the state to a value with an **orElse** fallback for unhandled branches.

The error <code>Function</code> can be one of three types:
- () -> E
- (dynamic) -> E
- (dynamic, StackTrace) -> E

##### <a name="=="></a><code>bool ==(covariant MutationState<T> other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## mutationSignal

Create a [MutationSignal](/types/mutationsignal) from a mutation function.

The function receives a single typed argument <code>A</code> (use a record for multiple
values) and returns the mutation result <code>T</code>. Configure naming, auto-dispose,
and other behavior via **options**.

```dart
final rename = mutationSignal<String, void>((name) => api.rename(name));
rename.mutate('New name');
```
