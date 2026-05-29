# function `action3`

Wraps a 3-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

### Example Usage

```dart
final setCoordinates = action3((double lat, double lng, String label) {
  latitude.value = lat;
  longitude.value = lng;
  locationName.value = label;
});
```

---

## Signature

```dart
R Function(A, B, C) action3(R Function(A, B, C) fn)
```

