# `Computed<T>` Derived State

A `Computed<T>` is a read-only signal that derives its value from other signals. It is lazily evaluated, cached (memoized), and automatically tracks its reactive dependencies.

---

## 1. Creation

```dart
final first = signal('John');
final last = signal('Doe');

final fullName = computed(
  () => '${first.value} ${last.value}',
  options: ComputedOptions(
    name: 'full_name_computed',
    autoDispose: true,
  ),
);
```

---

## 2. Key Attributes

1. **Lazy Evaluation**: The computation function (`fn`) does NOT execute when the computed signal is created. It only runs when the `.value` or `.peek()` is explicitly read.
2. **Memoization**: Once calculated, the value is cached. Subsequent reads will return the cached value instantly without re-running the computation, unless an upstream dependency has changed.
3. **Dynamic Dependency Tracking**: Upstream dependencies are tracked dynamically on every run. If a conditional branch changes, only the currently active signals will be tracked as sources.

---

## 3. Re-entrancy and Cycle Safeguards
- **Cycle Detected**: Reading a computed signal inside its own computation function is circular and throws a cyclical dependency exception.
- **Re-entrancy in Observers**: If a global observer (like `DevToolsSignalsObserver`) executes a `.peek()` on an uninitialized computed signal, it forces evaluation. To prevent infinite loops/re-entrancy during creation, always check `isInitialized` before calling `peek()`.
