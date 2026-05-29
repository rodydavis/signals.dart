# Primitive: `SignalEffect`

- **Category**: Flutter
- **Description**: Executes standard Flutter side effects (Snackbars, dialogs) inside widget lifecycles safely.

---

## Standard Usage Example

```dart
SignalEffect(
  callback: (context) {
    if (error.value != null) {
      showDialog(...);
    }
  },
  child: MyContent(),
)

```
