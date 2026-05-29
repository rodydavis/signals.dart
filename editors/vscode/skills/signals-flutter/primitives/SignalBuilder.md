# Primitive: `SignalBuilder` (prefix: `sigb`)

- **Category**: Flutter
- **Description**: Subscribes to a single signal, rebuilding only this local builder block when it changes.

---

## Standard Usage Example

```dart
SignalBuilder(
  builder: (context, value) {
    return Text('Value: $value');
  },
)

```
