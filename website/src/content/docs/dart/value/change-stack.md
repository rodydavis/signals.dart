---
title: ChangeStack
description: Create a signal with undo/redo and replay values
---

## changeStack, ChangeStack

Change stack is a way to track the signal values overtime and undo or redo values.

```dart
final s = ChangeStackSignal(0, limit: 5);
s.value = 1;
s.value = 2;
s.value = 3;
print(s.value); // 3
s.undo();
print(s.value); // 2
s.redo();
print(s.value); // 3
```

## .clear

Clear the undo/redo stack.

## .canUndo

Returns true if there are changes in the undo stack and can move backward.

## .canRedo

Returns true if there are changes in the redo stack and can move forward.

## .limit

There is an optional limit that can be set for explicit stack size.

```dart
final s = ChangeStackSignal(0, limit: 2);
s.value = 1;
s.value = 2;
s.value = 3;
print(s.value); // 3
s.undo();
s.undo();
print(s.value); // 1
print(s.canUndo); // false
s.redo();
print(s.value); // 2
```
