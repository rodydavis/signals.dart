---
title: QueueSignalMixin
description: Mixin for a Signal that adds reactive methods for Queue
sidebar:
  order: 4
---

QueueSignalMixin is a mixin for a Signal that adds reactive methods for [Queue](https://api.flutter.dev/flutter/dart-collection/Queue-class.html).

:::note
This mixin only works with signals that have a value type of `Queue<T>`.
:::

```dart
class MySignal extends Signal<Queue<int>>
    with QueueSignalMixin<int, Queue<int>> {
  MySignal(super.internalValue);
}

void main() {
  final q = Queue<int>();
  a.addFirst(1);
  final signal = MySignal(q);
  
  effect(() {
    print(signal.length);
  });

  signal.addLast(4);
}
```
