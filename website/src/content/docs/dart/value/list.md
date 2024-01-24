---
title: ListSignal
description: Creates a signal that implements List
---

List signals can be created by extension or method and implement the [List](https://api.dart.dev/stable/3.2.1/dart-core/List-class.html) interface.

This makes them useful for creating signals from existing lists, or for creating signals that can be used as lists.

### listSignal, ListSignal

```dart
final s = listSignal([1, 2, 3]);
```

### toSignal()

```dart
final s = [1, 2, 3].toSignal();
```

## Methods

List modifications are done directly on the underlying list, and will trigger signals as expected.

```dart

final s1 = listSignal([1, 2, 3]);

// by index
s1[0] = -1;
print(s1.length); // 3

// expose common Dart List interfaces
s1.addAll([4, 5, 6]);
s1.first = 1;

// extended operators
final s2 = s1 & [3, 4, 5];

```
