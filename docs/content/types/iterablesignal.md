---
title: "Type: IterableSignal"
description: "API reference and details for IterableSignal from signals.dart."
---

# IterableSignal

<Info>
  <strong>Kind:</strong> <code>class & function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: IterableSignal

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

### Members of IterableSignal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **IterableSignal** | <code>constructor</code> | <code>dart IterableSignal(super.value, {IterableSignalOptions<E>? options, @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: IterableSignalOptions(name: ...) instead') String? debugLabel})</code> | Creates a [IterableSignal](/types/iterablesignal) with the given **value**. |
| **==** | <code>method</code> | <code>dart bool ==(Object other)</code> |  |
| **hashCode** | <code>method</code> | <code>dart int hashCode</code> |  |

## Function: iterableSignal

```dart
IterableSignal<T> iterableSignal(Iterable<T> iterable, {IterableSignalOptions<T>? options, @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: IterableSignalOptions(name: ...) instead') String? debugLabel})
```

Creates an [IterableSignal](/types/iterablesignal) holding the provided **iterable**.

This is a convenience function that instantiates an [IterableSignal](/types/iterablesignal), which delegates
all standard **Iterable** operations reactively and tracks changes.

### Example Usage

```dart
import 'package:signals/signals.dart';

final s = iterableSignal([1, 2, 3]);
print(s.length); // 3
```

## References

The **IterableSignal** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [IterableSignal](/packages/signals_flutter/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [signals_flutter](/packages/signals_flutter)
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [IterableSignal](/packages/signals_core/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [signals_core](/packages/signals_core)
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [IterableSignal](/packages/signals/value/iterable) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [signals](/packages/signals)
* [useIterableSignal](/packages/signals_hooks/hooks/use-iterable-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-hooks AI Skill](/skills/signals-hooks) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

