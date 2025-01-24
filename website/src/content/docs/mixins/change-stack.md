---
title: ChangeStackSignalMixin
description: Mixin for a Signal that adds undo and redo functionality
sidebar:
  order: 2
  badge:
    text: New
    variant: tip
---

ChangeStackSignalMixin is a mixin for a Signal that adds undo and redo functionality.

:::note
If you are just looking for initial and previous values, use the [TrackedSignalMixin](/mixins/tracked).
:::

```dart
class MySignal extends Signal<int> with ChangeStackSignalMixin<int> {
  MySignal(super.internalValue);
}

void main() {
  final signal = MySignal(0);
  
  signal.value = 1;
  print(signal.canUndo); // true
  signal.undo();
  print(signal.value); // 0
  print(signal.canUndo); // false
  signal.redo();
  print(signal.value); // 1
}
```

:::caution
This mixin only works with values that are immutable or are copied when changed otherwise the initial and previous value will always be the same.
:::

## Setting a limit

You can set a limit to the number of changes that can be undone with the `limit` parameter.

```diff
class MySignal extends Signal<int> with ChangeStackSignalMixin<int> {
  MySignal(int value) : super(value);

+  @override
+  int limit = 3;
}