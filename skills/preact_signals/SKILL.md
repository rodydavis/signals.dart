---
name: preact_signals
description: Core reactive programming best practices and primitive definitions for preact_signals in Dart.
---

# Preact Signals in Dart

This skill covers the core reactive programming primitives and implementation patterns of the `preact_signals` package.

---

## 1. Core Primitives

### A. `Signal<T>`
A state primitive representing a mutable value that can be observed.
```dart
final count = signal(0);
count.value = 1; // Notifies all active subscribers/effects
```

### B. `Computed<T>`
A derived state primitive representing a read-only value calculated based on other signals. It is:
- **Lazy**: Evaluated only when accessed.
- **Memoized**: Caches its value and only recompute when its source dependencies change.
```dart
final count = signal(2);
final double = computed(() => count.value * 2);
```

### C. `Effect`
An observer that executes a callback immediately and tracks read signals. It re-runs whenever any of the tracked signals change.
```dart
final dispose = effect(() {
  print('Current count: ${count.value}');
});
dispose(); // Clean up subscription
```

---

## 2. Dependency Tracking & Re-entrancy Rules

- **Synchronous Context**: Dependencies are tracked dynamically based on which signals are read during the execution of the callback.
- **Cycle Detection**: Reading a computed signal inside its own execution flow or setting dependencies inside computed callbacks causes cycles. Avoid side-effects inside computed getters.
- **Lazy Initial Value**: Lazy computed signals are not evaluated when created. Always call `isInitialized` or check the initialization status before forcing a `.peek()` inside observers to avoid re-entrancy cycle crashes.
