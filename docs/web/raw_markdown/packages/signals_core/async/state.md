---
title: AsyncState
description: A sealed union representing the lifecycle states of an asynchronous operation.
---

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


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="asyncstate"></a><a name="asyncstate"></a>`AsyncState()`

##### <a name="asyncstate-datareloading"></a><a name="datareloading"></a>`AsyncState.dataReloading(T data)`

Create a state with a value that is reloading

##### <a name="asyncstate-datarefreshing"></a><a name="datarefreshing"></a>`AsyncState.dataRefreshing(T data)`

Create a state with a value that is refreshing

##### <a name="asyncstate-data"></a><a name="data"></a>`AsyncState.data(T data)`

Create a state with a value

##### <a name="asyncstate-errorreloading"></a><a name="errorreloading"></a>`AsyncState.errorReloading(Object error, [StackTrace? stackTrace])`

Create a state with an error that is reloading

##### <a name="asyncstate-errorrefreshing"></a><a name="errorrefreshing"></a>`AsyncState.errorRefreshing(Object error, [StackTrace? stackTrace])`

Create a state with an error that is refreshing

##### <a name="asyncstate-error"></a><a name="error"></a>`AsyncState.error(Object error, [StackTrace? stackTrace])`

Create a state with an error

##### <a name="asyncstate-loading"></a><a name="loading"></a>`AsyncState.loading()`

Create a loading state

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="hasvalue"></a>`bool hasValue`

Returns true if the state has a value

##### <a name="haserror"></a>`bool hasError`

Returns true if the state has an error

##### <a name="isloading"></a>`bool isLoading`

Check if the state is a loading state

##### <a name="isrefreshing"></a>`bool isRefreshing`

Returns true if the state is refreshing with a loading flag,
 has a value or error and is not the loading state

##### <a name="isreloading"></a>`bool isReloading`

Returns true if the state is reloading with having a value or error,
and is the loading state

##### <a name="requirevalue"></a>`T requireValue`

Force unwrap the value of the state.

This will throw an error if the state does not have a value.

##### <a name="value"></a>`T? value`

Returns the value of the state.

##### <a name="error"></a>`Object? error`

Returns the error of the state.

##### <a name="stacktrace"></a>`StackTrace? stackTrace`

Returns the stack trace of the state.

##### <a name="map"></a>`E map({required AsyncDataBuilder<E, T> data, required AsyncErrorBuilder<E> error, required AsyncStateBuilder<E> loading, AsyncStateBuilder<E>? reloading, AsyncStateBuilder<E>? refreshing})`

Map the state to a value.

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
- (dynamic, StackTrace) -> FutureOr

##### <a name="maybemap"></a>`E maybeMap({AsyncDataBuilder<E, T>? data, AsyncErrorBuilder<E>? error, AsyncStateBuilder<E>? loading, AsyncStateBuilder<E>? reloading, AsyncStateBuilder<E>? refreshing, required AsyncStateBuilder<E> orElse})`

Map the state to a value with optional or else.

```dart
final signal = StreamSignal<int>();
signal.value.maybeMap(
 data: (value) => 'Value: $value',
 orElse: () => 'Loading...',
);
```

The error <code>Function</code> below can be one of two types:
- (dynamic) -> FutureOr
- (dynamic, StackTrace) -> FutureOr

##### <a name="=="></a>`bool ==(covariant AsyncState<T> other)`

##### <a name="hashcode"></a>`int hashCode`

</details>



---

## AsyncErrorRefreshing

A loading state with an error. Signal the query conditions that led to the error
has remained the same and is being refreshed.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="asyncerrorrefreshing"></a><a name="asyncerrorrefreshing"></a>`AsyncErrorRefreshing(super.error, super.stackTrace)`

Create a state with an error that is refreshing

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="isloading"></a>`bool isLoading`

##### <a name="isrefreshing"></a>`bool isRefreshing`

##### <a name="=="></a>`bool ==(covariant AsyncState other)`

</details>



---

## AsyncDataRefreshing

A loading state with a value. Signals the query conditions that led to the data
has remained the same and is being refreshed


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="asyncdatarefreshing"></a><a name="asyncdatarefreshing"></a>`AsyncDataRefreshing(super.data)`

Create a state with a value that is refreshing

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="isloading"></a>`bool isLoading`

##### <a name="isrefreshing"></a>`bool isRefreshing`

##### <a name="=="></a>`bool ==(covariant AsyncState other)`

</details>



---

## LinkedSignalPreviousState

Previous state of a [LinkedSignal](/types/linkedsignal), containing both the **source** value
and the computed **value** from that source version.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="linkedsignalpreviousstate"></a><a name="linkedsignalpreviousstate"></a>`LinkedSignalPreviousState(this.source, this.value)`

Creates a [LinkedSignalPreviousState](/types/linkedsignalpreviousstate).

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="source"></a>`S source`

The source value.

##### <a name="value"></a>`T value`

The computed value.

</details>



---

## AsyncErrorReloading

A loading state with an error. Signal the query conditions that led to the error
has changed and is being reloaded.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="asyncerrorreloading"></a><a name="asyncerrorreloading"></a>`AsyncErrorReloading(super.error, super.stackTrace)`

Create a state with an error that is reloading

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="isloading"></a>`bool isLoading`

##### <a name="isreloading"></a>`bool isReloading`

##### <a name="=="></a>`bool ==(covariant AsyncState other)`

</details>



---

## AsyncDataReloading

A loading state with a value. Signals the query conditions that led to the data
has changed and is being reloaded.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="asyncdatareloading"></a><a name="asyncdatareloading"></a>`AsyncDataReloading(super.data)`

Create a state with a value that is reloading

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="isloading"></a>`bool isLoading`

##### <a name="isreloading"></a>`bool isReloading`

##### <a name="=="></a>`bool ==(covariant AsyncState other)`

</details>



---

## AsyncLoading

State for an [AsyncState](/types/asyncstate) with a loading state


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="asyncloading"></a><a name="asyncloading"></a>`AsyncLoading()`

State for an [AsyncState](/types/asyncstate) with a loading state

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="hasvalue"></a>`bool hasValue`

##### <a name="haserror"></a>`bool hasError`

##### <a name="value"></a>`T? value`

##### <a name="isloading"></a>`bool isLoading`

##### <a name="isrefreshing"></a>`bool isRefreshing`

##### <a name="isreloading"></a>`bool isReloading`

##### <a name="requirevalue"></a>`T requireValue`

##### <a name="error"></a>`Object? error`

##### <a name="stacktrace"></a>`StackTrace? stackTrace`

##### <a name="=="></a>`bool ==(covariant AsyncState other)`

##### <a name="hashcode"></a>`int hashCode`

</details>



---

## AsyncError

State for an [AsyncState](/types/asyncstate) with an error


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="asyncerror"></a><a name="asyncerror"></a>`AsyncError(this.error, this.stackTrace)`

State for an [AsyncState](/types/asyncstate) with an error

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="error"></a>`Object error`

##### <a name="stacktrace"></a>`StackTrace stackTrace`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="hasvalue"></a>`bool hasValue`

##### <a name="haserror"></a>`bool hasError`

##### <a name="value"></a>`T? value`

##### <a name="isloading"></a>`bool isLoading`

##### <a name="isrefreshing"></a>`bool isRefreshing`

##### <a name="isreloading"></a>`bool isReloading`

##### <a name="requirevalue"></a>`T requireValue`

##### <a name="=="></a>`bool ==(covariant AsyncState other)`

##### <a name="hashcode"></a>`int hashCode`

</details>



---

## AsyncData

State for an [AsyncState](/types/asyncstate) with a value


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="asyncdata"></a><a name="asyncdata"></a>`AsyncData(T data)`

State for an [AsyncState](/types/asyncstate) with a value

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="value"></a>`T value`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="hasvalue"></a>`bool hasValue`

##### <a name="haserror"></a>`bool hasError`

##### <a name="isloading"></a>`bool isLoading`

##### <a name="isrefreshing"></a>`bool isRefreshing`

##### <a name="isreloading"></a>`bool isReloading`

##### <a name="requirevalue"></a>`T requireValue`

##### <a name="error"></a>`Object? error`

##### <a name="stacktrace"></a>`StackTrace? stackTrace`

##### <a name="=="></a>`bool ==(covariant AsyncState other)`

##### <a name="hashcode"></a>`int hashCode`

</details>



---

## AsyncSignalState

Extensions for [Signal<AsyncState<T>>]


### Methods

<details>
<summary> View Methods </summary>

##### <a name="selectdata"></a>`Computed<AsyncState<R>> selectData(R Function(T data) selector)`

Select from data when available, preserving async state

</details>
