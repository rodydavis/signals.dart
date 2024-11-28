---
title: ListSignalMixin
description: Mixin for a Signal that adds reactive methods for List
sidebar:
  order: 4
  badge:
    text: New
    variant: tip
---

ListSignalMixin is a mixin for a Signal that adds reactive methods for [List](https://api.flutter.dev/flutter/dart-core/List-class.html).

:::note
This mixin only works with signals that have a value type of `List<T>`.
:::

```dart
class MySignal extends Signal<List<int>> with ListSignalMixin<int> {
  MySignal(List<int> value) : super(value);
}

void main() {
  final signal = MySignal([1, 2, 3]);
  
  effect(() {
    print(signal.length);
  });

  signal.add(4);
  signal.remove(1);

  print(signal.contains(2)); // true
}
```
