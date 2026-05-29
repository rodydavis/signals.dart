# function `action4`

Wraps a 4-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

### Example Usage

```dart
final updateUserData = action4((String name, int age, double score, bool active) {
  userName.value = name;
  userAge.value = age;
  userScore.value = score;
  userActive.value = active;
});
```

---

## Signature

```dart
R Function(A, B, C, D) action4(R Function(A, B, C, D) fn)
```

