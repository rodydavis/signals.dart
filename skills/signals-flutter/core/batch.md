# `batch` Mutations

`batch` is a performance optimization utility that groups multiple signal mutations together into a single transaction, executing dependent computed updates and effects only once at the end of the batch block.

---

## 1. Usage

```dart
final first = signal('John');
final last = signal('Doe');

effect(() {
  print('Name changed to: ${first.value} ${last.value}');
});

// Mutating inside batch
batch(() {
  first.value = 'Jane'; // No notification yet
  last.value = 'Smith'; // No notification yet
});
// The effect runs exactly ONCE here!
```

---

## 2. Benefits
- **Avoid Flutter Re-render Churn**: Prevents high-frequency intermediate paint steps or widget updates in Flutter.
- **Transactional Consistency**: Ensures that computed values are completely in sync before side-effects fire.
