# Primitive: `FutureSignal`

- **Category**: Primitive
- **Description**: Bypasses stream subscription overhead and resolves the future-evaluation loop elegantly.

---

## Standard Usage Example

```dart
final userProfile = futureSignal(() => fetchProfile(userId.value));

```
