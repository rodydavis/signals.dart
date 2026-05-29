# `Signal<T>` Primitive

A `Signal<T>` is the fundamental reactive state primitive in `preact_signals`. It holds a single value that can be read or mutated, and automatically notifies any dependent `computed` signals or `effects` whenever its value changes.

---

## 1. Creation

```dart
// Basic Signal
final count = signal(0);

// Signal with unified Options
final name = signal(
  'Alice',
  options: SignalOptions(
    name: 'username_signal',
    autoDispose: true,
  ),
);
```

---

## 2. Reading and Writing

- **Read**: Access the current value using the `.value` getter. This registers the signal as a dependency in the current reactive context (e.g. inside `computed` or `effect`).
- **Write**: Mutate the current value using the `.value` setter. If the new value is not equal to the current value (based on the `equalityCheck` function, which defaults to standard operator `==` comparison), all active observers are notified and scheduled to recompute.

```dart
print(count.value); // Read value
count.value++;      // Write value
```

---

## 3. Options Value Semantics
You can configure a Signal's behavior using `SignalOptions<T>`, which supports:
- **`name`**: A custom string label for debugging/DevTools.
- **`autoDispose`**: When set to true, the signal automatically disposes itself when it has no active targets.
- **`watched`**: Callback triggered when the first listener subscribes.
- **`unwatched`**: Callback triggered when the last listener unsubscribes.
