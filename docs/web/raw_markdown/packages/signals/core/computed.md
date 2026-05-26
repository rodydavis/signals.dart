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
  The computation callback **fn** should be **pure** and side-effect free. Writing to other signals or
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

##### <a name="computed"></a><a name="computed"></a>`Computed(this.fn, {String? name, void Function()? watched, void Function()? unwatched, ComputedOptions<T>? options})`

Creates a new [Computed](/packages/signals/core/computed) signal instance with the derivation callback **fn**.

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

##### <a name="fn"></a>`T Function() fn`

@internal
The computation callback function.

##### <a name="globalid"></a>`int globalId`

##### <a name="name"></a>`String? name`

##### <a name="watched"></a>`void Function()? watched`

##### <a name="unwatched"></a>`void Function()? unwatched`

##### <a name="internalglobalversion"></a>`int internalGlobalVersion`

@internal
The internal global version of the computed signal.

##### <a name="flags"></a>`int flags`

##### <a name="error"></a>`SignalEffectException? error`

@internal
The captured exception from the latest computation run, if any.

##### <a name="version"></a>`int version`

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="isinitialized"></a>`bool isInitialized`

Check if the value has been computed

##### <a name="internalvalue"></a>`T internalValue`

##### <a name="internalvalue"></a>`internalValue(T value)`

@internal
Set the internal value.

##### <a name="internalrefresh"></a>`bool internalRefresh()`

##### <a name="subscribetonode"></a>`void subscribeToNode(Node node)`

##### <a name="unsubscribefromnode"></a>`void unsubscribeFromNode(Node node)`

##### <a name="notify"></a>`void notify()`

##### <a name="value"></a>`T value`

##### <a name="subscribe"></a>`void Function() subscribe(void Function(T value) fn)`

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
