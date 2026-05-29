# function `action8`

Wraps an 8-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

---

## Signature

```dart
R Function(A, B, C, D, E, F, G, H) action8(R Function(A, B, C, D, E, F, G, H) fn)
```

