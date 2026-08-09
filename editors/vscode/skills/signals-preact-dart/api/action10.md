# function `action10`

Wraps a 10-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

---

## Signature

```dart
R Function(A, B, C, D, E, F, G, H, I, J) action10(R Function(A, B, C, D, E, F, G, H, I, J) fn)
```

