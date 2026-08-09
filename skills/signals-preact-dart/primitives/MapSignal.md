# Primitive: `MapSignal`

- **Category**: Collections
- **Description**: Granular map wrapper supporting isolated dictionary element lookup triggers.

---

## Standard Usage Example

```dart
final profile = mapSignal({'username': 'alice'});
profile['username'] = 'bob'; // Mutates and triggers reactives

```
