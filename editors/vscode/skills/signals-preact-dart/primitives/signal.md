# Primitive: `signal`

- **Category**: Primitive
- **Description**: An observable box containing a mutable value. Reading its value registers a dependency implicitly.

---

## Standard Usage Example

```dart
final counter = signal(0, 
  options: SignalOptions(name: 'counter')
);

counter.value++; // triggers rebuilds

```
