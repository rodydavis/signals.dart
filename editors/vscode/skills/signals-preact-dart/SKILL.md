---
name: signals-preact-dart
description: Core reactive programming best practices and primitive definitions for preact_signals in Dart.
---

# Preact Signals in Dart

This skill covers the core reactive programming primitives and implementation patterns of the `preact_signals` package.

## Related Documentation & Items

| Related File | Description |
|---|---|
| [signal.md](core/signal.md) | Standard writeable reactive state primitive containing value accessors, mutation mechanics, and basic custom options. |
| [computed.md](core/computed.md) | Lazy, memoized read-only derived state signal tracking reactive dependencies dynamically. |
| [effect.md](core/effect.md) | Synchronous observer managing active subscription loops, dynamic dependency updates, and lifecycle teardown. |
| [readonly.md](core/readonly.md) | Read-only signal views ensuring unidirectional data access flows. |
| [batch.md](core/batch.md) | Transactional state mutation blocks optimizing reactive computations and preventing rendering/recompute churn. |

---

## Core Primitives Quick Start Guide

The signals library exposes five core functions which are the building blocks to model any reactive business logic.

### 1. `signal(initialValue)`
Creates a new mutable signal container. You read a signal's value or subscribe to updates by accessing `.value`.
```dart
final counter = signal(0);
print(counter.value); // 0
counter.value = 1; // Mutates value and schedules dependent updates
```

#### `.peek()`
Reads a signal's current value *without* subscribing to its mutations.
```dart
final counter = signal(0);
final logCount = signal(0);

effect(() {
  print(counter.value);
  // Read using peek to avoid subscribing/triggering loop
  logCount.value = logCount.peek() + 1;
});
```

### 2. `untracked(fn)`
Executes a callback that reads signals without subscribing to any of them.
```dart
final counter = signal(0);
final count = signal(0);

effect(() {
  print(counter.value);
  count.value = untracked(() => count.value + 1);
});
```

### 3. `computed(fn)`
Combines the values of multiple signals into a lazy, memoized derived signal.
```dart
final first = signal('John');
final last = signal('Doe');
final fullName = computed(() => '${first.value} ${last.value}');
print(fullName.value); // John Doe
```

### 4. `effect(fn)`
Orchestrates immediate synchronous side effects by running a callback and subscribing to any signals read within it.
```dart
final name = signal('Jane');
final dispose = effect(() => print('Hello $name'));
dispose(); // Clean up subscription
```

### 5. `batch(fn)`
Groups multiple signal writes into a single transaction, executing all dependent computed evaluations and effects exactly once at the end.
```dart
final a = signal(0);
final b = signal(0);

batch(() {
  a.value = 1;
  b.value = 2;
});
```

---

## 1. Core Primitives Details

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
