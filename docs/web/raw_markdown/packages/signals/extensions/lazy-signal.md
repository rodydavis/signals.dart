---
title: Lazy Signal
description: Creates a lazy, mutable FlutterSignal of type T whose value can be assigned later.
---

## lazySignal

Creates a lazy, mutable [FlutterSignal](/types/fluttersignal) of type **T** whose value can be assigned later.

<Warning>
  Reading a lazy signal's value before it has been initialized will throw a runtime error.
</Warning>

### Example

```dart
final database = lazySignal<DatabaseConnection>();

// Initialize later (e.g. in initState or async initialization):
database.value = await connectToDatabase();

// Now it is safe to read:
print('Connected to: ${database.value.host}');
```
