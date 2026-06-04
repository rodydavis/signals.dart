# `ReadonlySignal<T>` Interface

`ReadonlySignal<T>` is the abstract base interface for all signals that expose a read-only view. This guarantees that consumers cannot directly mutate the internal value, promoting clean unidirectional data flow.

---

## 1. Casting and Helper Methods

You can convert any standard writeable `Signal<T>` into a `ReadonlySignal<T>` to expose safely to other layers or UI elements.

```dart
final _counter = signal(0);

// Expose counter as a readonly signal
ReadonlySignal<int> get counter => _counter.readonly();
```

---

## 2. Key Methods

- **`.value`**: Gets the current value and registers a dependency.
- **`.peek()`**: Safely retrieves the current value WITHOUT registering a dependency. This is crucial for avoiding unwanted or circular tracking inside event callbacks or observers.
- **`isInitialized`**: Returns true if the signal's value has been initialized (mostly relevant for lazy and computed signals).
