---
title: "Type: action3"
description: "API reference and details for action3 from signals.dart."
---

# action3

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Function: action3

```dart
R Function(A, B, C) action3(R Function(A, B, C) fn)
```

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

## References

The **action3** type is referenced and used in the following pages:

* [Action](/packages/signals_flutter/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Action](/packages/signals_core/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Action](/packages/signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Action](/packages/preact_signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

