---
title: ChangeStackSignal
description: A reactive Signal that records its history of values, allowing undo and redo operations.
---

A reactive [Signal](/packages/signals/core/signal) that records its history of values, allowing undo and redo operations.

[ChangeStackSignal](/packages/signals/value/change-stack) stores successive values of the signal in a double-ended queue.
This allows you to revert back to previous values using **undo** and re-apply undone values
using **redo**. You can also specify an optional **limit** parameter to cap the history queue size.

<Info>
If you only need access to the initial and immediate previous values of a signal (without a full
history stack or undo/redo mechanisms), use the lightweight [TrackedSignalMixin](/packages/signals/mixins/tracked) instead.
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


### Constructors

<details>
<summary> View Constructors </summary>

##### <a name="changestacksignal"></a><a name="changestacksignal"></a>`ChangeStackSignal(super.value, {int? limit, ChangeSignalOptions<T>? options, @Deprecated('Use options: ChangeSignalOptions(autoDispose: ...) instead') bool? autoDispose, @Deprecated('Use options: ChangeSignalOptions(name: ...) instead') String? debugLabel})`

Creates a [ChangeStackSignal](/packages/signals/value/change-stack) initialized with the provided **value**.

</details>
