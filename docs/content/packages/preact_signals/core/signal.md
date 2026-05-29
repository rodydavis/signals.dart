---
title: Signal
description: Represents a mutable reactive state container that sits at the foundation of the reactivity system.
---

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


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signal"></a><a name="signal"></a><code>Signal(this._internalValue, {String? name, void Function()? watched, void Function()? unwatched, ReadonlySignalOptions<T>? options, SignalEquality<T>? equality})</code>

Creates a new [Signal](/types/signal) instance with the given initial value.

You can optionally provide:
- A **name** for debugging/observer tracing.
- **watched**/**unwatched** hooks triggered when the signal gains its first subscriber or loses its last subscriber.
- **equality** checking callback to customize how value modifications are compared.

```dart
final count = Signal(0, name: 'counter_signal');
```

##### <a name="signal-lazy"></a><a name="lazy"></a><code>Signal.lazy({String? name, void Function()? watched, void Function()? unwatched, ReadonlySignalOptions<T>? options, SignalEquality<T>? equality})</code>

Creates a new lazy [Signal](/types/signal) instance that is computed on-demand upon first read.

<Warning>
  Reading a lazy signal before a value has been explicitly set or assigned via <code>.value = ...</code> or <code>.set(...)</code>
  will throw a runtime initialization exception.
</Warning>

```dart
final lazyUser = Signal<User>.lazy(name: 'lazy_user');

// Throws error:
// print(lazyUser.value);

lazyUser.value = User(id: 1, name: 'John'); // Initialized successfully
print(lazyUser.value); // Safe to read now
```

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="globalid"></a><code>int globalId</code>

##### <a name="name"></a><code>String? name</code>

##### <a name="watched"></a><code>void Function()? watched</code>

##### <a name="unwatched"></a><code>void Function()? unwatched</code>

##### <a name="version"></a><code>int version</code>

Version numbers should always be >= 0, because the special value -1 is used
by Nodes to signify potentially unused but recyclable nodes.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="equalitycheck"></a><code>SignalEquality<T> equalityCheck</code>

Get the active equality check

##### <a name="isinitialized"></a><code>bool isInitialized</code>

Check if the value is set and not a lazy signal

##### <a name="internalvalue"></a><code>T internalValue</code>

##### <a name="internalrefresh"></a><code>bool internalRefresh()</code>

##### <a name="subscribetonode"></a><code>void subscribeToNode(Node node)</code>

##### <a name="unsubscribefromnode"></a><code>void unsubscribeFromNode(Node node)</code>

##### <a name="subscribe"></a><code>void Function() subscribe(void Function(T value) fn)</code>

##### <a name="value"></a><code>T value</code>

Gets the current value of the signal.

If read inside an active reactive context (e.g., an [effect](/types/effect) or [computed](/types/computed) signal),
the calling context automatically subscribes to updates of this signal.

##### <a name="value"></a><code>value(T val)</code>

Sets the current value of the signal.

If the new value is not equal to the existing value (based on **equalityCheck**), the
signal's version is incremented and all active downstream subscribers (computeds/effects)
are synchronously notified to re-evaluate.

##### <a name="set"></a><code>bool set(T val, {bool force = false})</code>

Updates the signal's value by method call.

Under normal conditions, this only notifies subscribers if the new value is different
from the current value.

Set **force** to <code>true</code> to bypass standard equality checks and notify downstream subscribers
unconditionally. This is useful when working with mutable collections or class instances where
properties change in-place but the object reference remains identical.

```dart
final numbers = Signal([1, 2, 3]);
numbers.value.add(4); // In-place modification
numbers.set(numbers.value, force: true); // Force notify downstream subscribers
```

</details>



---

## ReadonlySignalOptions

Configuration options for a [ReadonlySignal](/types/readonlysignal).

Allows intercepting the signal's active subscription state changes
via **watched** and **unwatched** callback event listeners. This is extremely useful
for initiating or canceling active background fetching, web sockets, or timer loops.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final stockTicker = signal(
  0.0,
  options: ReadonlySignalOptions(
    name: 'stock-ticker',
    watched: () => print('Stock Ticker is actively being listened to!'),
    unwatched: () => print('No more listeners, sleeping the ticker.'),
  ),
);
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="readonlysignaloptions"></a><a name="readonlysignaloptions"></a><code>ReadonlySignalOptions({super.name, this.watched, this.unwatched})</code>

Creates a new [ReadonlySignalOptions](/types/readonlysignaloptions) instance.

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="watched"></a><code>void Function()? watched</code>

Callback called when the signal goes from 0 to >=1 listeners.

##### <a name="unwatched"></a><code>void Function()? unwatched</code>

Callback called when the signal goes from >=1 to 0 listeners.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a><code>ReadonlySignalOptions<T> copyWith({String? name, void Function()? watched, void Function()? unwatched})</code>

Creates a copy of this options with custom overrides.

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## ComputedOptions

Configuration options for a [Computed](/types/computed) signal.

Enables configuring debugging names and subscription state event listeners
for computed derivations.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);
final doubleCount = computed(
  () => count.value * 2,
  options: ComputedOptions(
    name: 'double-count',
    watched: () => print('Computed doubleCount is active'),
    unwatched: () => print('Computed doubleCount is inactive'),
  ),
);
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="computedoptions"></a><a name="computedoptions"></a><code>ComputedOptions({super.name, super.watched, super.unwatched})</code>

Creates a new [ComputedOptions](/types/computedoptions) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a><code>ComputedOptions<T> copyWith({String? name, void Function()? watched, void Function()? unwatched})</code>

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## SignalOptions

Configuration options for a [Signal](/types/signal).

Extends [ReadonlySignalOptions](/types/readonlysignaloptions) to also support custom **equality** checkers,
which control whether incoming values trigger update events.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final items = signal(
  [1, 2, 3],
  options: SignalOptions(
    name: 'item-list',
    equality: SignalEquality.deep(),
    watched: () => print('Items watch active'),
    unwatched: () => print('Items watch inactive'),
  ),
);
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signaloptions"></a><a name="signaloptions"></a><code>SignalOptions({super.name, super.watched, super.unwatched, SignalEquality<T>? equality})</code>

Creates a new [SignalOptions](/types/signaloptions) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="equalitycheck"></a><code>SignalEquality<T> equalityCheck</code>

Get the active equality check

##### <a name="copywith"></a><code>SignalOptions<T> copyWith({String? name, void Function()? watched, void Function()? unwatched})</code>

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## EffectOptions

Configuration options for reactive [Effect](/types/effect)s.

Permits naming the effect for debugging, performance profiling,
and tracing within the signals developer tools.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);

final logger = effect(
  () => print('Count changed to: ${count.value}'),
  options: const EffectOptions(name: 'counter-logger'),
);
```


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="effectoptions"></a><a name="effectoptions"></a><code>EffectOptions({super.name})</code>

Creates a new [EffectOptions](/types/effectoptions) instance.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="copywith"></a><code>EffectOptions copyWith({String? name})</code>

Creates a copy of this options with custom overrides.

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## signal

Convenient global constructor for creating a mutable reactive state signal.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);
final name = signal('Jane');
```


---

## SignalOptionsBase

Base configuration options for reactive components and signals.

Contains common options across all signals, computed values, and effects,
such as the debug **name**.


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signaloptionsbase"></a><a name="signaloptionsbase"></a><code>SignalOptionsBase({this.name})</code>

Creates a new [SignalOptionsBase](/types/signaloptionsbase) instance.

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="name"></a><code>String? name</code>

The name for debugging, tracing, and DevTools inspection.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## SignalEffectException

Error for when a effect fails to run the callback


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="signaleffectexception"></a><a name="signaleffectexception"></a><code>SignalEffectException(this.error, [this.stackTrace])</code>

Error for when a effect fails to run the callback

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="error"></a><code>Object? error</code>

Error during callback

##### <a name="stacktrace"></a><code>StackTrace? stackTrace</code>

StackTrace for where the error started

</details>
