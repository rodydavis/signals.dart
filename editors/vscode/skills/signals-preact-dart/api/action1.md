# function `action1`

Wraps a 1-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

### Example Usage

```dart
final setName = action1((String newName) {
  name.value = newName;
  updatedAt.value = DateTime.now();
});
```

---

## Signature

```dart
R Function(A) action1(R Function(A) fn)
```

