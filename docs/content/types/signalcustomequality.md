---
title: "Type: SignalCustomEquality"
description: "API reference and details for SignalCustomEquality from signals.dart."
---

# SignalCustomEquality

<Info>
  <strong>Kind:</strong> <code>class</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:preact_signals</code>
</Info>

## Class: SignalCustomEquality

Custom equality check using a custom function

Uses a custom comparison function to determine if two values of type **T** are equal.

### Example Usage

```dart
final equality = SignalEquality.custom((User a, User b) => a.id == b.id);
```

### Members of SignalCustomEquality

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **SignalCustomEquality** | <code>constructor</code> | <code>dart SignalCustomEquality(this._fn)</code> | Creates a new [SignalCustomEquality](/types/signalcustomequality) instance. |
| **equals** | <code>method</code> | <code>dart bool equals(Object? a, Object? b)</code> |  |

## References

The **SignalCustomEquality** type is referenced and used in the following pages:

* [SignalEquality](/packages/signals_flutter/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/utilities)</span>
* [SignalEquality](/packages/signals_core/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/utilities)</span>
* [SignalEquality](/packages/signals/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(signals/utilities)</span>
* [SignalEquality](/packages/preact_signals/utilities/equality) <span style="opacity: 0.6; font-size: 0.85em;">(preact_signals/utilities)</span>
* [signals-preact-dart AI Skill](/skills/signals-preact-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

