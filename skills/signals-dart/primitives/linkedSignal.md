# Primitive: `linkedSignal`

- **Category**: Writable Derived
- **Description**: A writable derived signal that allows manual updates and resets to a source computation on mutation.

---

## Standard Usage Example

```dart
final email = signal('bob@email.com');
final display = linkedSignal(() => email.value);

display.value = 'custom@email.com'; // write
email.value = 'alice@email.com'; // resets display to alice

```
