---
title: "Type: ListSignal"
description: "API reference and details for ListSignal from signals.dart."
---

# ListSignal

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: ListSignal

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

### Members of ListSignal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **ListSignal** | <code>constructor</code> | <code>dart ListSignal(super.value, {ListSignalOptions<E>? options, @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ListSignalOptions(name: ...) instead') String? debugLabel})</code> | Creates a [ListSignal](/types/listsignal) with the given **value**. |
| **<<** | <code>method</code> | <code>dart ListSignal<E> <<(Iterable<E> other)</code> | Inject: Update current signal value with iterable |
| **&** | <code>method</code> | <code>dart ListSignal<E> &(Iterable<E> other)</code> | Fork: create a new signal which value is the concatenation of source signal and iterable parameter |
| **|** | <code>method</code> | <code>dart ListSignal<E> |(Signal<Iterable<E>> other)</code> | Pipe: create a new signal by sending value from source to other |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## Function: listSignal

```dart
ListSignal<T> listSignal(List<T> list, {ListSignalOptions<T>? options, @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ListSignalOptions(name: ...) instead') String? debugLabel})
```

Creates a [ListSignal](/types/listsignal) initialized with the provided **list**.

This is a convenience helper function for creating reactive list signals.

```dart
import 'package:signals/signals.dart';

final list = listSignal([1, 2, 3]);
```

## References

The **ListSignal** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [IterableSignalMixin](/packages/signals_flutter/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [ListSignal](/packages/signals_flutter/value/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [IterableSignal](/packages/signals_flutter/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [signals_flutter](/packages/signals_flutter)
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [IterableSignalMixin](/packages/signals_core/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [ListSignal](/packages/signals_core/value/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [IterableSignal](/packages/signals_core/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [signals_core](/packages/signals_core)
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [IterableSignalMixin](/packages/signals/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [ListSignal](/packages/signals/value/list) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [IterableSignal](/packages/signals/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [signals](/packages/signals)
* [useListSignal](/packages/signals_hooks/hooks/use-list-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>

