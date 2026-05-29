# function `action7`

Wraps a 7-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

---

## Signature

```dart
R Function(A, B, C, D, E, F, G) action7(R Function(A, B, C, D, E, F, G) fn)
```

