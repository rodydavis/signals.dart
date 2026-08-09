# `.watch(context)` Extension

The `.watch(context)` extension provides a seamless way to listen to signal modifications directly within standard Flutter widget build trees.

---

## 1. Creation

```dart
final name = signal('Bob');

Widget build(BuildContext context) {
  // Subscribes the context to name's mutations!
  final currentName = name.watch(context);
  return Text('Name: $currentName');
}
```

---

## 2. Dynamic Memory Management
- **Teardown Lifecycle**: Subscriptions are bound to the element context using dynamic VM Expandos and clean finalizer callbacks.
- **Auto Disposal**: When the element is unmounted, subscriptions are cleanly torn down to protect against memory leaks.
