---
title: Effect
description: Represents a passive observer that runs arbitrary side-effect code in response to signal changes.
---

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


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="effect"></a><a name="effect"></a><code>Effect(this.fn, {String? name, EffectOptions? options})</code>

Creates a new [Effect](/types/effect) instance with the passive side-effect callback **fn**.

You can optionally provide:
- A **name** for debugging/observer tracing.

```dart
final effectObj = Effect(() => print(count.value), name: 'count_logger');
```

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="globalid"></a><code>int globalId</code>

##### <a name="flags"></a><code>int flags</code>

##### <a name="name"></a><code>String? name</code>

The name of the effect for debugging.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="notify"></a><code>void notify()</code>

##### <a name="dispose"></a><code>void dispose()</code>

Disposes of the effect, stopping future callback executions,
executing any registered cleanup routines, and unsubscribing from all dependency signals.

##### <a name="call"></a><code>void Function() call()</code>

Activates/Runs the effect immediately.

Returns a bound disposer function that can be called to stop the effect.

</details>



---

## effect

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
