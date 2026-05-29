# Primitive: `ChangeStackSignal` (prefix: `undosig`)

- **Category**: Utilities
- **Description**: Track signal values over time, exposing simple, robust undo/redo capabilities.

---

## Standard Usage Example

```dart
final history = changeStack(0);
history.value = 1;
history.undo(); // back to 0

```
