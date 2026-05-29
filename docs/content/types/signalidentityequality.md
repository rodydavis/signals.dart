---
title: "Type: SignalIdentityEquality"
description: "API reference and details for SignalIdentityEquality from signals.dart."
---

# SignalIdentityEquality

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Class: SignalIdentityEquality

Identity equality check (identical(a, b))

Matches two objects only if they point to the exact same instance in memory.

### Example Usage

```dart
final listA = [1, 2];
final listB = [1, 2];
final equality = SignalEquality.identity<List<int>>();
print(equality.equals(listA, listB)); // false
print(equality.equals(listA, listA)); // true
```

### Members of SignalIdentityEquality

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalIdentityEquality** | <code>constructor</code> | <code>dart SignalIdentityEquality()</code> | Creates a new [SignalIdentityEquality](/types/signalidentityequality) instance. |
| **equals** | <code>method</code> | <code>dart bool equals(Object? a, Object? b)</code> |  |

## References

The **SignalIdentityEquality** type is referenced and used in the following pages:

* [SignalEquality](/packages/signals_flutter/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [SignalEquality](/packages/signals_core/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [SignalEquality](/packages/signals/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [SignalEquality](/packages/preact_signals/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/utilities)</span>

