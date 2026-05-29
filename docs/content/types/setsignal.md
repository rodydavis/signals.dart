---
title: "Type: SetSignal"
description: "API reference and details for SetSignal from signals.dart."
---

# SetSignal

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: SetSignal

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

### Members of SetSignal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SetSignal** | <code>constructor</code> | <code>dart SetSignal(super.value, {SetSignalOptions<E>? options, @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SetSignalOptions(name: ...) instead') String? debugLabel})</code> | Creates a [SetSignal](/types/setsignal) with the given **value**. |
| **<<** | <code>method</code> | <code>dart SetSignal<E> <<(Set<E> other)</code> | Inject: Update current signal value with iterable |
| **&** | <code>method</code> | <code>dart SetSignal<E> &(Set<E> other)</code> | Fork: create a new signal with value is the concatenation of source signal and iterable parameter |
| **|** | <code>method</code> | <code>dart SetSignal<E> |(Signal<Iterable<E>> other)</code> | Pipe: create a new signal by sending value from source to other |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## Function: setSignal

```dart
SetSignal<T> setSignal(Set<T> list, {SetSignalOptions<T>? options, @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: SetSignalOptions(name: ...) instead') String? debugLabel})
```

Creates a [SetSignal](/types/setsignal) initialized with the provided **set**.

This is a convenience helper function for creating reactive set signals.

```dart
import 'package:signals/signals.dart';

final mySet = setSignal({1, 2, 3});
```

## References

The **SetSignal** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [SignalsMixin](/packages/signals_flutter/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [IterableSignalMixin](/packages/signals_flutter/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [SetSignal](/packages/signals_flutter/value/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [IterableSignal](/packages/signals_flutter/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [signals_flutter](/packages/signals_flutter)
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [IterableSignalMixin](/packages/signals_core/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [SetSignal](/packages/signals_core/value/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [IterableSignal](/packages/signals_core/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [signals_core](/packages/signals_core)
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [SignalsMixin](/packages/signals/mixins/signals-mixin) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [IterableSignalMixin](/packages/signals/mixins/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [SetSignal](/packages/signals/value/set) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [IterableSignal](/packages/signals/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [signals](/packages/signals)
* [useSetSignal](/packages/signals_hooks/hooks/use-set-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-hooks AI Skill](/skills/signals-hooks) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-migration-6-to-7 AI Skill](/skills/signals-migration-6-to-7) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-flutter AI Skill](/skills/signals-flutter) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

