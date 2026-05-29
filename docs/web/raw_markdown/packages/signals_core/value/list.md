---
title: ListSignal
description: A reactive Signal that holds a List and implements the List interface.
---

A reactive [Signal](/types/signal) that holds a **List** and implements the **List** interface.

[ListSignal](/types/listsignal) lets you listen to changes on a list reactively and mutate it directly using
standard list operations (like <code>add</code>, <code>addAll</code>, <code>remove</code>, operators <code>[]</code> and <code>[]=</code>, etc.).
Any mutations automatically trigger reactive updates to all active listeners (e.g., inside an
[effect](/types/effect) or [computed](/types/computed)).

Additionally, [ListSignal](/types/listsignal) defines convenient operators:
- <code><<</code> injects/adds all items from an iterable into the list.
- <code>&</code> forks/concatenates the list with an iterable into a new [ListSignal](/types/listsignal).
- <code>|</code> pipes/concatenates the list with another signal holding an iterable into a new [ListSignal](/types/listsignal).

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
do not need to assign <code>numbers.value = ...</code> manually!
</Success>


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="listsignal"></a><a name="listsignal"></a>`ListSignal(super.value, {ListSignalOptions<E>? options, @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ListSignalOptions(name: ...) instead') String? debugLabel})`

Creates a [ListSignal](/types/listsignal) with the given **value**.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="<<"></a>`ListSignal<E> <<(Iterable<E> other)`

Inject: Update current signal value with iterable

##### <a name="&"></a>`ListSignal<E> &(Iterable<E> other)`

Fork: create a new signal which value is the concatenation of source signal and iterable parameter

##### <a name="|"></a>`ListSignal<E> |(Signal<Iterable<E>> other)`

Pipe: create a new signal by sending value from source to other

##### <a name="=="></a>`bool ==(Object other)`

##### <a name="hashcode"></a>`int hashCode`

</details>



---

## listSignal

Creates a [ListSignal](/types/listsignal) initialized with the provided **list**.

This is a convenience helper function for creating reactive list signals.

```dart
import 'package:signals/signals.dart';

final list = listSignal([1, 2, 3]);
```
