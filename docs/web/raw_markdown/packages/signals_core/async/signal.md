---
title: AsyncSignal
description: A highly powerful Signal specifically designed for manual, imperative asynchronous state management.
---

A highly powerful [Signal](/types/signal) specifically designed for manual, imperative asynchronous state management.

Unlike declarative reactive signals like [futureSignal](/types/futuresignal) or [streamSignal](/types/streamsignal) (which automatically wrap and listen
to an existing <code>Future</code> or <code>Stream</code>), <code>AsyncSignal<T></code> gives you full manual/imperative control over pushing
async states ([AsyncState.loading](/types/asyncstate#loading), [AsyncState.data](/types/asyncstate#data), and [AsyncState.error](/types/asyncstate#error)) into the reactive graph.

This is the perfect state primitive for building custom repositories, handling manual user action triggers
(e.g., submitting a registration form, calling an API on button click), or bridging low-level callback-based APIs
into reactive states.

### 1. Imperative State Mutations
You can update the state of the signal directly using specialized mutation helpers:
- <code>setLoading()</code> puts the signal into a clean <code>AsyncLoading</code> state.
- <code>setValue(T data)</code> pushes a new <code>AsyncData</code> state containing the data.
- <code>setError(Object error, [StackTrace? stackTrace])</code> transitions the signal to an <code>AsyncError</code> state.

```dart
final authState = asyncSignal<User>(AsyncState.loading());

Future<void> login(String email, String password) async {
  try {
    authState.setLoading(); // Set UI to loading state
    final user = await authApi.signIn(email, password);
    authState.setValue(user); // Push success data
  } catch (err, stack) {
    authState.setError(err, stack); // Push error state
  }
}
```

### 2. Awaiting Async Completion via <code>.future</code>
An outstanding capability of <code>AsyncSignal</code> is its built-in <code>.future</code> getter. Any part of your code can await
this future. It returns a standard <code>Future<T></code> that resolves when the signal next receives a data value,
or throws if the signal next receives an error state.

```dart
final loginSignal = asyncSignal<User>(AsyncState.loading());

// Task A: Start background operation
Future.delayed(Duration(seconds: 2), () {
  loginSignal.setValue(User(name: 'Charlie'));
});

// Task B: Wait for the signal to resolve!
final user = await loginSignal.future; // Suspends execution until Task A completes!
print(user.name); // 'Charlie'
```

### 3. Rendering in Flutter using <code>Watch</code> and <code>AsyncState</code> Pattern matching
In your Flutter widgets, you can seamlessly watch the signal and use Dart's native pattern matching
on [AsyncState](/types/asyncstate) to render different widgets corresponding to the current asynchronous lifecycle:

```dart
Widget build(BuildContext context) {
  final state = authState.watch(context);

  return state.map(
    data: (user) => HomeScreen(user: user),
    error: (error, stackTrace) => ErrorWidget(error),
    loading: () => const CircularProgressIndicator(),
  );
}
```

### 4. Bridging callback/event-driven systems via <code>EventSink</code>
<code>AsyncSignal</code> implements Dart's standard **EventSink** interface. This allows it to act directly as an event sink
for streams, websockets, or callback listeners:

```dart
final messageLog = asyncSignal<String>(AsyncState.loading());
final chatStream = webSocket.stream.map((event) => event.toString());

// Automatically push all incoming messages and errors from the stream into the signal:
chatStream.listen(
  (msg) => messageLog.add(msg),
  onError: (err) => messageLog.addError(err),
  onDone: () => messageLog.close(),
);
```

<Info>
  Favor <code>AsyncSignal</code> when you need manual, callback-driven, or button-press-triggered state mutations.
  For auto-triggering, declarative, or read-only asynchronous data dependencies (like pulling data when an ID changes),
  favor <a href="/types/futuresignal">futureSignal</a> or <a href="/types/computedasync">computedAsync</a> instead.
</Info>


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="asyncsignal"></a><a name="asyncsignal"></a>`AsyncSignal(super.value, {super.options})`

A [Signal](/types/signal) that stores value in [AsyncState](/types/asyncstate)

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="future"></a>`Future<T> future`

The future of the signal completer

##### <a name="iscompleted"></a>`bool isCompleted`

Returns true if the signal is completed an error or data

##### <a name="seterror"></a>`void setError(Object error, [StackTrace? stackTrace])`

Set the error with optional stackTrace to [AsyncError](/types/asyncerror)

##### <a name="setvalue"></a>`void setValue(T value)`

Set the value to [AsyncData](/types/asyncdata)

##### <a name="setloading"></a>`void setLoading([AsyncState<T>? state])`

Set the loading state to [AsyncLoading](/types/asyncloading)

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

</details>



---

## asyncSignal

Helper function to create an [AsyncSignal](/types/asyncsignal) initialized with an [AsyncState](/types/asyncstate).

### Example
```dart
// Create an AsyncSignal initialized to a loading state
final counter = asyncSignal<int>(AsyncState.loading());

// Create an AsyncSignal initialized with initial data
final status = asyncSignal<String>(AsyncState.data('Active'));
```


---

## TimerSignal

Emit recurring **TimerSignalEvent** aka [AsyncSignal](/types/asyncsignal)


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="timersignal"></a><a name="timersignal"></a>`TimerSignal({required this.every, super.cancelOnError, AsyncSignalOptions<TimerSignalEvent>? options, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})`

Emit recurring **TimerSignalEvent** aka [AsyncSignal](/types/asyncsignal)

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="every"></a>`Duration every`

Trigger an **TimerSignalEvent** every duration

</details>



---

## AsyncSignalOptions

Configuration options for an [AsyncSignal](/types/asyncsignal).


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="asyncsignaloptions"></a><a name="asyncsignaloptions"></a>`AsyncSignalOptions({this.initialValue, this.dependencies = const [], this.onDone, this.cancelOnError, this.lazy = true, super.name, super.autoDispose, super.watched, super.unwatched})`

Creates a new [AsyncSignalOptions](/types/asyncsignaloptions) instance.

</details>


### Properties

<details>
<summary> View Properties </summary>

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

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a>`AsyncSignalOptions<T> copyWith({T? initialValue, List<ReadonlySignal<dynamic>>? dependencies, void Function()? onDone, bool? cancelOnError, bool? lazy, bool? autoDispose, String? name, void Function()? watched, void Function()? unwatched})`

Creates a copy of this options with custom overrides.

##### <a name="=="></a>`bool ==(Object other)`

##### <a name="hashcode"></a>`int hashCode`

</details>



---

## TimerSignalDurationUtils

Expose Duration as a [TimerSignal](/types/timersignal)


### Methods

<details>
<summary> View Methods </summary>

##### <a name="tosignal"></a>`TimerSignal toSignal({bool? cancelOnError, AsyncSignalOptions<TimerSignalEvent>? options, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel})`

Expose Duration as a [TimerSignal](/types/timersignal)

</details>



---

## timerSignal

Create a [TimerSignal](/types/timersignal)
