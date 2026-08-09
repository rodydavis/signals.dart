---
title: "Type: Computed"
description: "API reference and details for Computed from signals.dart."
---

# Computed

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: Computed

A <code>Computed</code> signal represents derived reactive state. It combines the values of multiple dependency signals into a new read-only signal, automatically re-evaluating whenever any of its dependencies mutate.

Computed signals are **lazily evaluated** and **memoized** by default:
- **Lazy Evaluation:** The computed callback is only executed when the computed signal is actively read or listened to.
- **Memoization:** The computed signal caches its return value and will not re-run its callback if its dependency values have not changed or if no active listeners exist.
- **Glitch-Free Propagation:** The reactive graph updates topologically. This guarantees that intermediate "glitches" (inconsistent state views) are physically impossible during multiple simultaneous signal updates.

### Core Example
```dart
import 'package:signals/signals.dart';

final firstName = signal("Jane");
final lastName = signal("Doe");

// Create a derived computed signal
final fullName = computed(() => "${firstName.value} ${lastName.value}");

// Accessing .value: prints "Jane Doe"
print(fullName.value);

// Update a dependency: fullName will automatically reflect changes on next read
firstName.value = "John";
print(fullName.value); // Prints "John Doe"
```

Any signal accessed inside the computed callback block is automatically registered as a dependency.

---

## Key API Capabilities

### 1. Forcing Re-evaluation via <code>.recompute()</code>
In advanced scenarios where a computed value depends on external, non-reactive variables, you can force the computed block to discard its cache and re-evaluate immediately using <code>.recompute()</code>.

```dart
final externalTime = DateTime.now();
final timeString = computed(() {
  return "Time: ${externalTime.toIso8601String()}";
});

// Force re-runs the callback
timeString.recompute();
```

### 2. Resource Management & Disposal
Like standard signals, a computed signal can be configured to automatically garbage-collect itself when it has no active subscribers.

- **Auto-Dispose:** Set <code>autoDispose: true</code> in the options. The computed signal will release its cached value, clear all dependency listeners, and enter a frozen state once all active subscriptions are terminated.
- **Lifecyle Callbacks:** Register custom routines via <code>.onDispose(callback)</code> to clean up external streams or resources used within the computed block.

```dart
final s = computed(
  () => 42,
  options: ComputedOptions(autoDispose: true),
);

s.onDispose(() => print('Computed destroyed'));

final dispose = s.subscribe((_) {});
dispose(); // Prints: "Computed destroyed"
```

---

## Flutter Integration
In Flutter applications, manage derived/computed state seamlessly by utilizing [SignalStatefulWidget](/types/signalstatefulwidget) (for state-bound signals and computeds) or [SignalWidget](/types/signalwidget).
Computed signals accessed via <code>.value</code> inside the <code>build</code> method are automatically tracked, ensuring the widget rebuilds only when the computed value changes.

```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class EvenOddWidget extends SignalStatefulWidget {
  const EvenOddWidget({super.key});

  @override
  State<EvenOddWidget> createState() => _EvenOddWidgetState();
}

class _EvenOddWidgetState extends State<EvenOddWidget> {
  final counter = signal(0);

  // Derived state tied directly to the State object lifecycle
  late final isEven = computed(() => counter.value.isEven);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Rebuilds implicitly when isEven.value changes
        child: Text('Is Even: ${isEven.value}'),
      ),
    );
  }
}
```

---

## Testing Strategies
Testing derived computed states is extremely straightforward. You can easily test them directly as raw values or sequence them in asynchronous flows by converting the computed signal into a Dart stream via <code>.toStream()</code>.

```dart
test('computed stream emissions', () async {
  final a = signal(0);
  final doubleVal = computed(() => a.value * 2);
  final stream = doubleVal.toStream();

  a.value = 1;
  a.value = 2;

  await expectLater(stream, emitsInOrder([0, 2, 4]));
});
```
You can also override the initial value of a computed signal when testing. This is is useful for mocking and testing specific value implementations.

```dart
test('test with override', () {
    final a = signal(0);
    final s = computed(() => a()).overrideWith(-1);

    final stream = s.toStream();

    a.value = 1;
    a.value = 2;
    a.value = 2; // check if skipped
    a.value = 3;

    expect(stream, emitsInOrder([-1, 1, 2, 3]));
});
```

<code>overrideWith</code> returns a new computed signal with the same global id sets the value as if the computed callback returned it.

### Members of Computed

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **Computed** | <code>constructor</code> | <code>dart Computed(super.fn, {ComputedOptions<T>? options, @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ComputedOptions(name: ...) instead') String? debugLabel})</code> | Data is often derived from other pieces of existing data. The <code>computed</code> function lets you combine the values of multiple signals into a new signal that can be reacted to, or even used by additional computeds. When the signals accessed from within a computed callback change, the computed callback is re-executed and its new return value becomes the computed signal's value. |
| **overrideWith** | <code>method</code> | <code>dart Computed<T> overrideWith(T val)</code> | Override the current signal with a new value as if it was created with it. |
| **debugLabel** | <code>method</code> | <code>dart String? debugLabel</code> |  |
| **recompute** | <code>method</code> | <code>dart void recompute()</code> | Call the computed function and update the value |
| **dispose** | <code>method</code> | <code>dart void dispose()</code> |  |
| **readonly** | <code>method</code> | <code>dart ReadonlySignal<T> readonly()</code> | Returns a readonly signal |
| **unsubscribeFromNode** | <code>method</code> | <code>dart void unsubscribeFromNode(Node node)</code> |  |
| **value** | <code>method</code> | <code>dart T value</code> |  |
| **internalValue** | <code>method</code> | <code>dart internalValue(T value)</code> |  |

## Class: Computed

Represents a derived, read-only reactive state value computed from one or more other signals.

Computed signals are **lazily evaluated** and **memoized (cached)**. Their callback function **fn**
is only executed when its value is read *and* one of its upstream dependencies has mutated since the
last calculation. If none of the dependencies have changed, the cached value is returned directly.

Under the hood, a <code>Computed</code> signal tracks its sources dynamically. If a conditional branch inside
the computation changes such that certain signals are no longer read, those signals are automatically pruned
from the dependency list, preventing redundant triggers.

<Warning>
  The computation callback <strong>fn</strong> should be <strong>pure</strong> and side-effect free. Writing to other signals or
  performing network/database operations inside a computed callback is a critical anti-pattern that can lead to
  infinite loops (cycles) or unpredictable state transitions.
</Warning>

### Example Usage

#### 1. Basic Derived State
```dart
import 'package:preact_signals/preact_signals.dart';

void main() {
  final firstName = Signal('Jane');
  final lastName = Signal('Doe');

  // Computed automatically tracks both firstName and lastName
  final fullName = Computed(() => '${firstName.value} ${lastName.value}');

  print(fullName.value); // Jane Doe
  lastName.value = 'Smith';
  print(fullName.value); // Jane Smith
}
```

#### 2. Dynamic Dependency Tracking (Branching)
```dart
final showFull = Signal(false);
final detailedInfo = Signal('High Latency Alert');
final briefInfo = Signal('Alert');

final message = Computed(() {
  if (showFull.value) {
    return detailedInfo.value; // Subscribes to detailedInfo
  } else {
    return briefInfo.value; // Subscribes to briefInfo
  }
});
```

### Members of Computed

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **globalId** | <code>field</code> | <code>dart int globalId</code> |  |
| **name** | <code>field</code> | <code>dart String? name</code> |  |
| **watched** | <code>field</code> | <code>dart void Function()? watched</code> |  |
| **unwatched** | <code>field</code> | <code>dart void Function()? unwatched</code> |  |
| **flags** | <code>field</code> | <code>dart int flags</code> |  |
| **isInitialized** | <code>method</code> | <code>dart bool isInitialized</code> | Check if the value has been computed |
| **internalValue** | <code>method</code> | <code>dart T internalValue</code> |  |
| **Computed** | <code>constructor</code> | <code>dart Computed(this.fn, {String? name, void Function()? watched, void Function()? unwatched, ComputedOptions<T>? options})</code> | Creates a new [Computed](/types/computed) signal instance with the derivation callback **fn**. |
| **internalRefresh** | <code>method</code> | <code>dart bool internalRefresh()</code> |  |
| **subscribeToNode** | <code>method</code> | <code>dart void subscribeToNode(Node node)</code> |  |
| **unsubscribeFromNode** | <code>method</code> | <code>dart void unsubscribeFromNode(Node node)</code> |  |
| **notify** | <code>method</code> | <code>dart void notify()</code> |  |
| **value** | <code>method</code> | <code>dart T value</code> |  |
| **version** | <code>field</code> | <code>dart int version</code> |  |
| **subscribe** | <code>method</code> | <code>dart void Function() subscribe(void Function(T value) fn)</code> |  |

## Function: computed

```dart
Computed<T> computed(ComputedCallback<T> compute, {ComputedOptions<T>? options, @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ComputedOptions(name: ...) instead') String? debugLabel})
```

Data is often derived from other pieces of existing data. The <code>computed</code> function lets you combine the values of multiple signals into a new signal that can be reacted to, or even used by additional computeds. When the signals accessed from within a computed callback change, the computed callback is re-executed and its new return value becomes the computed signal's value.

> <code>Computed</code> class extends the [<code>Signal</code>](/core/signal/) class, so you can use it anywhere you would use a signal.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");

final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
print(fullName.value);

// Updates flow through computed, but only if someone
// subscribes to it. More on that later.
name.value = "John";
// Logs: "John Doe"
print(fullName.value);
```

Any signal that is accessed inside the <code>computed</code>'s callback function will be automatically subscribed to and tracked as a dependency of the computed signal.

> Computed signals are both lazily evaluated and memoized

## Force Re-evaluation

You can force a computed signal to re-evaluate by calling its <code>.recompute</code> method. This will re-run the computed callback and update the computed signal's value.

```dart
final name = signal("Jane");
final surname = signal("Doe");
final fullName = computed(() => name.value + " " + surname.value);

fullName.recompute(); // Re-runs the computed callback
```

## Disposing

### Auto Dispose

If a computed signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.

```dart
final s = computed(() => 0, autoDispose: true);
s.onDispose(() => print('Signal destroyed'));
final dispose = s.subscribe((_) {});
dispose();
final value = s.value; // 0
// prints: Signal destroyed
```

A auto disposing signal does not require its dependencies to be auto disposing. When it is disposed it will freeze its value and stop tracking its dependencies.

This means that it will no longer react to changes in its dependencies.

```dart
final s = computed(() => 0);
s.dispose();
final value = s.value; // 0
final b = computed(() => s.value); // 0
// b will not react to changes in s
```

You can check if a signal is disposed by calling the <code>.disposed</code> method.

```dart
final s = computed(() => 0);
print(s.disposed); // false
s.dispose();
print(s.disposed); // true
```

### On Dispose Callback

You can attach a callback to a signal that will be called when the signal is destroyed.

```dart
final s = computed(() => 0);
s.onDispose(() => print('Signal destroyed'));
s.dispose();
```


## Flutter

In Flutter applications, manage derived/computed state seamlessly by utilizing [SignalStatefulWidget](/types/signalstatefulwidget) (for state-bound signals and computeds) or [SignalWidget](/types/signalwidget).
Computed signals accessed via <code>.value</code> inside the <code>build</code> method are automatically tracked, ensuring the widget rebuilds only when the computed value changes.

```dart
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class CounterWidget extends SignalStatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  final counter = signal(0);
  late final isEven = computed(() => counter.value.isEven);
  late final isOdd = computed(() => counter.value.isOdd);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: even=${isEven.value}, odd=${isOdd.value}'),
            ElevatedButton(
              onPressed: () => counter.value++,
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

No manual <code>Watch</code> widget or context extension is needed; the widget automatically rebuilds when any tracked signal mutates.

## Testing

Testing computed signals is possible by converting a computed to a stream and testing it like any other stream in Dart.

```dart
test('test as stream', () {
    final a = signal(0);
    final s = computed(() => a());
    final stream = s.toStream();

    a.value = 1;
    a.value = 2;
    a.value = 3;

    expect(stream, emitsInOrder([0, 1, 2, 3]));
});
```

<code>emitsInOrder</code> is a matcher that will check if the stream emits the values in the correct order which in this case is each value after a signal is updated.

You can also override the initial value of a computed signal when testing. This is is useful for mocking and testing specific value implementations.

```dart
test('test with override', () {
    final a = signal(0);
    final s = computed(() => a()).overrideWith(-1);

    final stream = s.toStream();

    a.value = 1;
    a.value = 2;
    a.value = 2; // check if skipped
    a.value = 3;

    expect(stream, emitsInOrder([-1, 1, 2, 3]));
});
```

<code>overrideWith</code> returns a new computed signal with the same global id sets the value as if the computed callback returned it.

## Function: computed

```dart
FlutterComputed<T> computed(T Function() compute, {core.ComputedOptions<T>? options, @Deprecated('Use options: ComputedOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: ComputedOptions(autoDispose: ...) instead') bool? autoDispose, bool runCallbackOnListen = false})
```

Creates a new [FlutterComputed](/types/fluttercomputed) signal that recalculates its value dynamically
based on the signals accessed inside the **compute** callback.

The returned computed signal is read-only and cached. It will only re-evaluate
when one of its tracked dependencies changes.

### Flutter Example

```dart
final firstName = signal('John');
final lastName = signal('Doe');

// Automatically combines both signals and caches the result:
final fullName = computed(() => '${firstName.value} ${lastName.value}');

// Usage inside a widget build:
@override
Widget build(BuildContext context) {
  return SignalBuilder(
    builder: (context) => Text('Hello, ${fullName.value}!'),
  );
}
```

## Function: computed

```dart
ReadonlySignal<T> computed(T Function() fn, [ComputedOptions<T>? options])
```

Convenient global constructor for creating a derived computed signal.

Computed signals are lazily evaluated and cached (memoized). Their values
automatically update when any dependency signals accessed inside the callback function change.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final firstName = signal('Jane');
final lastName = signal('Doe');

final fullName = computed(() => '${firstName.value} ${lastName.value}');

void main() {
  print(fullName.value); // Prints: Jane Doe
}
```

## References

The **Computed** type is referenced and used in the following pages:

* [Signals.dart](/)
* [Dependency Injection](/guides/dependency-injection) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [ValueNotifier](/guides/value-notifier) <span style="opacity: 0.6; font-size: 0.85em;">(guides)</span>
* [Untracked](/packages/signals_flutter/core/untracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [LinkedSignal](/packages/signals_flutter/core/linked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [ReadonlySignal](/packages/signals_flutter/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Computed](/packages/signals_flutter/core/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Action](/packages/signals_flutter/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Batch](/packages/signals_flutter/core/batch) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [FlutterComputed](/packages/signals_flutter/signals/flutter-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/signals)</span>
* [AsyncState](/packages/signals_flutter/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Computed](/packages/signals_flutter/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [MapSignal](/packages/signals_flutter/value/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [SetSignal](/packages/signals_flutter/value/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [ListSignal](/packages/signals_flutter/value/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [IterableSignal](/packages/signals_flutter/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [SignalContainer](/packages/signals_flutter/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [SignalsObserver](/packages/signals_flutter/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [signals_flutter](/packages/signals_flutter)
* [Untracked](/packages/signals_core/core/untracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [LinkedSignal](/packages/signals_core/core/linked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [ReadonlySignal](/packages/signals_core/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Computed](/packages/signals_core/core/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Action](/packages/signals_core/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Batch](/packages/signals_core/core/batch) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [AsyncState](/packages/signals_core/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [Computed](/packages/signals_core/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [MapSignal](/packages/signals_core/value/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [SetSignal](/packages/signals_core/value/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [ListSignal](/packages/signals_core/value/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [IterableSignal](/packages/signals_core/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [SignalContainer](/packages/signals_core/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [SignalsObserver](/packages/signals_core/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [signals_core](/packages/signals_core)
* [SignalsAvoidCreateInBuildMethod](/packages/signals_lint/flutter/signals-avoid-create-in-build-method) <span style="opacity: 0.6; font-size: 0.85em;">(signals_lint/flutter)</span>
* [SignalsDevToolsExtension](/packages/signals_devtools_extension/flutter/devtools) <span style="opacity: 0.6; font-size: 0.85em;">(signals_devtools_extension/flutter)</span>
* [Untracked](/packages/signals/core/untracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [LinkedSignal](/packages/signals/core/linked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [ReadonlySignal](/packages/signals/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Computed](/packages/signals/core/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Action](/packages/signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Batch](/packages/signals/core/batch) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [FlutterComputed](/packages/signals/signals/flutter-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals/signals)</span>
* [AsyncState](/packages/signals/async/state) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [Computed](/packages/signals/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [MapSignal](/packages/signals/value/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [SetSignal](/packages/signals/value/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [ListSignal](/packages/signals/value/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [IterableSignal](/packages/signals/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [SignalContainer](/packages/signals/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [SignalsObserver](/packages/signals/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals](/packages/signals)
* [signals_hooks](/packages/signals_hooks)
* [useLinkedSignal](/packages/signals_hooks/hooks/use-linked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useComputed](/packages/signals_hooks/hooks/use-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useAsyncComputed](/packages/signals_hooks/hooks/use-async-computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [Untracked](/packages/preact_signals/core/untracked) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [ReadonlySignal](/packages/preact_signals/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [Signal](/packages/preact_signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [Computed](/packages/preact_signals/core/computed) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [Action](/packages/preact_signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [Batch](/packages/preact_signals/core/batch) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [preact_signals](/packages/preact_signals)
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-lint AI Skill](/skills/signals-lint) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-hooks AI Skill](/skills/signals-hooks) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-migration-6-to-7 AI Skill](/skills/signals-migration-6-to-7) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [Overview](/reference/overview) <span style="opacity: 0.6; font-size: 0.85em;">(reference)</span>
* [AI Integration](/reference/ai) <span style="opacity: 0.6; font-size: 0.85em;">(reference)</span>

