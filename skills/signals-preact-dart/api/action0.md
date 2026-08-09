# function `action0`

Wraps a 0-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

### Example Usage

```dart
final increment = action0(() {
  count.value++;
  clicks.value++;
});
```

---

## Signature

```dart
R Function() action0(R Function() fn)
```

