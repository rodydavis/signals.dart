---
title: AsyncSignal
description: A Signal specifically designed for manual asynchronous state management.
---

A [Signal](/packages/signals/core/signal) specifically designed for manual asynchronous state management.

`AsyncSignal<T>` wraps an [AsyncState<T>](/packages/signals/async/state) (which can be loading, data, or error)
and provides utility getters like [.future] to easily await its completion.

### Simple Example
```dart
// Create an AsyncSignal starting in a loading state
final weather = asyncSignal<double>(AsyncState.loading());

// Update the value with data
weather.value = AsyncState.data(72.5); // or AsyncData(72.5)

// Or set an error
weather.value = AsyncState.error('Failed to fetch weather', null);
```

### Awaiting Completion with `.future`
Sometimes you need to await the signal until it completes with a value.
You can await the [.future] getter, which returns a `Future<T>` that resolves
when a data value is pushed, or throws when an error is set.

```dart
final s = asyncSignal<int>(AsyncState.loading());

// Start a background task
Future.delayed(Duration(seconds: 1), () => s.setValue(42));

// Await the completion of the signal!
final result = await s.future; // Waits and resolves to 42
```

### Direct Mutators: `setValue`, `setError`, and `setLoading`
Instead of manually instantiating [AsyncData](/packages/signals/async/state) or [AsyncError](/packages/signals/async/state), you can use
helper methods directly on `AsyncSignal`:
- `s.setValue(value)` wraps the value in `AsyncData` and notifies listeners.
- `s.setError(error, [stackTrace])` wraps the error in `AsyncError` and notifies.
- `s.setLoading()` puts the signal back into a clean `AsyncLoading` state.

### EventSink Integration
`AsyncSignal` implements the standard **EventSink** interface. You can pass it directly
to stream listeners or use it to pipeline event streams:
```dart
final numbers = Stream.periodic(Duration(seconds: 1), (i) => i).take(5);
final counter = asyncSignal<int>(AsyncState.loading());

// Pipe the stream directly into the signal!
numbers.listen(
  (val) => counter.add(val),
  onError: (err) => counter.addError(err),
  onDone: () => counter.close(),
);
```


### Constructors

##### <a name="asyncsignal"></a><a name="asyncsignal"></a>`AsyncSignal(super.value, {super.options})`

A [Signal](/packages/signals/core/signal) that stores value in [AsyncState](/packages/signals/async/state)


### Properties

##### <a name="completer"></a>`Completer<T> completer`

Internal Completer for values


### Methods

##### <a name="future"></a>`Future<T> future`

The future of the signal completer

##### <a name="iscompleted"></a>`bool isCompleted`

Returns true if the signal is completed an error or data

##### <a name="seterror"></a>`void setError(Object error, [StackTrace? stackTrace])`

Set the error with optional stackTrace to [AsyncError](/packages/signals/async/state)

##### <a name="setvalue"></a>`void setValue(T value)`

Set the value to [AsyncData](/packages/signals/async/state)

##### <a name="setloading"></a>`void setLoading([AsyncState<T>? state])`

Set the loading state to [AsyncLoading](/packages/signals/async/state)

##### <a name="reset"></a>`void reset([AsyncState<T>? value])`

Reset the signal to the initial value

##### <a name="init"></a>`void init()`

Initialize the signal

##### <a name="reload"></a>`Future<void> reload()`

Reload the future

##### <a name="refresh"></a>`Future<void> refresh()`

Refresh the future

##### <a name="value"></a>`AsyncState<T> value`

##### <a name="requirevalue"></a>`T requireValue`

Returns the value of the signal



---

## asyncSignal

Helper function to create an [AsyncSignal](/packages/signals/async/signal) initialized with an [AsyncState](/packages/signals/async/state).

### Example
```dart
// Create an AsyncSignal initialized to a loading state
final counter = asyncSignal<int>(AsyncState.loading());

// Create an AsyncSignal initialized with initial data
final status = asyncSignal<String>(AsyncState.data('Active'));
```


---

## AsyncSignalOptions

Configuration options for an [AsyncSignal](/packages/signals/async/signal).


### Constructors

##### <a name="asyncsignaloptions"></a><a name="asyncsignaloptions"></a>`AsyncSignalOptions({this.initialValue, this.dependencies = const [], this.onDone, this.cancelOnError, this.lazy = true, super.name, super.autoDispose, super.watched, super.unwatched})`

Creates a new [AsyncSignalOptions](/packages/signals/async/signal) instance.


### Properties

##### <a name="initialvalue"></a>`T? initialValue`

The initial value of the async signal.

##### <a name="dependencies"></a>`List<ReadonlySignal<dynamic>> dependencies`

The list of dependencies to watch/listen to.

##### <a name="ondone"></a>`void Function()? onDone`

Optional function called when a stream completes.

##### <a name="cancelonerror"></a>`bool? cancelOnError`

Whether to cancel the stream subscription on error.

##### <a name="lazy"></a>`bool lazy`

Whether the execution is lazy.


### Methods

##### <a name="copywith"></a>`AsyncSignalOptions<T> copyWith({T? initialValue, List<ReadonlySignal<dynamic>>? dependencies, void Function()? onDone, bool? cancelOnError, bool? lazy, bool? autoDispose, String? name, void Function()? watched, void Function()? unwatched})`

Creates a copy of this options with custom overrides.

##### <a name="=="></a>`bool ==(Object other)`

##### <a name="hashcode"></a>`int hashCode`
