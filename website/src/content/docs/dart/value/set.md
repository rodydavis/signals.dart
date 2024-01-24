---
title: SetSignal
description: Creates a signal that implements Set
---

Set signals can be created by extension or method and implement the [Set](https://api.dart.dev/stable/3.2.1/dart-core/Set-class.html) interface.

This makes them useful for creating signals from existing sets, or for creating signals that can be used as sets.

### setSignal, SetSignal

```dart
final s = setSignal({1, 2, 3});
```

### toSignal()

```dart
final s = {1, 2, 3}.toSignal();
```
