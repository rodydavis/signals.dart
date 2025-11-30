---
title: TrackedSignalMixin
description: Mixin for a Signal that stores the initial and previous value
sidebar:
  order: 3
---

TrackedSignalMixin is a mixin for a Signal that stores the initial and previous value.

:::note
If you are looking for undo/redo functionality, use the [ChangeStackSignalMixin](/mixins/change-stack).
:::

```dart
class MySignal extends Signal<int> with TrackedSignalMixin<int> {
  MySignal(super.internalValue);
}

void main() {
  final signal = MySignal(0);
  
  signal.value = 1;
  print(signal.initialValue); // 0
  print(signal.previousValue); // null

  signal.value = 2;
  print(signal.initialValue); // 0
  print(signal.previousValue); // 1
}
```

:::caution
This mixin only works with values that are immutable or are copied when changed otherwise the initial and previous value will always be the same.
:::
