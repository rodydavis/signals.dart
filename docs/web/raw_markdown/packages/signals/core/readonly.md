---
title: ReadonlySignal
description: An interface for read-only signals.
---

An interface for read-only signals.

A [ReadonlySignal](/packages/preact_signals/core/readonly) is a reactive container whose value can be read but not directly mutated.
Under the hood, any [Signal](/packages/signals/core/signal) implements or can be cast/exposed as a [ReadonlySignal](/packages/preact_signals/core/readonly). This
is a core architectural pattern for encapsulating state: classes can modify state internally
using a private mutable <code>Signal</code>, while exposing a public <code>ReadonlySignal</code> to consumers to
enforce unidirectional data flow.

Whenever the underlying value changes, any active [effect](/packages/signals/core/effect) or [computed](/packages/signals/flutter/computed) signal that reads this
signal's value will automatically be re-evaluated.

### Example Usage

````dart
import 'package:preact_signals/preact_signals.dart';

class CounterController {
  // Keep the mutable state private to the controller
  final _counter = signal(0);

  // Expose a public read-only signal to external consumers
  ReadonlySignal<int> get counter => _counter;

  void increment() {
    _counter.value++;
  }

  void decrement() {
    _counter.value--;
  }
}

void main() {
  final controller = CounterController();

  // React to updates from the read-only signal
  final dispose = effect(() {
    print("The current count is: ${controller.counter.value}");
  });

  // controller.counter.value = 10; // Error: Cannot mutate a ReadonlySignal!

  controller.increment(); // Prints: "The current count is: 1"
  controller.increment(); // Prints: "The current count is: 2"

  dispose();
}
````

<Success>
Use [ReadonlySignal] to prevent consumers of your stores or controllers from modifying state
bypassing the controller's methods. This ensures consistent, predictable, and traceable mutations
throughout your application.
</Success>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="node"></a>`Node? node`

@internal
Node representing the dependency hook of this signal.

##### <a name="targets"></a>`Node? targets`

@internal
A linked list of subscription nodes pointing to targets.

##### <a name="brand"></a>`Symbol brand`

@internal
Brand symbol to uniquely distinguish signals.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="globalid"></a>`int globalId`

Global ID of the signal

##### <a name="value"></a>`T value`

Compute the current value

##### <a name="name"></a>`String? name`

The name of the signal for debugging purposes.

##### <a name="watched"></a>`void Function()? watched`

Callback called when the signal goes from 0 to >=1 listeners.

##### <a name="unwatched"></a>`void Function()? unwatched`

Callback called when the signal goes from >=1 to 0 listeners.

##### <a name="internalvalue"></a>`T internalValue`

@internal
Internal getter for the raw value without subscription tracking.

##### <a name="tostring"></a>`String toString()`

##### <a name="tojson"></a>`dynamic toJson()`

Convert value to JSON

##### <a name="call"></a>`T call()`

Return the value when invoked

##### <a name="get"></a>`T get()`

Helper method to get the current value

##### <a name="peek"></a>`T peek()`

In the rare instance that you have an effect that should write to another signal based on the previous value, but you _don't_ want the effect to be subscribed to that signal, you can read a signals's previous value via <code>signal.peek()</code>.

```dart
final counter = signal(0);
final effectCount = signal(0);

effect(() {
	print(counter.value);

	// Whenever this effect is triggered, increase `effectCount`.
	// But we don't want this signal to react to `effectCount`
	effectCount.value = effectCount.peek() + 1;
});
```

Note that you should only use <code>signal.peek()</code> if you really need it. Reading a signal's value via <code>signal.value</code> is the preferred way in most scenarios.

##### <a name="subscribe"></a>`void Function() subscribe(void Function(T value) fn)`

Subscribe to value changes with a dispose function

##### <a name="subscribetonode"></a>`void subscribeToNode(Node node)`

@internal
Subscribes this signal to notifications from a given dependency **node**.

##### <a name="unsubscribefromnode"></a>`void unsubscribeFromNode(Node node)`

@internal
Unsubscribes this signal from notifications from a given dependency **node**.

##### <a name="internalsubscribe"></a>`void internalSubscribe(Node node)`

@internal
Internal subscription mechanism for targets.

##### <a name="version"></a>`int version`

Version numbers should always be >= 0, because the special value -1 is used
by Nodes to signify potentially unused but recyclable nodes.
@internal
The current mutation version of the signal.

##### <a name="internalrefresh"></a>`bool internalRefresh()`

@internal
Refreshes the signal's value internally.

##### <a name="readonlysignaltargets"></a>`Iterable<Listenable> readonlySignalTargets()`

@internal
Returns target listeners currently subscribing to this signal.

##### <a name="adddependency"></a>`Node? addDependency()`

@internal
Adds this signal as a dependency of the current execution context.

##### <a name="signalsubscribe"></a>`void Function() signalSubscribe(void Function(T value) fn)`

@internal
Registers a subscription callback **fn** on value changes.

##### <a name="signalunsubscribe"></a>`void signalUnsubscribe(Node node)`

@internal
Unregisters a subscription node.

</details>



---

## readonly

Creates a new read-only signal initialized with **value**.

This function returns a [ReadonlySignal](/packages/preact_signals/core/readonly) containing **value**. Under the hood, a mutable [Signal](/packages/signals/core/signal)
is created, but it is returned under the [ReadonlySignal](/packages/preact_signals/core/readonly) interface to prevent modification by clients.

This is particularly useful when you need to expose a constant reactive value, or bridge some external,
immutable value source into the signals reactivity system.

Parameters:
- **value**: The initial value held by the read-only signal.
- **options**: Optional configuration options (e.g., custom debug name or lifecycle callbacks like <code>watched</code>/<code>unwatched</code>).

Returns:
- A [ReadonlySignal](/packages/preact_signals/core/readonly) containing the initial value.

### Example Usage

````dart
import 'package:preact_signals/preact_signals.dart';

final configUrl = readonly('https://api.example.com');

void main() {
  effect(() {
    print("Connecting to: ${configUrl.value}");
  });
}
````

<Warning>
If you are trying to derive a value from other signals, do not use [readonly]. Use [computed] instead
to ensure the derived signal automatically re-evaluates when its source signals change.
</Warning>
