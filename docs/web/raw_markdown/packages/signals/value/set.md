---
title: SetSignal
description: A reactive Signal that holds a **Set** and implements the **Set** interface.
---

A reactive [Signal](/packages/signals/core/signal) that holds a **Set** and implements the **Set** interface.

[SetSignal](/packages/signals/value/set) lets you listen to changes on a set reactively and mutate it directly using
standard set operations (like `add`, `addAll`, `remove`, `clear`, etc.). Any mutations
automatically trigger reactive updates to all active listeners (e.g., inside an [effect](/packages/signals/core/effect)
or [computed](/packages/signals/flutter/computed)).

Additionally, [SetSignal](/packages/signals/value/set) defines convenient operators:
- `<<` injects/adds all items from another set into the current set.
- `&` forks/unions the set with another set into a new [SetSignal](/packages/signals/value/set).
- `|` pipes/unions the set with another signal holding an iterable into a new [SetSignal](/packages/signals/value/set).

### Example Usage

```dart
import 'package:signals/signals.dart';

void main() {
  final numbers = setSignal<int>({1, 2, 3});

  effect(() {
    print('Set content: $numbers, Length: ${numbers.length}');
  }); // Prints: "Set content: {1, 2, 3}, Length: 3"

  // Standard mutation (triggers updates)
  numbers.add(4); // Prints: "Set content: {1, 2, 3, 4}, Length: 4"

  // Removing an element (triggers updates)
  numbers.remove(1); // Prints: "Set content: {2, 3, 4}, Length: 3"

  // Set intersection (reactive query)
  final common = numbers.intersection({3, 4, 5});
  print(common); // Prints: {3, 4}
}
```

<Success>
Mutating the collection directly calls the reactive set() routine under the hood automatically. You
do not need to assign `numbers.value = ...` manually!
</Success>


### Constructors

##### <a name="setsignal"></a><a name="setsignal"></a>`SetSignal(super.value, {SetSignalOptions<E>? options, @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SetSignalOptions(name: ...) instead') String? debugLabel})`

Creates a [SetSignal](/packages/signals/value/set) with the given **value**.


### Methods

##### <a name="<<"></a>`SetSignal<E> <<(Set<E> other)`

Inject: Update current signal value with iterable

##### <a name="&"></a>`SetSignal<E> &(Set<E> other)`

Fork: create a new signal with value is the concatenation of source signal and iterable parameter

##### <a name="|"></a>`SetSignal<E> |(Signal<Iterable<E>> other)`

Pipe: create a new signal by sending value from source to other

##### <a name="=="></a>`bool ==(Object other)`

##### <a name="hashcode"></a>`int hashCode`



---

## setSignal

Creates a [SetSignal](/packages/signals/value/set) initialized with the provided **set**.

This is a convenience helper function for creating reactive set signals.

```dart
import 'package:signals/signals.dart';

final mySet = setSignal({1, 2, 3});
```
