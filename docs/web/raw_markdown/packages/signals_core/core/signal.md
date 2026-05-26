---
title: Signal
description: Represents a mutable reactive state container that sits at the foundation of the reactivity system.
---

Represents a mutable reactive state container that sits at the foundation of the reactivity system.

Signals hold a single, mutable **value** that can be read or modified. When a signal's value
is updated, any active computations (like [Computed](/packages/signals/core/computed)) or effects (like [effect](/packages/signals/core/effect)) that
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

##### <a name="signal"></a><a name="signal"></a>`Signal(this._internalValue, {String? name, void Function()? watched, void Function()? unwatched, ReadonlySignalOptions<T>? options, SignalEquality<T>? equality})`

Creates a new [Signal](/packages/signals/core/signal) instance with the given initial value.

You can optionally provide:
- A **name** for debugging/observer tracing.
- **watched**/**unwatched** hooks triggered when the signal gains its first subscriber or loses its last subscriber.
- **equality** checking callback to customize how value modifications are compared.

```dart
final count = Signal(0, name: 'counter_signal');
```

##### <a name="signal-lazy"></a><a name="lazy"></a>`Signal.lazy({String? name, void Function()? watched, void Function()? unwatched, ReadonlySignalOptions<T>? options, SignalEquality<T>? equality})`

Creates a new lazy [Signal](/packages/signals/core/signal) instance that is computed on-demand upon first read.

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

##### <a name="globalid"></a>`int globalId`

##### <a name="name"></a>`String? name`

##### <a name="watched"></a>`void Function()? watched`

##### <a name="unwatched"></a>`void Function()? unwatched`

##### <a name="batchsnapshotversion"></a>`int batchSnapshotVersion`

@internal
The global batch snapshot version tracked during mutation cycles.

##### <a name="version"></a>`int version`

Version numbers should always be >= 0, because the special value -1 is used
by Nodes to signify potentially unused but recyclable nodes.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="equalitycheck"></a>`SignalEquality<T> equalityCheck`

Get the active equality check

##### <a name="isinitialized"></a>`bool isInitialized`

Check if the value is set and not a lazy signal

##### <a name="isinitialized"></a>`isInitialized(bool val)`

@internal
Set if the signal is initialized.

##### <a name="internalvalue"></a>`T internalValue`

##### <a name="internalvalue"></a>`internalValue(T value)`

@internal
Set the internal raw value of the signal.

##### <a name="internalrefresh"></a>`bool internalRefresh()`

##### <a name="subscribetonode"></a>`void subscribeToNode(Node node)`

##### <a name="unsubscribefromnode"></a>`void unsubscribeFromNode(Node node)`

##### <a name="subscribe"></a>`void Function() subscribe(void Function(T value) fn)`

##### <a name="value"></a>`T value`

Gets the current value of the signal.

If read inside an active reactive context (e.g., an [effect](/packages/signals/core/effect) or [computed](/packages/signals/flutter/computed) signal),
the calling context automatically subscribes to updates of this signal.

##### <a name="value"></a>`value(T val)`

Sets the current value of the signal.

If the new value is not equal to the existing value (based on **equalityCheck**), the
signal's version is incremented and all active downstream subscribers (computeds/effects)
are synchronously notified to re-evaluate.

##### <a name="set"></a>`bool set(T val, {bool force = false})`

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

##### <a name="internalsetvalue"></a>`void internalSetValue(T val)`

@internal
Sets the internal value of the signal during batch updates.

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
