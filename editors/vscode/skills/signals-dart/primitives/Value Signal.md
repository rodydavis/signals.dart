# Primitive: `Value Signal` (prefix: `valsig`)

- **Category**: Utilities
- **Description**: Custom Value Signal class definition template.

---

## Standard Usage Example

```dart
class CounterSignal extends ValueSignal<int> {
  CounterSignal(super.value) : super(debugLabel: 'Counter');
}

```
