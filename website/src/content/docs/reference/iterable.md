---
title: Iterable Signal
description: Creates a signal that implements Iterable
---

Iterable signals can be created by extension or method and implement the [Iterable](https://api.dart.dev/stable/3.2.1/dart-core/Iterable-class.html) interface.

### iterableSignal

```dart
final iterable = () sync* {...};

final s = iterableSignal(iterable);
```

### toSignal()

```dart
final iterable = () sync* {...};

final s = iterable.toSignal();
```
