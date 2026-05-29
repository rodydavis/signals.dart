# Primitive: `StreamSignal` (prefix: `strsig`)

- **Category**: Primitive
- **Description**: Dynamic, lifecycle-safe, self-disposing stream listener mapping to async loading/data/error states.

---

## Standard Usage Example

```dart
final messages = streamSignal(() => chatSocket.messages);

```
