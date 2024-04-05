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

## Methods

Set modifications are done directly on the underlying set and will trigger signals as expected.

```dart
final s1 = setSignal({1, 2, 3});

// mutations
s1.add(4);
s1.remove(2);

// expose common Dart Set interfaces
s1.length;                   // 3
s1.contains(3);              // true
s1.intersection({6, 2, 1});  // {1}
```
