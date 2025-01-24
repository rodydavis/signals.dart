---
title: SetSignalMixin
description: Mixin for a Signal that adds reactive methods for Set
sidebar:
  order: 4
  badge:
    text: New
    variant: tip
---

SetSignalMixin is a mixin for a Signal that adds reactive methods for [Set](https://api.flutter.dev/flutter/dart-core/Set-class.html).

:::note
This mixin only works with signals that have a value type of `Set<T>`.
:::

```dart
class MySignal extends Signal<Set<int>>
    with IterableSignalMixin<int, Set<int>>, SetSignalMixin<int, Set<int>> {
  MySignal(super.internalValue);
}

void main() {
  final signal = MySignal({1, 2, 3});
  
  effect(() {
    print(signal.length);
  });

  signal.add(4);
  signal.remove(1);

  print(signal.contains(2)); // true
}
```
