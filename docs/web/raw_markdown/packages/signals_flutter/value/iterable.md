---
title: IterableSignal
description: A reactive Signal that holds an Iterable and implements the Iterable interface.
---

A reactive [Signal](/types/signal) that holds an **Iterable** and implements the **Iterable** interface.

[IterableSignal](/types/iterablesignal) allows you to listen to changes on an iterable collection reactively. It
exposes all standard **Iterable** properties and methods (like <code>length</code>, <code>first</code>, <code>map</code>, <code>where</code>, etc.)
directly on the signal itself. Calling these methods inside a reactive context (like an <code>effect</code>
or <code>computed</code> block) will automatically track them as dependencies.

### Example Usage

```dart
import 'package:signals/signals.dart';

void main() {
  final items = iterableSignal<int>([1, 2, 3]);

  effect(() {
    print('Items length: ${items.length}, First: ${items.first}');
  }); // Prints: "Items length: 3, First: 1"

  // Update the signal by assigning a new iterable
  items.value = [10, 20, 30, 40]; // Prints: "Items length: 4, First: 10"
}
```

<Warning>
Direct mutation of the items inside the iterable will NOT trigger updates. To reactively mutate collections,
use specialized signals like <a href="/types/listsignal">ListSignal</a>, <a href="/types/setsignal">SetSignal</a>, or <a href="/types/mapsignal">MapSignal</a>.
</Warning>


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="iterablesignal"></a><a name="iterablesignal"></a>`IterableSignal(super.value, {IterableSignalOptions<E>? options, @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: IterableSignalOptions(name: ...) instead') String? debugLabel})`

Creates a [IterableSignal](/types/iterablesignal) with the given **value**.

</details>


### Methods

<details>
<summary> View Methods </summary>

##### <a name="=="></a>`bool ==(Object other)`

##### <a name="hashcode"></a>`int hashCode`

</details>



---

## iterableSignal

Creates an [IterableSignal](/types/iterablesignal) holding the provided **iterable**.

This is a convenience function that instantiates an [IterableSignal](/types/iterablesignal), which delegates
all standard **Iterable** operations reactively and tracks changes.

### Example Usage

```dart
import 'package:signals/signals.dart';

final s = iterableSignal([1, 2, 3]);
print(s.length); // 3
```
