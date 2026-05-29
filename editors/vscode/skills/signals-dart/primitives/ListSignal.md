# Primitive: `ListSignal` (prefix: `lstsig`)

- **Category**: Collections
- **Description**: Optimized list wrapper proxying standard operations to support element-level reactivity.

---

## Standard Usage Example

```dart
final items = listSignal([1, 2]);
items.add(3); // Reacts automatically

```
