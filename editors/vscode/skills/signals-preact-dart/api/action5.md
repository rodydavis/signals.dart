# function `action5`

Wraps a 5-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

### Example Usage

```dart
final setConfig = action5((int w, int h, String title, bool dark, double opacity) {
  width.value = w;
  height.value = h;
  appTitle.value = title;
  themeDark.value = dark;
  bgOpacity.value = opacity;
});
```

---

## Signature

```dart
R Function(A, B, C, D, E) action5(R Function(A, B, C, D, E) fn)
```

