# `computedAsync`

`computedAsync` is a powerful utility designed to easily compose async operations from other signals. It returns an `AsyncSignal<T>` that automatically runs an async calculation whenever its upstream synchronous dependencies mutate.

---

## 1. Creation

```dart
final id = signal(1);

final profile = computedAsync(
  () => fetchProfile(id.value),
  options: AsyncSignalOptions(
    initialValue: null,
  ),
);
```

---

## 2. Benefits
- **Simplifies Dependency Propagation**: Avoids having to manually listen to synchronous updates and invoke async futures.
- **Race Condition Immunity**: Guarantees that newer async executions discard older, slow responses, protecting against out-of-order state corruptions.
