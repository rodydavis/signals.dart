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

## Methods

Map modifications are done directly on the underlying map and will trigger signals as expected.

```dart
final s1 = mapSignal({'a': 1, 'b': 2, 'c': 3});

// by key
s1['a'] = -1;
s1['d'] = 7;
s1['d'];         // 7

// expose common Dart Map interfaces
s1.addAll({'e': 6, 'f': 7});
s1.remove('b');
s1.keys.length;  // 5
```
