---
title: Computed
description: Create a signal that derives its value from other signals
---

Data is often derived from other pieces of existing data. The `computed` function lets you combine the values of multiple signals into a new signal that can be reacted to, or even used by additional computeds. When the signals accessed from within a computed callback change, the computed callback is re-executed and its new return value becomes the computed signal's value.

> `Computed` class extends the [`Signal`](/signals.dart/dart/core/signal/) class, so you can use it anywhere you would use a signal.

```dart
import 'package:signals/signals.dart';

final name = signal("Jane");
final surname = signal("Doe");

final fullName = computed(() => name.value + " " + surname.value);

// Logs: "Jane Doe"
print(fullName.value);

// Updates flow through computed, but only if someone
// subscribes to it. More on that later.
name.value = "John";
// Logs: "John Doe"
print(fullName.value);
```

Any signal that is accessed inside the `computed`'s callback function will be automatically subscribed to and tracked as a dependency of the computed signal.

> Computed signals are both lazily evaluated and memoized

## Force Re-evaluation

You can force a computed signal to re-evaluate by calling its `.recompute` method. This will re-run the computed callback and update the computed signal's value.

```dart
final name = signal("Jane");
final surname = signal("Doe");
final fullName = computed(() => name.value + " " + surname.value);

fullName.recompute(); // Re-runs the computed callback
```

## Disposing

### Auto Dispose

If a computed signal is created with autoDispose set to true, it will automatically dispose itself when there are no more listeners.

```dart
final s = computed(() => 0, autoDispose: true);
s.onDispose(() => print('Signal destroyed'));
final dispose = s.subscribe((_) {});
dispose();
final value = s.value; // 0
// prints: Signal destroyed
```

A auto disposing signal does not require its dependencies to be auto disposing. When it is disposed it will freeze its value and stop tracking its dependencies.

This means that it will no longer react to changes in its dependencies.

```dart
final s = computed(() => 0);
s.dispose();
final value = s.value; // 0
final b = computed(() => s.value); // 0
// b will not react to changes in s
```

You can check if a signal is disposed by calling the `.disposed` method.

```dart
final s = computed(() => 0);
print(s.disposed); // false
s.dispose();
print(s.disposed); // true
```

### On Dispose Callback

You can attach a callback to a signal that will be called when the signal is destroyed.

```dart
final s = computed(() => 0);
s.onDispose(() => print('Signal destroyed'));
s.dispose();
```
