# function `action2`

Wraps a 2-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

### Example Usage

```dart
final updateProfile = action2((String newName, int newAge) {
  name.value = newName;
  age.value = newAge;
});
```

---

## Signature

```dart
R Function(A, B) action2(R Function(A, B) fn)
```

