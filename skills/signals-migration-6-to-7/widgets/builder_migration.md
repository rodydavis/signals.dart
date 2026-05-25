# SignalBuilder Migration

In version 7.0.0, the `SignalBuilder` constructor has changed from accepting a positional callback argument to requiring a named `builder` parameter.

---

## 1. Migrating `SignalBuilder`

- **Before**:
  ```dart
  SignalBuilder(
    (context, value) => Text('Count: $value'),
  )
  ```
- **After**:
  ```dart
  SignalBuilder(
    builder: (context, value) => Text('Count: $value'),
  )
  ```
- This helps make widget declarations much more readable and aligns with modern Flutter standards (e.g. `AnimatedBuilder`, `ValueListenableBuilder`).
