# `ListSignal<T>` (Reactive Lists)

`ListSignal<T>` provides a reactive wrapper around standard Dart lists, automatically intercepting mutations and notifying active subscribers.

---

## 1. Creation

```dart
final items = listSignal(
  [1, 2, 3],
  options: ListSignalOptions(
    name: 'items_list',
    autoDispose: true,
  ),
);
```

---

## 2. Mutations and Read Operations

All standard `List` methods (`add`, `remove`, `clear`, index access) are fully supported:

```dart
items.add(4); // Automatically triggers updates
items[0] = 10; // Automatically triggers updates
```

---

## 3. High Performance
- Updates are coalesced to prevent redundant render or computational frames.
- When passing option objects, always use `ListSignalOptions` to define custom deep constraints or labels.
