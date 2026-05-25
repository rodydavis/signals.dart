# `connect` Connectors

`connect` provides a streamlined way to pipe events from external futures, streams, or signals directly into a target mutable signal.

---

## 1. Creation

```dart
final count = signal(0);
final connector = connect(count);

// Connect a stream
connector.from(myEventStream);

// Dispose connector
connector.dispose();
```

---

## 2. Dynamic Redirection
You can add or remove multiple async streams dynamically to single targets without tearing down the target signal itself, facilitating modular event-driven pipeline composition.
