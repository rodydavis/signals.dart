---
title: "Type: Effect"
description: "API reference and details for Effect from signals.dart."
---

# Effect

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: Effect

An <code>Effect</code> is the passive consumer of the reactive model. It allows you to run arbitrary side-effects (such as logging, database writes, or UI rendering updates) whenever any of its tracked dependencies mutate.

Any signal accessed via <code>.value</code> inside the effect callback is automatically registered as a dependency. When a dependency changes, the effect is re-run.

### Core Example
```dart
import 'package:signals/signals.dart';

final counter = signal(0);

// Create an active effect: prints "Count: 0" immediately
final dispose = effect(() {
  print('Count: ${counter.value}');
});

// Updating the signal re-runs the effect: prints "Count: 1"
counter.value = 1;

// Clean up the effect to unsubscribe from updates
dispose();
```

---

## Key API Capabilities

### 1. Lifecycle Cleanup Callback
You can return an optional <code>void Function()</code> from the effect callback block. This cleanup function is automatically invoked the next time the effect is re-run, or when the effect is permanently disposed. This is perfect for cancelling timers, sockets, or other active event channels.

```dart
final counter = signal(0);

effect(() {
  final count = counter.value;
  final timer = Timer(Duration(seconds: 1), () => print('Timer fired for $count'));

  // Cleanup function called before re-run or dispose
  return () => timer.cancel();
});
```

### 2. Lifecycle Listeners via <code>onDispose</code>
You can attach explicit cleanup routines that run when the effect is destroyed by passing <code>onDispose</code> in the options or by calling <code>.onDispose(callback)</code> directly on the effect instance.

```dart
final counter = signal(0);
final dispose = effect(
  () => print(counter.value),
  options: EffectOptions(
    onDispose: () => print('Effect has been unmounted!'),
  ),
);

dispose(); // Prints: "Effect has been unmounted!"
```

---

## ⚠️ Warning: Preventing Cycles
Mutating a signal *directly* inside an effect that reads that same signal will cause an infinite loop (cycle), throwing a <code>StackOverflowError</code> or a cycle exception. To read a signal inside an effect without subscribing to its updates, wrap the read operation in <code>untracked()</code>.

```dart
final a = signal(0);
final b = signal(0);

effect(() {
  // Active subscription to a
  final valA = a.value;

  // Read b non-reactively using untracked to prevent circular subscriptions
  final valB = untracked(() => b.value);

  print('A: $valA, B: $valB');
});
```

### Members of Effect

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **debugLabel** | <code>method</code> | <code>dart String? debugLabel</code> | Label used for debugging |
| **Effect** | <code>constructor</code> | <code>dart Effect(super.fn, {EffectOptions? options, @Deprecated('Use options: EffectOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: EffectOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: EffectOptions(onDispose: ...) instead') void Function()? onDispose})</code> | The <code>effect</code> function is the last piece that makes everything reactive. When you access a signal inside its callback function, that signal and every dependency of said signal will be activated and subscribed to. In that regard it is very similar to [<code>computed(fn)</code>](/core/computed). By default all updates are lazy, so nothing will update until you access a signal inside <code>effect</code>. |
| **call** | <code>method</code> | <code>dart void Function() call()</code> |  |
| **dispose** | <code>method</code> | <code>dart void dispose()</code> |  |
| **disposed** | <code>method</code> | <code>dart bool disposed</code> | Check if the effect is disposed |
| **disposed** | <code>method</code> | <code>dart disposed(bool value)</code> | Force an effect to be disposed |
| **onDispose** | <code>method</code> | <code>dart EffectCleanup onDispose(void Function() cleanup)</code> | Add a cleanup function to be called when the signal is disposed |

## Class: Effect

Represents a passive observer that runs arbitrary side-effect code in response to signal changes.

An [Effect](/types/effect) tracks which signals are accessed within its callback function,
and automatically schedules itself to re-run whenever those dependencies change.

Under the hood, the reactivity engine tracks reads on <code>.value</code> inside the active effect block.
Once the block completes, a subscription is registered for each accessed signal. When any of those signals
mutate, the effect is added to the microtask queue and executed synchronously during the next tick.

<Warning>
  Do not modify a tracked signal <em>directly</em> inside an effect callback, as this will trigger another execution
  of the same effect, causing an infinite loop (cycle) and throwing a cycle detection error.
  To read a signal non-reactively, use <code>.peek()</code>.
</Warning>

### Example Usage

#### 1. Standard Side-Effect
```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);

void main() {
  // Creates and immediately starts the effect
  final logger = Effect(() {
    print('Active count is: ${count.value}');
  });

  count.value = 1; // Prints: "Active count is: 1"
  logger.dispose();
}
```

#### 2. Effect Cleanup Callback
If your effect returns a function, that function is registered as a **cleanup callback**.
The cleanup callback is executed right before the next effect run, or when the effect is disposed.
This is highly useful for cleaning up timers, controllers, or other subscriptions:
```dart
final query = signal('search_term');

final searchEffect = Effect(() {
  final currentQuery = query.value;
  print('Initiating search for: $currentQuery');

  final timer = Timer(Duration(milliseconds: 500), () {
    print('Search completed for: $currentQuery');
  });

  // Return cleanup callback
  return () {
    print('Cancelling previous search timer');
    timer.cancel();
  };
});
```

### Members of Effect

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **globalId** | <code>field</code> | <code>dart int globalId</code> |  |
| **flags** | <code>field</code> | <code>dart int flags</code> |  |
| **name** | <code>field</code> | <code>dart String? name</code> | The name of the effect for debugging. |
| **Effect** | <code>constructor</code> | <code>dart Effect(this.fn, {String? name, EffectOptions? options})</code> | Creates a new [Effect](/types/effect) instance with the passive side-effect callback **fn**. |
| **notify** | <code>method</code> | <code>dart void notify()</code> |  |
| **dispose** | <code>method</code> | <code>dart void dispose()</code> | Disposes of the effect, stopping future callback executions, |
| **call** | <code>method</code> | <code>dart void Function() call()</code> | Activates/Runs the effect immediately. |

## Function: effect

```dart
EffectCleanup effect(EffectCallback fn, {EffectOptions? options, @Deprecated('Use options: EffectOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: EffectOptions(name: ...) instead') String? debugLabel, @Deprecated('Use options: EffectOptions(onDispose: ...) instead') void Function()? onDispose})
```

The <code>effect</code> function is the last piece that makes everything reactive. When you access a signal inside its callback function, that signal and every dependency of said signal will be activated and subscribed to. In that regard it is very similar to [<code>computed(fn)</code>](/core/computed). By default all updates are lazy, so nothing will update until you access a signal inside <code>effect</code>.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");
final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
effect(() => print(fullName.value));

// Updating one of its dependencies will automatically trigger
// the effect above, and will print "John Doe" to the console.
name.value = "John";
```

You can destroy an effect and unsubscribe from all signals it was subscribed to, by calling the returned function.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");
final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
final dispose = effect(() => print(fullName.value));

// Destroy effect and subscriptions
dispose();

// Update does nothing, because no one is subscribed anymore.
// Even the computed `fullName` signal won't change, because it knows
// that no one listens to it.
surname.value = "Doe 2";
```

## Cleanup Callback

You can also return a cleanup function from an effect. This function will be called when the effect is destroyed.

```dart
import 'package:signals/signals.dart';

final s = signal(0);

final dispose = effect(() {
  print(s.value);
  return () => print('Effect destroyed');
});

// Destroy effect and subscriptions
dispose();
```

## On Dispose Callback

You can also pass a callback to <code>effect</code> that will be called when the effect is destroyed.

```dart
import 'package:signals/signals.dart';

final s = signal(0);

final dispose = effect(() {
  print(s.value);
}, onDispose: () => print('Effect destroyed'));

// Destroy effect and subscriptions
dispose();
```

## Warning About Cycles

Mutating a signal inside an effect will cause an infinite loop, because the effect will be triggered again. To prevent this, you can use [<code>untracked(fn)</code>](/core/untracked) to read a signal without subscribing to it.

```dart
import 'dart:async';

import 'package:signals/signals.dart';

Future<void> main() async {
  final completer = Completer<void>();
  final age = signal(0);

  effect(() {
    print('You are ${age.value} years old');
    age.value++; // <-- This will throw a cycle error
  });

  await completer.future;
}
```

## Function: effect

```dart
void Function() effect( Function() fn, [EffectOptions? options])
```

Creates and immediately executes a new reactive [Effect](/types/effect).

Returns a bound disposer function that can be called to stop the effect and unsubscribe
it from all tracked signals.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);
final dispose = effect(() {
  print('Count is: ${count.value}');
  return () => print('Cleaning up!');
});

void main() {
  count.value = 10; // Prints: "Cleaning up!" then "Count is: 10"
  dispose(); // Stops the effect and unsubscribes
}
```

## References

The **Effect** type is referenced and used in the following pages:

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
* [SetSignalMixin](/packages/signals_flutter/mixins/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [ListSignalMixin](/packages/signals_flutter/mixins/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [SinkSignalMixin](/packages/signals_flutter/mixins/sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [QueueSignalMixin](/packages/signals_flutter/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [IterableSignalMixin](/packages/signals_flutter/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [EventSinkSignalMixin](/packages/signals_flutter/mixins/event-sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [FutureSignal](/packages/signals_flutter/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Computed](/packages/signals_flutter/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [Stream](/packages/signals_flutter/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/async)</span>
* [MapSignal](/packages/signals_flutter/value/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [SetSignal](/packages/signals_flutter/value/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [ListSignal](/packages/signals_flutter/value/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [IterableSignal](/packages/signals_flutter/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [ChangeStackSignal](/packages/signals_flutter/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [SignalCustomPainter](/packages/signals_flutter/extensions/signal-custom-painter) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/extensions)</span>
* [SignalEquality](/packages/signals_flutter/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [Model](/packages/signals_flutter/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [SignalContainer](/packages/signals_flutter/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [SignalsObserver](/packages/signals_flutter/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [signals_flutter](/packages/signals_flutter)
* [SignalEffect](/packages/signals_flutter/effects/signal-effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/effects)</span>
* [Untracked](/packages/signals_core/core/untracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [LinkedSignal](/packages/signals_core/core/linked-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Effect](/packages/signals_core/core/effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [ReadonlySignal](/packages/signals_core/core/readonly) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Computed](/packages/signals_core/core/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Action](/packages/signals_core/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Batch](/packages/signals_core/core/batch) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [MapSignalMixin](/packages/signals_core/mixins/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [SetSignalMixin](/packages/signals_core/mixins/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [ListSignalMixin](/packages/signals_core/mixins/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [SinkSignalMixin](/packages/signals_core/mixins/sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [QueueSignalMixin](/packages/signals_core/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [IterableSignalMixin](/packages/signals_core/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [EventSinkSignalMixin](/packages/signals_core/mixins/event-sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [FutureSignal](/packages/signals_core/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
* [Computed](/packages/signals_core/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/async)</span>
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
* [signals_core](/packages/signals_core)
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
* [SetSignalMixin](/packages/signals/mixins/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [ListSignalMixin](/packages/signals/mixins/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [SinkSignalMixin](/packages/signals/mixins/sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [QueueSignalMixin](/packages/signals/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [IterableSignalMixin](/packages/signals/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [EventSinkSignalMixin](/packages/signals/mixins/event-sink) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [FutureSignal](/packages/signals/async/future) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [Computed](/packages/signals/async/computed) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [Stream](/packages/signals/async/stream) <span style="opacity: 0.6; font-size: 0.85em;">(signals/async)</span>
* [MapSignal](/packages/signals/value/map) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [SetSignal](/packages/signals/value/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [ListSignal](/packages/signals/value/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [IterableSignal](/packages/signals/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [ChangeStackSignal](/packages/signals/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [SignalCustomPainter](/packages/signals/extensions/signal-custom-painter) <span style="opacity: 0.6; font-size: 0.85em;">(signals/extensions)</span>
* [SignalEquality](/packages/signals/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [Model](/packages/signals/utilities/model) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [SignalContainer](/packages/signals/utilities/container) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [SignalsObserver](/packages/signals/utilities/observer) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals](/packages/signals)
* [SignalEffect](/packages/signals/effects/signal-effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals/effects)</span>
* [signals_hooks](/packages/signals_hooks)
* [useLazySignal](/packages/signals_hooks/hooks/use-lazy-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useMutationSignal](/packages/signals_hooks/hooks/use-mutation-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [useSignalEffect](/packages/signals_hooks/hooks/use-signal-effect) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
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
* [Installing](/reference/install) <span style="opacity: 0.6; font-size: 0.85em;">(reference)</span>
* [AI Integration](/reference/ai) <span style="opacity: 0.6; font-size: 0.85em;">(reference)</span>

