---
title: ReadonlySignal
description: An interface for read-only signals.
---

An interface for read-only signals.

A [ReadonlySignal](/types/readonlysignal) is a reactive container whose value can be read but not directly mutated.
Under the hood, any [Signal](/types/signal) implements or can be cast/exposed as a [ReadonlySignal](/types/readonlysignal). This
is a core architectural pattern for encapsulating state: classes can modify state internally
using a private mutable <code>Signal</code>, while exposing a public <code>ReadonlySignal</code> to consumers to
enforce unidirectional data flow.

Whenever the underlying value changes, any active [effect](/types/effect) or [computed](/types/computed) signal that reads this
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

</details>



---

## readonly

Creates a new read-only signal initialized with **value**.

This function returns a [ReadonlySignal](/types/readonlysignal) containing **value**. Under the hood, a mutable [Signal](/types/signal)
is created, but it is returned under the [ReadonlySignal](/types/readonlysignal) interface to prevent modification by clients.

This is particularly useful when you need to expose a constant reactive value, or bridge some external,
immutable value source into the signals reactivity system.

Parameters:
- **value**: The initial value held by the read-only signal.
- **options**: Optional configuration options (e.g., custom debug name or lifecycle callbacks like <code>watched</code>/<code>unwatched</code>).

Returns:
- A [ReadonlySignal](/types/readonlysignal) containing the initial value.

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
