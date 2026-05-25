# `TrackedSignal<T>` (Undo/Redo State)

`TrackedSignal<T>` tracks mutations and records an internal history list, enabling native out-of-the-box undo and redo mechanics.

---

## 1. Creation

```dart
final editor = trackedSignal(
  'initial text',
  options: TrackedSignalOptions(
    name: 'editor_history',
    maxHistory: 10,
  ),
);
```

---

## 2. Navigation
```dart
editor.value = 'first edit';
editor.value = 'second edit';

editor.undo(); // Returns to 'first edit'
editor.redo(); // Restores 'second edit'
```
- Custom limits on maximum history size can be provided using the `maxHistory` options parameter.
