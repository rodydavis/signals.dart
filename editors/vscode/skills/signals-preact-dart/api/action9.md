# function `action9`

Wraps a 9-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

---

## Signature

```dart
R Function(A, B, C, D, E, F, G, H, I) action9(R Function(A, B, C, D, E, F, G, H, I) fn)
```

