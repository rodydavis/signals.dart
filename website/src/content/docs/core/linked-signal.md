---
title: Linked Signal
description: How to create and use a linked signal
sidebar:
  order: 5
---

A `linkedSignal` is a specialized reactive primitive that acts as a **writable computed signal**.

Normally, a standard `computed()` signal is strictly read-only. However, in many scenarios you want a signal that derives its default or initial value from another signal, but *also* allows the user to manually override it. Whenever its source dependencies mutate, the linked signal automatically resets back to its computed default value.

Common use cases include:
- **Forms**: Resetting a "quantity" or "options" field back to its default when the user selects a completely different product.
- **Pagination**: Automatically jumping back to page `1` when a user types a new search query.
- **Defaults**: Loading default settings from an API but allowing a user to toggle them locally before hitting "Save".

---

## 1. Shorthand Syntax (Basic Reset)

If you want a signal to reset to a specific derived value whenever its source dependencies change, pass a computation function representing the source.

```dart
import 'package:signals/signals.dart';

// Source signal
final availableSizes = signal(['S', 'M', 'L']);

// Linked signal: defaults to the first available size
final selectedSize = linkedSignal(() => availableSizes.value[0]);

print(selectedSize.value); // 'S'

// Unlike computed(), you CAN manually update a linkedSignal!
selectedSize.value = 'M';
print(selectedSize.value); // 'M'

// If the source changes, selectedSize automatically resets back to the new default
availableSizes.value = ['XL', 'XXL'];
print(selectedSize.value); // 'XL'
```

---

## 2. Advanced Options Syntax (Custom Computation & Previous State)

Sometimes you want strict control over exactly what triggers the reset, or you need to know what the *previous* value of the signal was before it was reset. You can do this by using the `linkedSignalOptions` function and providing a custom `source` and `computation` callback.

The `computation` callback has access to the current source value and a `previous` object containing:
- `previous.source`: The previous value of the source callback.
- `previous.value`: The previous value of the `LinkedSignal` before the reset was triggered (which could be the last computed value or a manual user override).

```dart
import 'package:signals/signals.dart';

final user = signal((id: 1, name: 'Alice'));

// Explicitly link to a source and define custom reset logic
final nickname = linkedSignalOptions<String, ({int id, String name})>(
  source: () => user.value,
  computation: (currentUser, previous) {
    // If the user already set a custom nickname, keep it across source changes
    if (previous != null) {
      return previous.value;
    }
    // Otherwise, default to the real name
    return currentUser.name;
  },
);

print(nickname.value); // 'Alice'

// Manually override
nickname.value = 'Ali';
print(nickname.value); // 'Ali'

// Change user to Bob
user.value = (id: 2, name: 'Bob');

// The custom computation says: if there is a previous value, keep it!
print(nickname.value); // 'Ali'
```

---

## Disposing

Just like standard signals, when you no longer need a `LinkedSignal`, you should dispose of it to clean up internal computed nodes and subscription listeners.

```dart
final source = signal(10);
final linked = linkedSignal(() => source.value);

// Dispose of the signal
linked.dispose();

print(linked.disposed); // true
```
