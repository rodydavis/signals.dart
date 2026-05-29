# Primitive: `Computed` (prefix: `comp`)

- **Category**: Derived
- **Description**: Combine multiple signals into a derived, lazily-cached, read-only signal.

---

## Standard Usage Example

```dart
final isEven = computed(() => 
  counter.value % 2 == 0,
  options: ComputedOptions(name: 'isEven')
);

```
