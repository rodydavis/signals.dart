---
title: MapSignal
description: Creates a signal that implements Map
---

Map signals can be created by extension or method and implement the [Map](https://api.dart.dev/stable/3.2.1/dart-core/Map-class.html) interface.

### mapSignal, MapSignal

```dart
final s = mapSignal({'a': 1, 'b': 2, 'c': 3});
```

### toSignal()

```dart
final s = {'a': 1, 'b': 2, 'c': 3}.toSignal();
```
