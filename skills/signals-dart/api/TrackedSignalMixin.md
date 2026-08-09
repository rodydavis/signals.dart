# mixin `TrackedSignalMixin`

A mixin that adds tracking for the initial and previous values to a [Signal](/types/signal).

[TrackedSignalMixin](/types/trackedsignalmixin) stores the <code>initialValue</code> (the value the signal had when it was
created or initialized) and the <code>previousValue</code> (the value of the signal right before
the most recent update).

<Info>
If you are looking for full undo/redo capabilities, use <a href="/types/changestacksignalmixin">ChangeStackSignalMixin</a> instead.
</Info>

### Example Usage

```dart
import 'package:signals/signals.dart';

class MyTrackedSignal extends Signal<int> with TrackedSignalMixin<int> {
  MyTrackedSignal(super.internalValue);
}

void main() {
  final signal = MyTrackedSignal(0);

  print('Initial: ${signal.initialValue}');   // Prints: "Initial: 0"
  print('Previous: ${signal.previousValue}'); // Prints: "Previous: null"

  signal.value = 1;
  print('Initial: ${signal.initialValue}');   // Prints: "Initial: 0"
  print('Previous: ${signal.previousValue}'); // Prints: "Previous: 0"

  signal.value = 2;
  print('Initial: ${signal.initialValue}');   // Prints: "Initial: 0"
  print('Previous: ${signal.previousValue}'); // Prints: "Previous: 1"
}
```

<Warning>
This mixin only works with values that are immutable or are copied/cloned on mutation.
If the value is mutated directly in-place without re-assigning, <code>initialValue</code> and
<code>previousValue</code> will end up pointing to the same modified instance as the current value.
</Warning>

---

## Members of `TrackedSignalMixin`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **initialValue** | `method` | `T initialValue` | The initial value the signal was created with |
| **previousValue** | `method` | `T? previousValue` | Get the previous value (if exists) |
