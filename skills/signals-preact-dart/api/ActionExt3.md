# extension `ActionExt3`

Extension on a 3-argument function to wrap it in a type-safe action.

Enables calling <code>.action</code> directly on any 3-argument function to wrap it.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final latitude = signal(0.0);
final longitude = signal(0.0);
final locationName = signal('Unknown');

void setCoordinates(double lat, double lng, String label) {
  latitude.value = lat;
  longitude.value = lng;
  locationName.value = label;
}

// Create a batched, untracked action from the function
final setCoords = setCoordinates.action;

void main() {
  effect(() => print('${locationName.value}: (${latitude.value}, ${longitude.value})'));
  // Prints: "Unknown: (0.0, 0.0)"

  setCoords(37.7749, -122.4194, 'San Francisco');
  // Updates latitude, longitude, and locationName inside a batch.
  // Triggers the effect exactly once.
  // Prints: "San Francisco: (37.7749, -122.4194)"
}
```

---

## Members of `ActionExt3`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **action** | `method` | `R Function(A, B, C) action` | Wraps the 3-argument function in a type-safe action. |
