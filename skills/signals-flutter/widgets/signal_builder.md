# `SignalBuilder` (Rebuild Isolation)

`SignalBuilder` is the primary and highly optimized widget in `signals_flutter` designed to isolate state rebuild scope inside Flutter widget subtrees.

---

## 1. Creation

In `signals.dart` v7, the builder function MUST be passed as a **named parameter `builder`** instead of a positional argument.

```dart
final count = signal(0);

Widget build(BuildContext context) {
  return Column(
    children: [
      const Text('Static Content (Never Rebuilds)'),
      SignalBuilder(
        builder: (context, value) {
          // Rebuilds ONLY when count mutates!
          return Text('Count: $value');
        },
      ),
    ],
  );
}
```

---

## 2. Advantages
- **Subtree Scoping**: Bypasses heavy ancestor element rebuild traversals.
- **Auto Dependency Disposal**: Fully cleans up subscriptions when the builder widget gets unmounted.
