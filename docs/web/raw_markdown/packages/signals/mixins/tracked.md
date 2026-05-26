---
title: TrackedSignalMixin
description: A mixin that adds tracking for the initial and previous values to a Signal.
---

A mixin that adds tracking for the initial and previous values to a [Signal](/packages/signals/core/signal).

[TrackedSignalMixin](/packages/signals/mixins/tracked) stores the `initialValue` (the value the signal had when it was
created or initialized) and the `previousValue` (the value of the signal right before
the most recent update).

<Info>
If you are looking for full undo/redo capabilities, use [ChangeStackSignalMixin](/packages/signals/mixins/change-stack) instead.
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

class MyTrackedSignal extends Signal<int> with TrackedSignalMixin<int> {
  MyTrackedSignal(super.internalValue);
}

void main() {
  final signal = MyTrackedSignal(0);

  print('Initial: ${signal.initialValue}');   // Prints: "Initial: 0"
  print('Previous: ${signal.previousValue}'); // Prints: "Previous: null"

  signal.value = 1;
  print('Initial: ${signal.initialValue}');   // Prints: "Initial: 0"
  print('Previous: ${signal.previousValue}'); // Prints: "Previous: 0"

  signal.value = 2;
  print('Initial: ${signal.initialValue}');   // Prints: "Initial: 0"
  print('Previous: ${signal.previousValue}'); // Prints: "Previous: 1"
}
```

<Warning>
This mixin only works with values that are immutable or are copied/cloned on mutation.
If the value is mutated directly in-place without re-assigning, `initialValue` and
`previousValue` will end up pointing to the same modified instance as the current value.
</Warning>


### Methods

##### <a name="initialvalue"></a>`T initialValue`

The initial value the signal was created with

##### <a name="previousvalue"></a>`T? previousValue`

Get the previous value (if exists)

##### <a name="aftercreate"></a>`void afterCreate(T val)`

##### <a name="beforeupdate"></a>`void beforeUpdate(val)`
