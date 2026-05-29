---
title: Computed
description: Represents a derived, read-only reactive state value computed from one or more other signals.
---

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


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="computed"></a><a name="computed"></a><code>Computed(this.fn, {String? name, void Function()? watched, void Function()? unwatched, ComputedOptions<T>? options})</code>

Creates a new [Computed](/types/computed) signal instance with the derivation callback **fn**.

You can optionally provide:
- A **name** for debugging/observer tracing.
- **watched**/**unwatched** hooks triggered when the computed gains its first subscriber or loses its last subscriber.

```dart
final doubleCount = Computed(() => count.value * 2, name: 'double_counter');
```

</details>


### Properties

<details>
<summary> View Properties </summary>

##### <a name="globalid"></a><code>int globalId</code>

##### <a name="name"></a><code>String? name</code>

##### <a name="watched"></a><code>void Function()? watched</code>

##### <a name="unwatched"></a><code>void Function()? unwatched</code>

##### <a name="flags"></a><code>int flags</code>

##### <a name="version"></a><code>int version</code>

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="isinitialized"></a><code>bool isInitialized</code>

Check if the value has been computed

##### <a name="internalvalue"></a><code>T internalValue</code>

##### <a name="internalrefresh"></a><code>bool internalRefresh()</code>

##### <a name="subscribetonode"></a><code>void subscribeToNode(Node node)</code>

##### <a name="unsubscribefromnode"></a><code>void unsubscribeFromNode(Node node)</code>

##### <a name="notify"></a><code>void notify()</code>

##### <a name="value"></a><code>T value</code>

##### <a name="subscribe"></a><code>void Function() subscribe(void Function(T value) fn)</code>

</details>



---

## computed

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
