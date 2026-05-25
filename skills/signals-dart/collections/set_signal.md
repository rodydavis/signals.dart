# `SetSignal<T>` (Reactive Sets)

`SetSignal<T>` provides a reactive wrapper around standard Dart sets, ensuring that duplicate entries are ignored while unique additions trigger notifications.

---

## 1. Creation

```dart
final uniqueIds = setSignal(
  {1, 2, 3},
  options: SetSignalOptions(
    name: 'unique_ids',
  ),
);
```

---

## 2. Mutations
```dart
uniqueIds.add(4); // Triggers update
uniqueIds.add(1); // Set already contains 1, NO update is triggered!
```
