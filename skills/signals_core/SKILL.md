---
name: signals_core
description: Advanced reactive state primitives, collections, mixins, and utilities of signals_core.
---

# Signals Core Advanced Primitives

This skill details advanced state management primitives, reactive collections, async features, and value options semantics in `signals_core`.

---

## 1. Writable Computed Signal (`linkedSignal`)

A writable computed signal (`LinkedSignal`) provides a derived default value that can be overridden manually, resetting back to the derived default whenever its upstream dependencies mutate.

### Usage
```dart
// Basic reset shorthand:
final size = signal('M');
final selection = linkedSignal(() => size.value);

// Advanced structural comparison:
final user = signal((id: 1, name: 'Alice'));
final name = linkedSignalOptions<String, ({int id, String name})>(
  source: () => user.value,
  computation: (u, prev) {
    if (prev != null && prev.source.id == u.id) {
      return prev.value; // Retain manual override
    }
    return u.name; // Reset on ID changes
  },
);
```

---

## 2. Collections and Async Primitives

### A. Collections
Always use specialized collections (`listSignal`, `setSignal`, `mapSignal`, etc.) to wrap collections to ensure optimized mutations (only triggering updates when elements actually change).
```dart
final list = listSignal([1, 2], options: ListSignalOptions(autoDispose: true));
list.add(3); // Reacts to changes
```

### B. Optimized FutureSignal
`FutureSignal` inherits directly from `AsyncSignal` to bypass Stream subscription overhead and tracks its dependencies manually via computed execution, executing future computations exactly once (avoiding double-evaluation loops).
```dart
final search = signal('');
final results = futureSignal(() => fetchResults(search.value));
```

---

## 3. Options Classes Value Semantics

All signal option objects support full value semantics (`copyWith`, custom equality, and `hashCode` overrides) for flexible copying and accurate comparisons:
- `SignalOptions`
- `ComputedOptions`
- `AsyncSignalOptions`
- `LinkedSignalOptions`
- `ListSignalOptions` / `SetSignalOptions` / `MapSignalOptions`
