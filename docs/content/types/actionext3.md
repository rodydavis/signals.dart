---
title: "Type: ActionExt3"
description: "API reference and details for ActionExt3 from signals.dart."
---

# ActionExt3

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Extension: ActionExt3

```dart
extension ActionExt3 on R Function(A, B, C)
```

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

### Members of ActionExt3

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **action** | <code>method</code> | <code>dart R Function(A, B, C) action</code> | Wraps the 3-argument function in a type-safe action. |

## References

The **ActionExt3** type is referenced and used in the following pages:

* [Action](/packages/signals_flutter/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Action](/packages/signals_core/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Action](/packages/signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Action](/packages/preact_signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>

