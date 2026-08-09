---
title: "Type: ChangeStackSignal"
description: "API reference and details for ChangeStackSignal from signals.dart."
---

# ChangeStackSignal

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Class: ChangeStackSignal

A reactive [Signal](/types/signal) that records its history of values, allowing undo and redo operations.

[ChangeStackSignal](/types/changestacksignal) stores successive values of the signal in a double-ended queue.
This allows you to revert back to previous values using **undo** and re-apply undone values
using **redo**. You can also specify an optional **limit** parameter to cap the history queue size.

<Info>
If you only need access to the initial and immediate previous values of a signal (without a full
history stack or undo/redo mechanisms), use the lightweight <a href="/types/trackedsignalmixin">TrackedSignalMixin</a> instead.
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

void main() {
  final counter = ChangeStackSignal<int>(0, limit: 5);

  effect(() {
    print('Counter: ${counter.value}');
  }); // Prints: "Counter: 0"

  counter.value = 1; // Prints: "Counter: 1"
  counter.value = 2; // Prints: "Counter: 2"

  print('Can Undo: ${counter.canUndo}'); // Prints: "Can Undo: true"

  // Perform undo operation (automatically triggers reactive updates)
  counter.undo(); // Prints: "Counter: 1"
  counter.undo(); // Prints: "Counter: 0"

  // Perform redo operation
  counter.redo(); // Prints: "Counter: 1"
}
```

<Warning>
This class works best with values that are immutable or copied when updated.
If you mutate an object in-place directly without assigning a new value using the <code>.value</code>
setter or <code>set(...)</code>, the history queue will store references to the same mutated object, and
undo/redo operations will not reflect changes correctly.
</Warning>

### Members of ChangeStackSignal

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **ChangeStackSignal** | <code>constructor</code> | <code>dart ChangeStackSignal(super.value, {int? limit, ChangeSignalOptions<T>? options, @Deprecated('Use options: ChangeSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ChangeSignalOptions(name: ...) instead') String? debugLabel})</code> | Creates a [ChangeStackSignal](/types/changestacksignal) initialized with the provided **value**. |

## References

The **ChangeStackSignal** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [ChangeStackSignal](/packages/signals_flutter/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [signals_flutter](/packages/signals_flutter)
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [ChangeStackSignal](/packages/signals_core/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [signals_core](/packages/signals_core)
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [ChangeStackSignal](/packages/signals/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [signals](/packages/signals)
* [useChangeStackSignal](/packages/signals_hooks/hooks/use-change-stack-signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_hooks/hooks)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-hooks AI Skill](/skills/signals-hooks) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

