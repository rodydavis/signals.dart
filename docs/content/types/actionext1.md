---
title: "Type: ActionExt1"
description: "API reference and details for ActionExt1 from signals.dart."
---

# ActionExt1

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Extension: ActionExt1

```dart
extension ActionExt1 on R Function(A)
```

Extension on a 1-argument function to wrap it in a type-safe action.

Enables calling <code>.action</code> directly on any 1-argument function to wrap it.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final name = signal('Jane');
final clicks = signal(0);

void updateName(String newName) {
  name.value = newName;
  clicks.value++;
}

// Create a batched, untracked action from the function
final setName = updateName.action;

void main() {
  effect(() => print('Name: ${name.value}, Clicks: ${clicks.value}'));
  // Prints: "Name: Jane, Clicks: 0"

  setName('John');
  // Updates both name and clicks inside a batch.
  // Triggers the effect exactly once.
  // Prints: "Name: John, Clicks: 1"
}
```

### Members of ActionExt1

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **action** | <code>method</code> | <code>dart R Function(A) action</code> | Wraps the 1-argument function in a type-safe action. |

## References

The **ActionExt1** type is referenced and used in the following pages:

* [Action](/packages/signals_flutter/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Action](/packages/signals_core/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Action](/packages/signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Action](/packages/preact_signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

