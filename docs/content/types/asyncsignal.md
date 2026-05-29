---
title: "Type: AsyncSignal"
description: "API reference and details for AsyncSignal from signals.dart."
---

# AsyncSignal

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: AsyncSignal

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

### Members of AsyncSignal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **AsyncSignal** | <code>constructor</code> | <code>dart AsyncSignal(super.value, {super.options})</code> | A [Signal](/types/signal) that stores value in [AsyncState](/types/asyncstate) |
| **future** | <code>method</code> | <code>dart Future<T> future</code> | The future of the signal completer |
| **isCompleted** | <code>method</code> | <code>dart bool isCompleted</code> | Returns true if the signal is completed an error or data |
| **setError** | <code>method</code> | <code>dart void setError(Object error, [StackTrace? stackTrace])</code> | Set the error with optional stackTrace to [AsyncError](/types/asyncerror) |
| **setValue** | <code>method</code> | <code>dart void setValue(T value)</code> | Set the value to [AsyncData](/types/asyncdata) |
| **setLoading** | <code>method</code> | <code>dart void setLoading([AsyncState<T>? state])</code> | Set the loading state to [AsyncLoading](/types/asyncloading) |
| **reset** | <code>method</code> | <code>dart void reset([AsyncState<T>? value])</code> | Reset the signal to the initial value |
| **init** | <code>method</code> | <code>dart void init()</code> | Initialize the signal |
| **reload** | <code>method</code> | <code>dart Future<void> reload()</code> | Reload the future |
| **refresh** | <code>method</code> | <code>dart Future<void> refresh()</code> | Refresh the future |
| **value** | <code>method</code> | <code>dart AsyncState<T> value</code> |  |
| **requireValue** | <code>method</code> | <code>dart T requireValue</code> | Returns the value of the signal |

## Function: asyncSignal

```dart
AsyncSignal<T> asyncSignal(AsyncState<T> value, {AsyncSignalOptions<T>? options, @Deprecated('Use options: AsyncSignalOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: AsyncSignalOptions(autoDispose: ...) instead') bool? autoDispose})
```

Helper function to create an [AsyncSignal](/types/asyncsignal) initialized with an [AsyncState](/types/asyncstate).

### Example
```dart
// Create an AsyncSignal initialized to a loading state
final counter = asyncSignal<int>(AsyncState.loading());

// Create an AsyncSignal initialized with initial data
final status = asyncSignal<String>(AsyncState.data('Active'));
```

## References

The **AsyncSignal** type is referenced and used in the following pages:

* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [AsyncState](/packages/signals_flutter/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [AsyncSignal](/packages/signals_flutter/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [signals_flutter](/packages/signals_flutter)
* [AsyncState](/packages/signals_core/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [AsyncSignal](/packages/signals_core/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [signals_core](/packages/signals_core)
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [AsyncState](/packages/signals/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [AsyncSignal](/packages/signals/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [signals](/packages/signals)
* [useAsyncSignal](/packages/signals_hooks/hooks/use-async-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

