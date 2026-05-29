# Primitive: `Watch` (prefix: `watch`)

- **Category**: Flutter
- **Description**: Rebuilds only the wrapped closure when tracked signals change, avoiding full-widget GPU paints.

---

## Standard Usage Example

```dart
@override
Widget build(BuildContext context) {
  return Watch((context) {
    return Text('Count: ${counter.value}');
  });
}

```
