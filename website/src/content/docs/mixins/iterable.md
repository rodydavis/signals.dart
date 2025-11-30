---
title: IterableSignalMixin
description: Mixin for a Signal that adds reactive methods for Iterable
sidebar:
  order: 4
---

IterableSignalMixin is a mixin for a Signal that adds reactive methods for [Iterable](https://api.flutter.dev/flutter/dart-core/Iterable-class.html).

:::note
This mixin only works with signals that have a value type of `Iterable<T>`.
:::

```dart
class MySignal extends Signal<Iterable<int>>
    with IterableSignalMixin<int, Iterable<int>> {
  MySignal(super.internalValue);
}

void main() {
  final signal = MySignal([1, 2, 3]);
  
  effect(() {
    print(signal.length);
  });
}
```
