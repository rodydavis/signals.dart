---
title: "Type: SignalDeepEquality"
description: "API reference and details for SignalDeepEquality from signals.dart."
---

# SignalDeepEquality

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Class: SignalDeepEquality

Deep equality check for collections

Recursively compares Lists, Maps, and Sets to see if their nested elements are equal.

### Example Usage

```dart
final equality = SignalEquality.deep();
print(equality.equals([1, [2, 3]], [1, [2, 3]])); // true
```

### Members of SignalDeepEquality

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalDeepEquality** | <code>constructor</code> | <code>dart SignalDeepEquality()</code> | Creates a new [SignalDeepEquality](/types/signaldeepequality) instance. |
| **equals** | <code>method</code> | <code>dart bool equals(Object? a, Object? b)</code> |  |

## References

The **SignalDeepEquality** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [QueueSignalMixin](/packages/signals_flutter/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/mixins)</span>
* [SignalEquality](/packages/signals_flutter/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [QueueSignalMixin](/packages/signals_core/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/mixins)</span>
* [SignalEquality](/packages/signals_core/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [QueueSignalMixin](/packages/signals/mixins/queue) <span style="opacity: 0.6; font-size: 0.85em;">(signals/mixins)</span>
* [SignalEquality](/packages/signals/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [SignalEquality](/packages/preact_signals/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/utilities)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

