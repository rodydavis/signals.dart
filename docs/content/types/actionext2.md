---
title: "Type: ActionExt2"
description: "API reference and details for ActionExt2 from signals.dart."
---

# ActionExt2

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Extension: ActionExt2

```dart
extension ActionExt2 on R Function(A, B)
```

Extension on a 2-argument function to wrap it in a type-safe action.

Enables calling <code>.action</code> directly on any 2-argument function to wrap it.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

final name = signal('Jane');
final age = signal(25);

void updateProfile(String newName, int newAge) {
  name.value = newName;
  age.value = newAge;
}

// Create a batched, untracked action from the function
final setProfile = updateProfile.action;

void main() {
  effect(() => print('Name: ${name.value}, Age: ${age.value}'));
  // Prints: "Name: Jane, Age: 25"

  setProfile('John', 30);
  // Updates both name and age inside a batch.
  // Triggers the effect exactly once.
  // Prints: "Name: John, Age: 30"
}
```

### Members of ActionExt2

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **action** | <code>method</code> | <code>dart R Function(A, B) action</code> | Wraps the 2-argument function in a type-safe action. |

## References

The **ActionExt2** type is referenced and used in the following pages:

* [Action](/packages/signals_flutter/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Action](/packages/signals_core/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Action](/packages/signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [Action](/packages/preact_signals/core/action) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>

