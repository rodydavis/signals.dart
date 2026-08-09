---
title: "Type: SignalStandardEquality"
description: "API reference and details for SignalStandardEquality from signals.dart."
---

# SignalStandardEquality

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Class: SignalStandardEquality

Standard equality check (a == b)

Matches two objects using the standard Dart operator <code>==</code>.

### Example Usage

```dart
final equality = SignalEquality.standard<int>();
print(equality.equals(5, 5)); // true
```

### Members of SignalStandardEquality

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalStandardEquality** | <code>constructor</code> | <code>dart SignalStandardEquality()</code> | Creates a new [SignalStandardEquality](/types/signalstandardequality) instance. |
| **equals** | <code>method</code> | <code>dart bool equals(Object? a, Object? b)</code> |  |

## References

The **SignalStandardEquality** type is referenced and used in the following pages:

* [SignalEquality](/packages/signals_flutter/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [SignalEquality](/packages/signals_core/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [SignalEquality](/packages/signals/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [SignalEquality](/packages/preact_signals/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/utilities)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

