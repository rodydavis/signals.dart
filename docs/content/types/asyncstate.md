---
title: "Type: AsyncState"
description: "API reference and details for AsyncState from signals.dart."
---

# AsyncState

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: AsyncState

A sealed union representing the lifecycle states of an asynchronous operation.

<code>AsyncState<T></code> is commonly wrapped by <code>AsyncSignal</code> or returned by asynchronous
computed signals (<code>computedAsync</code>, <code>computedFrom</code>) to model loading, success (data),
and error outcomes.

### State Hierarchy
The states are modeled as a robust hierarchy of immutable types:
- [AsyncLoading](/types/asyncloading): Pure loading state with no pre-existing data.
- [AsyncData](/types/asyncdata): Success state holding a resolved value of type <code>T</code>.
  - [AsyncDataRefreshing](/types/asyncdatarefreshing): Refreshing in the background (holding historical data).
  - [AsyncDataReloading](/types/asyncdatareloading): Reloading (holding historical data).
- [AsyncError](/types/asyncerror): Failure state holding an error and optional stack trace.
  - [AsyncErrorRefreshing](/types/asyncerrorrefreshing): Refreshing in the background (holding historical error).
  - [AsyncErrorReloading](/types/asyncerrorreloading): Reloading (holding historical error).

### Pattern Matching & Switch Expressions
Standard Dart switch expressions provide type-safe branching across all states:

> [!IMPORTANT]
> **Branch Matching Order & Existing Value Preservation:**
> Since reloading and refreshing states (e.g., <code>AsyncDataRefreshing</code>, <code>AsyncDataReloading</code>) implement both <code>AsyncData</code> and <code>AsyncLoading</code>, matching on <code>AsyncLoading</code> **first** will prematurely swallow existing data!
> Always place <code>AsyncData</code> and <code>AsyncError</code> branches **before** <code>AsyncLoading</code> to ensure pre-existing data or error states are successfully rendered during refreshes:

```dart
final value = switch (state) {
    AsyncDataRefreshing<int> r => 'Refreshing with value: ${r.value}',
    AsyncDataReloading<int> r => 'Reloading with value: ${r.value}',
    AsyncData<int> data => 'Stable value: ${data.value}',
    AsyncErrorRefreshing<int> r => 'Refreshing error: ${r.error}',
    AsyncErrorReloading<int> r => 'Reloading error: ${r.error}',
    AsyncError<int> error => 'Stable error: ${error.error}',
    AsyncLoading<int>() => 'Pure Loading State (no prior data)',
};
```

### Standard Branching Methods (<code>map</code> and <code>maybeMap</code>)
If you prefer standard callbacks over switch expressions, use <code>map</code> or <code>maybeMap</code>:
```dart
state.map(
  data: (value) => 'Value: $value',
  error: (error, stackTrace) => 'Error: $error',
  loading: () => 'Loading...',
);
```

### Members of AsyncState

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **AsyncState** | <code>constructor</code> | <code>dart AsyncState()</code> |  |
| **AsyncState.dataReloading** | <code>constructor</code> | <code>dart AsyncState.dataReloading(T data)</code> | Create a state with a value that is reloading |
| **AsyncState.dataRefreshing** | <code>constructor</code> | <code>dart AsyncState.dataRefreshing(T data)</code> | Create a state with a value that is refreshing |
| **AsyncState.data** | <code>constructor</code> | <code>dart AsyncState.data(T data)</code> | Create a state with a value |
| **AsyncState.errorReloading** | <code>constructor</code> | <code>dart AsyncState.errorReloading(Object error, [StackTrace? stackTrace])</code> | Create a state with an error that is reloading |
| **AsyncState.errorRefreshing** | <code>constructor</code> | <code>dart AsyncState.errorRefreshing(Object error, [StackTrace? stackTrace])</code> | Create a state with an error that is refreshing |
| **AsyncState.error** | <code>constructor</code> | <code>dart AsyncState.error(Object error, [StackTrace? stackTrace])</code> | Create a state with an error |
| **AsyncState.loading** | <code>constructor</code> | <code>dart AsyncState.loading()</code> | Create a loading state |
| **hasValue** | <code>method</code> | <code>dart bool hasValue</code> | Returns true if the state has a value |
| **hasError** | <code>method</code> | <code>dart bool hasError</code> | Returns true if the state has an error |
| **isLoading** | <code>method</code> | <code>dart bool isLoading</code> | Check if the state is a loading state |
| **isRefreshing** | <code>method</code> | <code>dart bool isRefreshing</code> | Returns true if the state is refreshing with a loading flag, |
| **isReloading** | <code>method</code> | <code>dart bool isReloading</code> | Returns true if the state is reloading with having a value or error, |
| **requireValue** | <code>method</code> | <code>dart T requireValue</code> | Force unwrap the value of the state. |
| **value** | <code>method</code> | <code>dart T? value</code> | Returns the value of the state. |
| **error** | <code>method</code> | <code>dart Object? error</code> | Returns the error of the state. |
| **stackTrace** | <code>method</code> | <code>dart StackTrace? stackTrace</code> | Returns the stack trace of the state. |
| **map** | <code>method</code> | <code>dart E map({required AsyncDataBuilder<E, T> data, required AsyncErrorBuilder<E> error, required AsyncStateBuilder<E> loading, AsyncStateBuilder<E>? reloading, AsyncStateBuilder<E>? refreshing})</code> | Map the state to a value. |
| **maybeMap** | <code>method</code> | <code>dart E maybeMap({AsyncDataBuilder<E, T>? data, AsyncErrorBuilder<E>? error, AsyncStateBuilder<E>? loading, AsyncStateBuilder<E>? reloading, AsyncStateBuilder<E>? refreshing, required AsyncStateBuilder<E> orElse})</code> | Map the state to a value with optional or else. |
| **==** | <code>method</code> | <code>dart bool ==(covariant AsyncState<T> other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## References

The **AsyncState** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [EventSinkSignalMixin](/packages/signals_flutter/mixins/event-sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [AsyncState](/packages/signals_flutter/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [FutureSignal](/packages/signals_flutter/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [AsyncSignal](/packages/signals_flutter/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Stream](/packages/signals_flutter/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [signals_flutter](/packages/signals_flutter)
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [EventSinkSignalMixin](/packages/signals_core/mixins/event-sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [AsyncState](/packages/signals_core/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [FutureSignal](/packages/signals_core/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [AsyncSignal](/packages/signals_core/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [Stream](/packages/signals_core/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [signals_core](/packages/signals_core)
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [EventSinkSignalMixin](/packages/signals/mixins/event-sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [AsyncState](/packages/signals/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [FutureSignal](/packages/signals/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [AsyncSignal](/packages/signals/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [Stream](/packages/signals/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [signals](/packages/signals)
* [useAsyncSignal](/packages/signals_hooks/hooks/use-async-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

