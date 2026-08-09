---
title: "Type: TrackedSignalMixin"
description: "API reference and details for TrackedSignalMixin from signals.dart."
---

# TrackedSignalMixin

<Info>
  <strong>Kind:</strong> <code>mixin</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Mixin: TrackedSignalMixin

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

### Members of TrackedSignalMixin

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **initialValue** | <code>method</code> | <code>dart T initialValue</code> | The initial value the signal was created with |
| **previousValue** | <code>method</code> | <code>dart T? previousValue</code> | Get the previous value (if exists) |

## References

The **TrackedSignalMixin** type is referenced and used in the following pages:

* [TrackedSignalMixin](/packages/signals_flutter/mixins/tracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [ChangeStackSignalMixin](/packages/signals_flutter/mixins/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [ChangeStackSignal](/packages/signals_flutter/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/value)</span>
* [signals_flutter](/packages/signals_flutter)
* [TrackedSignalMixin](/packages/signals_core/mixins/tracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [ChangeStackSignalMixin](/packages/signals_core/mixins/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [ChangeStackSignal](/packages/signals_core/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/value)</span>
* [signals_core](/packages/signals_core)
* [TrackedSignalMixin](/packages/signals/mixins/tracked) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [ChangeStackSignalMixin](/packages/signals/mixins/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [ChangeStackSignal](/packages/signals/value/change-stack) <span style="opacity: 0.6; font-size: 0.85em;">(signals/value)</span>
* [signals](/packages/signals)
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

