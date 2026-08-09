---
title: "Type: Signal"
description: "API reference and details for Signal from signals.dart."
---

# Signal

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Class: Signal

Represents a mutable reactive state container that sits at the foundation of the reactivity system.

Signals hold a single, mutable **value** that can be read or modified. When a signal's value
is updated, any active computations (like [Computed](/types/computed)) or effects (like [effect](/types/effect)) that
read the signal's value inside their execution context are automatically notified and scheduled to re-run.

Under the hood, this establishes a reactive dependency graph where reading a signal registers the reader as a
"target", and updating a signal triggers direct, glitch-free propagation to all registered targets.

<Info>
  Accessing <code>.value</code> inside a reactive context (like <code>effect</code> or <code>computed</code>) registers a dependency. Reading a value
  outside a reactive context behaves like a standard getter without creating a subscription.
</Info>

### Example Usage

#### 1. Basic Reactive Flow
```dart
import 'package:preact_signals/preact_signals.dart';

void main() {
  final count = Signal(0);

  // The effect automatically subscribes to count.value
  effect(() {
    print('Count is: ${count.value}');
  });

  count.value = 5; // Triggers print: Count is: 5
}
```

#### 2. Controlling Subscriptions via <code>.peek()</code>
If you need to read a signal's value without subscribing to updates, use the <code>.peek()</code> method:
```dart
final count = Signal(0);
final threshold = Signal(10);

effect(() {
  // Subscribes to count, but NOT to threshold
  if (count.value >= threshold.peek()) {
    print('Threshold reached!');
  }
});
```

### Members of Signal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **globalId** | <code>field</code> | <code>dart int globalId</code> |  |
| **name** | <code>field</code> | <code>dart String? name</code> |  |
| **watched** | <code>field</code> | <code>dart void Function()? watched</code> |  |
| **unwatched** | <code>field</code> | <code>dart void Function()? unwatched</code> |  |
| **equalityCheck** | <code>method</code> | <code>dart SignalEquality<T> equalityCheck</code> | Get the active equality check |
| **isInitialized** | <code>method</code> | <code>dart bool isInitialized</code> | Check if the value is set and not a lazy signal |
| **internalValue** | <code>method</code> | <code>dart T internalValue</code> |  |
| **Signal** | <code>constructor</code> | <code>dart Signal(this._internalValue, {String? name, void Function()? watched, void Function()? unwatched, ReadonlySignalOptions<T>? options, SignalEquality<T>? equality})</code> | Creates a new [Signal](/types/signal) instance with the given initial value. |
| **Signal.lazy** | <code>constructor</code> | <code>dart Signal.lazy({String? name, void Function()? watched, void Function()? unwatched, ReadonlySignalOptions<T>? options, SignalEquality<T>? equality})</code> | Creates a new lazy [Signal](/types/signal) instance that is computed on-demand upon first read. |
| **version** | <code>field</code> | <code>dart int version</code> | Version numbers should always be >= 0, because the special value -1 is used |
| **internalRefresh** | <code>method</code> | <code>dart bool internalRefresh()</code> |  |
| **subscribeToNode** | <code>method</code> | <code>dart void subscribeToNode(Node node)</code> |  |
| **unsubscribeFromNode** | <code>method</code> | <code>dart void unsubscribeFromNode(Node node)</code> |  |
| **subscribe** | <code>method</code> | <code>dart void Function() subscribe(void Function(T value) fn)</code> |  |
| **value** | <code>method</code> | <code>dart T value</code> | Gets the current value of the signal. |
| **value** | <code>method</code> | <code>dart value(T val)</code> | Sets the current value of the signal. |
| **set** | <code>method</code> | <code>dart bool set(T val, {bool force = false})</code> | Updates the signal's value by method call. |

## Class: Signal

Simple writeable signal

### Members of Signal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **Signal** | <code>constructor</code> | <code>dart Signal(super.internalValue, {SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel})</code> | Simple writeable signal. |
| **Signal.lazy** | <code>constructor</code> | <code>dart Signal.lazy({SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel})</code> | Lazy signal that can be created with type T that |
| **debugLabel** | <code>method</code> | <code>dart String? debugLabel</code> |  |
| **equalityCheck** | <code>method</code> | <code>dart signals.SignalEquality<T> equalityCheck</code> | Optional method to check if to values are the same |
| **set** | <code>method</code> | <code>dart bool set(T val, {bool force = false})</code> |  |
| **value** | <code>method</code> | <code>dart T value</code> |  |
| **readonly** | <code>method</code> | <code>dart ReadonlySignal<T> readonly()</code> | Returns a readonly signal |
| **unsubscribeFromNode** | <code>method</code> | <code>dart void unsubscribeFromNode(Node node)</code> |  |
| **overrideWith** | <code>method</code> | <code>dart Signal<T> overrideWith(T val)</code> | Override the current signal with a new value as if it was created with it. |

## Function: signal

```dart
Signal<T> signal(T value, {SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel})
```

A <code>Signal</code> is a reactive container for a value that changes over time. It forms the bedrock of the reactive framework, allowing fine-grained, glitch-free propagation of state updates to dependent computeds and effects.

You can read a signal's current state, mutate it to dispatch updates, or subscribe to changes by accessing its <code>.value</code> property inside any active reactive context.

### Core Example
```dart
import 'package:signals/signals.dart';

// Create a reactive signal holding an integer
final counter = signal(0);

// Read the value: prints 0
print(counter.value);

// Write to a signal: dispatches updates to all downstreams synchronously
counter.value = 1;
```

---

## Key API Capabilities

### 1. Reading & Writing via <code>.value</code>
The <code>.value</code> property is the default way to interact with a signal.
- **Inside a Reactive Context:** Accessing <code>.value</code> inside a [computed](/types/computed) block or [effect](/types/effect) callback automatically registers the signal as a dependency, establishing an active subscription.
- **Outside a Reactive Context:** Acts as a standard getter and setter, allowing you to fetch or update the underlying state.

### 2. Non-reactive Reads via <code>.peek()</code>
If you need to read a signal's current value *without* subscribing to its updates inside a reactive context, use the <code>.peek()</code> method. This is invaluable when writing to another signal inside an effect based on the previous state, preventing infinite update loops (cycles).

```dart
final counter = signal(0);
final effectTriggerCount = signal(0);

effect(() {
  // Subscribes to changes of `counter`
  final current = counter.value;
  print('Counter updated: $current');

  // Read current count non-reactively and increment.
  // The effect will NOT subscribe to `effectTriggerCount`.
  effectTriggerCount.value = effectTriggerCount.peek() + 1;
});
```

### 3. Accessing the Previous State via <code>.previousValue</code>
Signals automatically cache their immediately preceding value. Accessing <code>.previousValue</code> lets you perform diffing or historic analysis. Like <code>.peek()</code>, reading <code>.previousValue</code> does not establish a reactive dependency.

```dart
final username = signal("initial_user");

effect(() {
  print('Current Username: ${username.value}');
  print('Previous Username: ${username.previousValue}');
});

username.value = "new_user";
// Prints:
// Current Username: new_user
// Previous Username: initial_user
```

### 4. Force Updates via <code>.set()</code>
When dealing with mutable data types (e.g., custom class instances, collections), mutating properties directly does not change the instance reference. You can force an update using <code>.set(..., force: true)</code> to skip standard equality checks and notify all downstreams.

```dart
final numbers = signal([1, 2, 3]);

// Modify the list in-place and force notify
numbers.value.add(4);
numbers.set(numbers.value, force: true);
```

---

## Lifecycle & Resource Management

### Auto-Disposal
If a signal is constructed with <code>autoDispose: true</code>, it will automatically destroy itself when it no longer has active reactive listeners (subscriptions). This prevents memory leaks by freeing resources as soon as they are out of scope.

```dart
final s = signal(0, options: SignalOptions(autoDispose: true));

s.onDispose(() => print('Signal has been disposed!'));

// Create active subscriber
final dispose = s.subscribe((_) {});

// Cancel subscription: s has no listeners, so it self-disposes
dispose();
// Prints: "Signal has been disposed!"
```

You can manually verify the lifecycle state using <code>.disposed</code>, or register custom clean-up routines via <code>.onDispose(callback)</code>.

---

## Flutter Integration
In Flutter applications, manage state and reactivity seamlessly by using [SignalWidget](/types/signalwidget) (for stateless widgets) or [SignalStatefulWidget](/types/signalstatefulwidget) (for stateful widgets).
These widgets establish an implicit reactive context directly at the element layer. Any signal accessed via <code>.value</code> inside the <code>build</code> method is automatically tracked, and the widget automatically rebuilds when they mutate.

### Stateless Example with [SignalWidget](/types/signalwidget)
```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

final counter = signal(0);

class CounterDisplay extends SignalWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: ${counter.value}'),
            ElevatedButton(
              onPressed: () => counter.value++,
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Stateful Example with [SignalStatefulWidget](/types/signalstatefulwidget)
```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class CounterDisplay extends SignalStatefulWidget {
  const CounterDisplay({super.key});

  @override
  State<CounterDisplay> createState() => _CounterDisplayState();
}

class _CounterDisplayState extends State<CounterDisplay> {
  // Local signal scoped to this widget state:
  final counter = signal(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: ${counter.value}'),
            ElevatedButton(
              onPressed: () => counter.value++,
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Testing Strategies

### 1. Converting to Streams
You can convert any reactive signal into a standard Dart **Stream** by calling <code>.toStream()</code>. This is highly beneficial for testing signal value sequences in order using test matchers.

```dart
test('emits sequential count updates in order', () async {
  final counter = signal(0);
  final stream = counter.toStream();

  counter.value = 1;
  counter.value = 2;

  await expectLater(stream, emitsInOrder([0, 1, 2]));
});
```

### 2. Dependency Injection & Mock Overrides
Global or lazy signals used across your application can be mocked or overridden during testing via <code>.overrideWith(value)</code>. This returns a new signal sharing the same global identifier, helping you mock complex state dependencies seamlessly.

```dart
test('mocking global signals', () {
  final apiToken = signal("production_token");

  // Override with test mock token
  apiToken.overrideWith("mock_test_token");

  expect(apiToken.value, "mock_test_token");
});
```

## Function: signal

```dart
FlutterSignal<T> signal(T value, {core.SignalOptions<T>? options, @Deprecated('Use options: SignalOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: SignalOptions(autoDispose: ...) instead') bool? autoDispose, bool runCallbackOnListen = false})
```

Creates a mutable, reactive [FlutterSignal](/types/fluttersignal) initialized with the given **value**.

When the value changes, all registered builders, effects, and **ValueNotifier** listeners
are automatically scheduled to update/rebuild.

### Flutter Widget Example

```dart
final count = signal(0);

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SignalBuilder(
          builder: (context) => Text('Count: ${count.value}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => count.value++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

## Function: signal

```dart
Signal<T> signal(T value, [SignalOptions<T>? options])
```

Convenient global constructor for creating a mutable reactive state signal.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);
final name = signal('Jane');
```

## References

The **Signal** type is referenced and used in the following pages:

* [Persisted Signals](/guides/persisted-signals) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [Dependency Injection](/guides/dependency-injection) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [Bi-directional Data Flow](/guides/bi-directional-data-flow) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [ValueNotifier](/guides/value-notifier) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [Untracked](/packages/signals_flutter/core/untracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [LinkedSignal](/packages/signals_flutter/core/linked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Effect](/packages/signals_flutter/core/effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [ReadonlySignal](/packages/signals_flutter/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Computed](/packages/signals_flutter/core/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Action](/packages/signals_flutter/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Batch](/packages/signals_flutter/core/batch) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [MapSignalMixin](/packages/signals_flutter/mixins/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [TrackedSignalMixin](/packages/signals_flutter/mixins/tracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [SetSignalMixin](/packages/signals_flutter/mixins/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [ListSignalMixin](/packages/signals_flutter/mixins/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [ValueNotifierSignalMixin](/packages/signals_flutter/mixins/value-notifier-signal-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [SinkSignalMixin](/packages/signals_flutter/mixins/sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [QueueSignalMixin](/packages/signals_flutter/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [IterableSignalMixin](/packages/signals_flutter/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [EventSinkSignalMixin](/packages/signals_flutter/mixins/event-sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [StreamSignalMixin](/packages/signals_flutter/mixins/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [ChangeStackSignalMixin](/packages/signals_flutter/mixins/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [FlutterComputed](/packages/signals_flutter/signals/flutter-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/signals)</span>
* [Ticker Signal](/packages/signals_flutter/signals/ticker-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/signals)</span>
* [FlutterSignal](/packages/signals_flutter/signals/flutter-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/signals)</span>
* [Flutter Readonly Signal](/packages/signals_flutter/signals/flutter-readonly-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/signals)</span>
* [AsyncState](/packages/signals_flutter/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [FutureSignal](/packages/signals_flutter/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [AsyncSignal](/packages/signals_flutter/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Computed](/packages/signals_flutter/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Connect](/packages/signals_flutter/async/connect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Stream](/packages/signals_flutter/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [MapSignal](/packages/signals_flutter/value/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [SetSignal](/packages/signals_flutter/value/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [ListSignal](/packages/signals_flutter/value/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [IterableSignal](/packages/signals_flutter/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [ChangeStackSignal](/packages/signals_flutter/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [RenderSignalBox](/packages/signals_flutter/render/render-signal-box) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/render)</span>
* [Signal Value Listenable Utils](/packages/signals_flutter/extensions/signal-value-listenable-utils) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [Stateful Element Convert Extension](/packages/signals_flutter/extensions/stateful-element-convert-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [SignalStatefulElement](/packages/signals_flutter/extensions/signal-stateful-element) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [Stateful Widget Convert Widget Extension](/packages/signals_flutter/extensions/stateful-widget-convert-widget-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [SignalCustomPainter](/packages/signals_flutter/extensions/signal-custom-painter) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [Stateless Widget Convert Widget Extension](/packages/signals_flutter/extensions/stateless-widget-convert-widget-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [Signal Value Notifier Utils](/packages/signals_flutter/extensions/signal-value-notifier-utils) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [SignalElement](/packages/signals_flutter/extensions/signal-element) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [Value Listenable To Signal](/packages/signals_flutter/extensions/value-listenable-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [Stateless Element Convert Extension](/packages/signals_flutter/extensions/stateless-element-convert-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [Value Notifier To Signal](/packages/signals_flutter/extensions/value-notifier-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [SignalStatefulWidget](/packages/signals_flutter/extensions/signal-stateful-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [SignalEquality](/packages/signals_flutter/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [Model](/packages/signals_flutter/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [SignalContainer](/packages/signals_flutter/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [SignalsObserver](/packages/signals_flutter/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [PersistedSignal](/packages/signals_flutter/utilities/persisted) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalEffect](/packages/signals_flutter/effects/signal-effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/effects)</span>
* [SignalPainterWidget](/packages/signals_flutter/widgets/signal-painter-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [WatchBuilder](/packages/signals_flutter/widgets/watch-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [Watch](/packages/signals_flutter/widgets/watch) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalWidget](/packages/signals_flutter/widgets/signal-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalBuilder](/packages/signals_flutter/widgets/signal-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalAnimatedBuilder](/packages/signals_flutter/widgets/signal-animated-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [SignalProvider](/packages/signals_flutter/widgets/signal-provider) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/widgets)</span>
* [Untracked](/packages/signals_core/core/untracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [LinkedSignal](/packages/signals_core/core/linked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Effect](/packages/signals_core/core/effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [ReadonlySignal](/packages/signals_core/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Computed](/packages/signals_core/core/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Action](/packages/signals_core/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Batch](/packages/signals_core/core/batch) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [MapSignalMixin](/packages/signals_core/mixins/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [TrackedSignalMixin](/packages/signals_core/mixins/tracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [SetSignalMixin](/packages/signals_core/mixins/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [ListSignalMixin](/packages/signals_core/mixins/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [SinkSignalMixin](/packages/signals_core/mixins/sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [QueueSignalMixin](/packages/signals_core/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [IterableSignalMixin](/packages/signals_core/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [EventSinkSignalMixin](/packages/signals_core/mixins/event-sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [StreamSignalMixin](/packages/signals_core/mixins/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [ChangeStackSignalMixin](/packages/signals_core/mixins/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [AsyncState](/packages/signals_core/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [FutureSignal](/packages/signals_core/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [AsyncSignal](/packages/signals_core/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [Computed](/packages/signals_core/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [Connect](/packages/signals_core/async/connect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [Stream](/packages/signals_core/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [MapSignal](/packages/signals_core/value/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [SetSignal](/packages/signals_core/value/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [ListSignal](/packages/signals_core/value/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [IterableSignal](/packages/signals_core/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [ChangeStackSignal](/packages/signals_core/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [SignalEquality](/packages/signals_core/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [Model](/packages/signals_core/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [SignalContainer](/packages/signals_core/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [SignalsObserver](/packages/signals_core/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [PersistedSignal](/packages/signals_core/utilities/persisted) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [signals_core](/packages/signals_core)
* [SignalsAvoidCreateInBuildMethod](/packages/signals_lint/flutter/signals-avoid-create-in-build-method) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [SignalsPreferUnifiedOptions](/packages/signals_lint/flutter/signals-prefer-unified-options) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [signals_lint](/packages/signals_lint)
* [SignalsDevToolsExtension](/packages/signals_devtools_extension/flutter/devtools) <span style="opacity: 0.6; font-size: 0.85em;">(signals_devtools_extension/flutter)</span>
* [signals_devtools_extension](/packages/signals_devtools_extension)
* [Untracked](/packages/signals/core/untracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [LinkedSignal](/packages/signals/core/linked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Effect](/packages/signals/core/effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [ReadonlySignal](/packages/signals/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Computed](/packages/signals/core/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Action](/packages/signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Batch](/packages/signals/core/batch) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [MapSignalMixin](/packages/signals/mixins/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [TrackedSignalMixin](/packages/signals/mixins/tracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [SetSignalMixin](/packages/signals/mixins/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [ListSignalMixin](/packages/signals/mixins/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [ValueNotifierSignalMixin](/packages/signals/mixins/value-notifier-signal-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [SinkSignalMixin](/packages/signals/mixins/sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [QueueSignalMixin](/packages/signals/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [IterableSignalMixin](/packages/signals/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [EventSinkSignalMixin](/packages/signals/mixins/event-sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [StreamSignalMixin](/packages/signals/mixins/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [ChangeStackSignalMixin](/packages/signals/mixins/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [FlutterComputed](/packages/signals/signals/flutter-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals/signals)</span>
* [Ticker Signal](/packages/signals/signals/ticker-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/signals)</span>
* [FlutterSignal](/packages/signals/signals/flutter-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/signals)</span>
* [Flutter Readonly Signal](/packages/signals/signals/flutter-readonly-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/signals)</span>
* [AsyncState](/packages/signals/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [FutureSignal](/packages/signals/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [AsyncSignal](/packages/signals/async/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [Computed](/packages/signals/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [Connect](/packages/signals/async/connect) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [Stream](/packages/signals/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [MapSignal](/packages/signals/value/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [SetSignal](/packages/signals/value/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [ListSignal](/packages/signals/value/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [IterableSignal](/packages/signals/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [ChangeStackSignal](/packages/signals/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [RenderSignalBox](/packages/signals/render/render-signal-box) <span style="opacity: 0.6; font-size: 0.85em;">(signals/render)</span>
* [Signal Value Listenable Utils](/packages/signals/extensions/signal-value-listenable-utils) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [Stateful Element Convert Extension](/packages/signals/extensions/stateful-element-convert-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [SignalStatefulElement](/packages/signals/extensions/signal-stateful-element) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [Lazy Signal](/packages/signals/extensions/lazy-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [Stateful Widget Convert Widget Extension](/packages/signals/extensions/stateful-widget-convert-widget-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [SignalCustomPainter](/packages/signals/extensions/signal-custom-painter) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [Stateless Widget Convert Widget Extension](/packages/signals/extensions/stateless-widget-convert-widget-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [Signal Value Notifier Utils](/packages/signals/extensions/signal-value-notifier-utils) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [SignalElement](/packages/signals/extensions/signal-element) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [Value Listenable To Signal](/packages/signals/extensions/value-listenable-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [Stateless Element Convert Extension](/packages/signals/extensions/stateless-element-convert-extension) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [Value Notifier To Signal](/packages/signals/extensions/value-notifier-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [SignalStatefulWidget](/packages/signals/extensions/signal-stateful-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [SignalEquality](/packages/signals/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [Model](/packages/signals/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [SignalContainer](/packages/signals/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [SignalsObserver](/packages/signals/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [PersistedSignal](/packages/signals/utilities/persisted) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals](/packages/signals)
* [SignalEffect](/packages/signals/effects/signal-effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals/effects)</span>
* [SignalPainterWidget](/packages/signals/widgets/signal-painter-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [WatchBuilder](/packages/signals/widgets/watch-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [Watch](/packages/signals/widgets/watch) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [SignalWidget](/packages/signals/widgets/signal-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [SignalBuilder](/packages/signals/widgets/signal-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [SignalAnimatedBuilder](/packages/signals/widgets/signal-animated-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [SignalProvider](/packages/signals/widgets/signal-provider) <span style="opacity: 0.6; font-size: 0.85em;">(signals/widgets)</span>
* [signals_hooks](/packages/signals_hooks)
* [useIterableSignal](/packages/signals_hooks/hooks/use-iterable-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useLazySignal](/packages/signals_hooks/hooks/use-lazy-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useConnect](/packages/signals_hooks/hooks/use-connect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useValueNotifierToSignal](/packages/signals_hooks/hooks/use-value-notifier-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useValueListenableToSignal](/packages/signals_hooks/hooks/use-value-listenable-to-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useListSignal](/packages/signals_hooks/hooks/use-list-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useQueueSignal](/packages/signals_hooks/hooks/use-queue-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useSignal](/packages/signals_hooks/hooks/use-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useSignalValue](/packages/signals_hooks/hooks/use-signal-value) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useStreamSignal](/packages/signals_hooks/hooks/use-stream-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useSetSignal](/packages/signals_hooks/hooks/use-set-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useLinkedSignal](/packages/signals_hooks/hooks/use-linked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useChangeStackSignal](/packages/signals_hooks/hooks/use-change-stack-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useTrackedSignal](/packages/signals_hooks/hooks/use-tracked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useExistingSignal](/packages/signals_hooks/hooks/use-existing-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useAsyncSignal](/packages/signals_hooks/hooks/use-async-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useComputed](/packages/signals_hooks/hooks/use-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useSignalProvider](/packages/signals_hooks/hooks/use-signal-provider) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useFutureSignal](/packages/signals_hooks/hooks/use-future-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useAsyncComputed](/packages/signals_hooks/hooks/use-async-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useSignalEffect](/packages/signals_hooks/hooks/use-signal-effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useMapSignal](/packages/signals_hooks/hooks/use-map-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [SignalStatefulHookWidget](/packages/signals_hooks/widgets/signal-stateful-hook-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/widgets)</span>
* [SignalHookBuilder](/packages/signals_hooks/widgets/signal-hook-builder) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/widgets)</span>
* [SignalHookWidget](/packages/signals_hooks/widgets/signal-hook-widget) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/widgets)</span>
* [Untracked](/packages/preact_signals/core/untracked) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [Effect](/packages/preact_signals/core/effect) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [ReadonlySignal](/packages/preact_signals/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [Signal](/packages/preact_signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [Computed](/packages/preact_signals/core/computed) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [Action](/packages/preact_signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [Batch](/packages/preact_signals/core/batch) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [SignalEquality](/packages/preact_signals/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/utilities)</span>
* [Model](/packages/preact_signals/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/utilities)</span>
* [preact_signals](/packages/preact_signals)
* [Overview](/reference/overview) <span style="opacity: 0.6; font-size: 0.85em;">(reference)</span>
* [AI Integration](/reference/ai) <span style="opacity: 0.6; font-size: 0.85em;">(reference)</span>

