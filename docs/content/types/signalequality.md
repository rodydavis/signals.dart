---
title: "Type: SignalEquality"
description: "API reference and details for SignalEquality from signals.dart."
---

# SignalEquality

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Class: SignalEquality

Defines the equality check algorithm used by signals to determine if a new value
actually differs from the current value.

By default, signals use standard Dart operator equality (<code>==</code>). However, you can configure
a signal to use different strategies, such as deep equality check for collections or custom comparator checks.

Strategies:
- **standard**: Default value equality (<code>a == b</code>).
- **identity**: Identity-based comparison (<code>identical(a, b)</code>).
- **deep**: Deep collection comparison for Lists, Maps, and Sets.
- **custom**: User-defined boolean comparison function.

### Example Usage

```dart
import 'package:preact_signals/preact_signals.dart';

void main() {
  // Create a list signal using deep equality check
  final items = signal(
    [1, 2, 3],
    options: SignalOptions(
      equality: SignalEquality.deep(),
    ),
  );

  effect(() {
    print('Items changed: ${items.value}');
  });

  // Reassigning an identical value structure does NOT trigger a rebuild!
  items.value = [1, 2, 3];

  // Triggers rebuild
  items.value = [1, 2, 3, 4];
}
```

### Members of SignalEquality

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalEquality** | <code>constructor</code> | <code>dart SignalEquality()</code> | @nodoc |
| **equals** | <code>method</code> | <code>dart bool equals(Object? a, Object? b)</code> | Check if two values are equal |
| **standard** | <code>method</code> | <code>dart static SignalEquality<T> standard()</code> | Standard equality check (a == b) |
| **identity** | <code>method</code> | <code>dart static SignalEquality<T> identity()</code> | Identity equality check (identical(a, b)) |
| **deep** | <code>method</code> | <code>dart static SignalEquality<T> deep()</code> | Deep equality check |
| **SignalEquality.custom** | <code>constructor</code> | <code>dart SignalEquality.custom(bool Function(T a, T b) fn)</code> | Custom equality check |

## References

The **SignalEquality** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [QueueSignalMixin](/packages/signals_flutter/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [SignalEquality](/packages/signals_flutter/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [signals_flutter](/packages/signals_flutter)
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [QueueSignalMixin](/packages/signals_core/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [SignalEquality](/packages/signals_core/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [signals_core](/packages/signals_core)
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [QueueSignalMixin](/packages/signals/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [SignalEquality](/packages/signals/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [signals](/packages/signals)
* [Signal](/packages/preact_signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/core)</span>
* [SignalEquality](/packages/preact_signals/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/utilities)</span>
* [preact_signals](/packages/preact_signals)

