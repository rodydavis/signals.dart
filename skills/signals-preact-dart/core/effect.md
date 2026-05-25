# `Effect` Side Effects

An `Effect` is an active observer that executes a callback function immediately, tracks any signals read during execution, and automatically re-runs that callback whenever those signals change.

---

## 1. Creation

```dart
final count = signal(0);

final dispose = effect(
  () {
    print('The current count is: ${count.value}');
  },
  options: EffectOptions(
    name: 'print_count_effect',
  ),
);
```

---

## 2. Dynamic Unsubscription
To stop an effect from running permanently, call the returned `dispose()` function.
```dart
dispose(); // Disposes the effect subscription cleanly
```

---

## 3. Dynamic Dependency Tracking
Just like `Computed`, `Effect` tracks only the signals that are read dynamically in its current execution path. If the flow switches branches, older dependencies are cleanly unsubscribed to prevent memory leaks and redundant executions.
