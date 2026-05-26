---
title: ListSignal
description: A reactive Signal that holds a **List** and implements the **List** interface.
---

A reactive [Signal](/packages/signals/core/signal) that holds a **List** and implements the **List** interface.

[ListSignal](/packages/signals/value/list) lets you listen to changes on a list reactively and mutate it directly using
standard list operations (like `add`, `addAll`, `remove`, operators `[]` and `[]=`, etc.).
Any mutations automatically trigger reactive updates to all active listeners (e.g., inside an
[effect](/packages/signals/core/effect) or [computed](/packages/signals/flutter/computed)).

Additionally, [ListSignal](/packages/signals/value/list) defines convenient operators:
- `<<` injects/adds all items from an iterable into the list.
- `&` forks/concatenates the list with an iterable into a new [ListSignal](/packages/signals/value/list).
- `|` pipes/concatenates the list with another signal holding an iterable into a new [ListSignal](/packages/signals/value/list).

### Example Usage

```dart
import 'package:signals/signals.dart';

void main() {
  final numbers = listSignal<int>([1, 2, 3]);

  effect(() {
    print('List content: $numbers, Length: ${numbers.length}');
  }); // Prints: "List content: [1, 2, 3], Length: 3"

  // Standard mutation (triggers updates)
  numbers.add(4); // Prints: "List content: [1, 2, 3, 4], Length: 4"

  // Update via index operator (triggers updates)
  numbers[0] = 10; // Prints: "List content: [10, 2, 3, 4], Length: 4"

  // Injection operator (triggers updates)
  numbers << [5, 6]; // Prints: "List content: [10, 2, 3, 4, 5, 6], Length: 6"
}
```

<Success>
Mutating the collection directly calls the reactive set() routine under the hood automatically. You
do not need to assign `numbers.value = ...` manually!
</Success>


### Constructors

##### <a name="listsignal"></a><a name="listsignal"></a>`ListSignal(super.value, {ListSignalOptions<E>? options, @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ListSignalOptions(name: ...) instead') String? debugLabel})`

Creates a [ListSignal](/packages/signals/value/list) with the given **value**.


### Methods

##### <a name="<<"></a>`ListSignal<E> <<(Iterable<E> other)`

Inject: Update current signal value with iterable

##### <a name="&"></a>`ListSignal<E> &(Iterable<E> other)`

Fork: create a new signal which value is the concatenation of source signal and iterable parameter

##### <a name="|"></a>`ListSignal<E> |(Signal<Iterable<E>> other)`

Pipe: create a new signal by sending value from source to other

##### <a name="=="></a>`bool ==(Object other)`

##### <a name="hashcode"></a>`int hashCode`



---

## listSignal

Creates a [ListSignal](/packages/signals/value/list) initialized with the provided **list**.

This is a convenience helper function for creating reactive list signals.

```dart
import 'package:signals/signals.dart';

final list = listSignal([1, 2, 3]);
```
