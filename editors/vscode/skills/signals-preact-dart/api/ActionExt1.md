# extension `ActionExt1`

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

---

## Members of `ActionExt1`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **action** | `method` | `R Function(A) action` | Wraps the 1-argument function in a type-safe action. |
