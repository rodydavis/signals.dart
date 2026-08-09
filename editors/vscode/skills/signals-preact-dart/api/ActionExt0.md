# extension `ActionExt0`

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

---

## Members of `ActionExt0`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **action** | `method` | `R Function() action` | Wraps the 0-argument function in a type-safe action. |
