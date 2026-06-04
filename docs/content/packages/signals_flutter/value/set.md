---
title: SetSignal
description: A reactive Signal that holds a Set and implements the Set interface.
---

A reactive [Signal](/types/signal) that holds a **Set** and implements the **Set** interface.

[SetSignal](/types/setsignal) lets you listen to changes on a set reactively and mutate it directly using
standard set operations (like <code>add</code>, <code>addAll</code>, <code>remove</code>, <code>clear</code>, etc.). Any mutations
automatically trigger reactive updates to all active listeners (e.g., inside an [effect](/types/effect)
or [computed](/types/computed)).

Additionally, [SetSignal](/types/setsignal) defines convenient operators:
- <code><<</code> injects/adds all items from another set into the current set.
- <code>&</code> forks/unions the set with another set into a new [SetSignal](/types/setsignal).
- <code>|</code> pipes/unions the set with another signal holding an iterable into a new [SetSignal](/types/setsignal).

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
do not need to assign <code>numbers.value = ...</code> manually!
</Success>


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="setsignal"></a><a name="setsignal"></a><code>SetSignal(super.value, {SetSignalOptions<E>? options, @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SetSignalOptions(name: ...) instead') String? debugLabel})</code>

Creates a [SetSignal](/types/setsignal) with the given **value**.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="<<"></a><code>SetSignal<E> <<(Set<E> other)</code>

Inject: Update current signal value with iterable

##### <a name="&"></a><code>SetSignal<E> &(Set<E> other)</code>

Fork: create a new signal with value is the concatenation of source signal and iterable parameter

##### <a name="|"></a><code>SetSignal<E> |(Signal<Iterable<E>> other)</code>

Pipe: create a new signal by sending value from source to other

##### <a name="=="></a><code>bool ==(Object other)</code>

##### <a name="hashcode"></a><code>int hashCode</code>

</details>



---

## setSignal

Creates a [SetSignal](/types/setsignal) initialized with the provided **set**.

This is a convenience helper function for creating reactive set signals.

```dart
import 'package:signals/signals.dart';

final mySet = setSignal({1, 2, 3});
```
