# Primitive: `Async Signal`

- **Category**: Primitive
- **Description**: An async Signal Object mapping loading, data success, and error failure states cleanly.

---

## Standard Usage Example

```dart
final data = asyncSignal(AsyncState.loading(), 
  options: AsyncSignalOptions(name: 'fetchUser')
);

```
