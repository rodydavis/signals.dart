# function `action6`

Wraps a 6-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

---

## Signature

```dart
R Function(A, B, C, D, E, F) action6(R Function(A, B, C, D, E, F) fn)
```

