# Primitive: `Signal Container`

- **Category**: Utilities
- **Description**: Returns a mutable parameterized caching Signal Container.

---

## Standard Usage Example

```dart
final activeCounters = signalContainer<String, int>((key) {
  return signal(0);
});

```
