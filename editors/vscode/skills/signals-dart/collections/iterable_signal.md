# `IterableSignal<T>` (Reactive Iterables)

`IterableSignal<T>` wraps standard lazy Dart iterables, enabling reactive subscription streams over dynamic traversals.

---

## 1. Creation

```dart
final sequence = iterableSignal(
  [1, 2, 3].map((x) => x * 2),
  options: IterableSignalOptions(
    name: 'lazy_sequence',
  ),
);
```
- Custom collections should utilize `IterableSignalOptions` to define name and autoDispose options.
