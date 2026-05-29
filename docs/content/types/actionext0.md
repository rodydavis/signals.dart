---
title: "Type: ActionExt0"
description: "API reference and details for ActionExt0 from signals.dart."
---

# ActionExt0

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Extension: ActionExt0

```dart
extension ActionExt0 on R Function()
```

Extension on a 0-argument function to wrap it in a type-safe action.

Enables calling <code>.action</code> directly on any 0-argument function to wrap it.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final count = signal(0);
final clicks = signal(0);

void incrementCount() {
  count.value++;
  clicks.value++;
}

// Create a batched, untracked action from the function
final increment = incrementCount.action;

void main() {
  effect(() => print('Count: ${count.value}, Clicks: ${clicks.value}'));
  // Prints: "Count: 0, Clicks: 0"

  increment();
  // Updates both count and clicks inside a batch.
  // Triggers the effect exactly once.
  // Prints: "Count: 1, Clicks: 1"
}
```

### Members of ActionExt0

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **action** | <code>method</code> | <code>dart R Function() action</code> | Wraps the 0-argument function in a type-safe action. |

## References

The **ActionExt0** type is referenced and used in the following pages:

* [Action](/packages/signals_flutter/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Action](/packages/signals_core/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Action](/packages/signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Action](/packages/preact_signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>

