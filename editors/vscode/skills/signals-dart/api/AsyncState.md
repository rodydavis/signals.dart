# class `AsyncState`

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

---

## Members of `AsyncState`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **AsyncState** | `constructor` | `AsyncState()` |  |
| **AsyncState.dataReloading** | `constructor` | `AsyncState.dataReloading(T data)` | Create a state with a value that is reloading |
| **AsyncState.dataRefreshing** | `constructor` | `AsyncState.dataRefreshing(T data)` | Create a state with a value that is refreshing |
| **AsyncState.data** | `constructor` | `AsyncState.data(T data)` | Create a state with a value |
| **AsyncState.errorReloading** | `constructor` | `AsyncState.errorReloading(Object error, [StackTrace? stackTrace])` | Create a state with an error that is reloading |
| **AsyncState.errorRefreshing** | `constructor` | `AsyncState.errorRefreshing(Object error, [StackTrace? stackTrace])` | Create a state with an error that is refreshing |
| **AsyncState.error** | `constructor` | `AsyncState.error(Object error, [StackTrace? stackTrace])` | Create a state with an error |
| **AsyncState.loading** | `constructor` | `AsyncState.loading()` | Create a loading state |
| **hasValue** | `method` | `bool hasValue` | Returns true if the state has a value |
| **hasError** | `method` | `bool hasError` | Returns true if the state has an error |
| **isLoading** | `method` | `bool isLoading` | Check if the state is a loading state |
| **isRefreshing** | `method` | `bool isRefreshing` | Returns true if the state is refreshing with a loading flag,
 has a value or error and is not the loading state |
| **isReloading** | `method` | `bool isReloading` | Returns true if the state is reloading with having a value or error,
and is the loading state |
| **requireValue** | `method` | `T requireValue` | Force unwrap the value of the state.

This will throw an error if the state does not have a value. |
| **value** | `method` | `T? value` | Returns the value of the state. |
| **error** | `method` | `Object? error` | Returns the error of the state. |
| **stackTrace** | `method` | `StackTrace? stackTrace` | Returns the stack trace of the state. |
| **map** | `method` | `E map({required AsyncDataBuilder<E, T> data, required AsyncErrorBuilder<E> error, required AsyncStateBuilder<E> loading, AsyncStateBuilder<E>? reloading, AsyncStateBuilder<E>? refreshing})` | Map the state to a value.

```dart
final signal = StreamSignal<int>();
signal.value.map(
 data: (value) => 'Value: $value',
 error: (error, stackTrace) => 'Error: $error',
 loading: () => 'Loading...',
);
```

The error <code>Function</code> below can be one of two types:
- (dynamic) -> FutureOr
- (dynamic, StackTrace) -> FutureOr |
| **maybeMap** | `method` | `E maybeMap({AsyncDataBuilder<E, T>? data, AsyncErrorBuilder<E>? error, AsyncStateBuilder<E>? loading, AsyncStateBuilder<E>? reloading, AsyncStateBuilder<E>? refreshing, required AsyncStateBuilder<E> orElse})` | Map the state to a value with optional or else.

```dart
final signal = StreamSignal<int>();
signal.value.maybeMap(
 data: (value) => 'Value: $value',
 orElse: () => 'Loading...',
);
```

The error <code>Function</code> below can be one of two types:
- (dynamic) -> FutureOr
- (dynamic, StackTrace) -> FutureOr |
| **==** | `method` | `bool ==(covariant AsyncState<T> other)` |  |
| **hashCode** | `method` | `int hashCode` |  |
