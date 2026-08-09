---
title: "Type: action2"
description: "API reference and details for action2 from signals.dart."
---

# action2

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Function: action2

```dart
R Function(A, B) action2(R Function(A, B) fn)
```

Wraps a 2-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

### Example Usage

```dart
final updateProfile = action2((String newName, int newAge) {
  name.value = newName;
  age.value = newAge;
});
```

## References

The **action2** type is referenced and used in the following pages:

* [Action](/packages/signals_flutter/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Action](/packages/signals_core/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Action](/packages/signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Action](/packages/preact_signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

