---
title: Computed
description: Represents a derived reactive state value computed from one or more other signals.
---

Represents a derived reactive state value computed from one or more other signals.

Computed signals are read-only, lazily evaluated, and cached (memoized).
Their values automatically update when any dependency signals accessed inside the
callback function change.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(2);
final doubleCount = Computed(() => count.value * 2);

void main() {
  print(doubleCount.value); // Prints: 4
  count.value = 5;
  print(doubleCount.value); // Prints: 10
}
```


### Constructors

##### <a name="computed"></a><a name="computed"></a>`Computed(this.fn, {String? name, void Function()? watched, void Function()? unwatched, ComputedOptions<T>? options})`

Creates a new [Computed](/packages/signals/core/computed) signal instance with the computation callback **fn**.


### Properties

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


### Methods

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
