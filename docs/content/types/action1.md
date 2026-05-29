---
title: "Type: action1"
description: "API reference and details for action1 from signals.dart."
---

# action1

<Info>
  <strong>Kind:</strong> <code>function</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Function: action1

```dart
R Function(A) action1(R Function(A) fn)
```

Wraps a 1-argument callback function in a type-safe action.

Executes **fn** inside a transaction-safe [batch](/types/batch) and [untracked](/types/untracked) block.

### Example Usage

```dart
final setName = action1((String newName) {
  name.value = newName;
  updatedAt.value = DateTime.now();
});
```

## References

The **action1** type is referenced and used in the following pages:

* [Action](/packages/signals_flutter/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Action](/packages/signals_core/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Action](/packages/signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Action](/packages/preact_signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>

