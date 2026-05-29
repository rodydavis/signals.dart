# Primitive: `Signal Container (Read-only)` (prefix: `rsigcon`)

- **Category**: Utilities
- **Description**: Returns a read-only parameterized caching Signal Container.

---

## Standard Usage Example

```dart
final userContainer = readonlySignalContainer<String, User>((userId) {
  return computed(() => users.value[userId]);
});

```
