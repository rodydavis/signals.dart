# extension `ActionExt2`

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

---

## Members of `ActionExt2`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **action** | `method` | `R Function(A, B) action` | Wraps the 2-argument function in a type-safe action. |
