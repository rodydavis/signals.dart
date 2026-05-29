---
title: "Type: DoubleSignalExtension"
description: "API reference and details for DoubleSignalExtension from signals.dart."
---

# DoubleSignalExtension

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: DoubleSignalExtension

```dart
extension DoubleSignalExtension on ReadonlySignal<double>
```

Helper extensions for [ReadonlySignal<double>](/types/readonlysignal), enabling direct reactive arithmetic and rounding operations on double signals.

```dart
import 'package:signals_core/signals_core.dart';

final doubleSignal = 2.5.$;
final rounded = doubleSignal.round(); // 3
final negated = -doubleSignal; // -2.5
```

### Members of DoubleSignalExtension

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **remainder** | <code>method</code> | <code>dart double remainder(num other)</code> | Returns the remainder of this value divided by **other**. |
| **+** | <code>method</code> | <code>dart double +(num other)</code> | Returns the sum of this value and **other**. |
| **-** | <code>method</code> | <code>dart double -(num other)</code> | Returns the difference of this value and **other**. |
| ***** | <code>method</code> | <code>dart double *(num other)</code> | Returns the product of this value and **other**. |
| **%** | <code>method</code> | <code>dart double %(num other)</code> | Returns the modulo of this value and **other**. |
| **/** | <code>method</code> | <code>dart double /(num other)</code> | Returns the division of this value and **other**. |
| **~/** | <code>method</code> | <code>dart int ~/(num other)</code> | Returns the truncating division of this value and **other**. |
| **-** | <code>method</code> | <code>dart double -()</code> | Returns the negation of this value. |
| **abs** | <code>method</code> | <code>dart double abs()</code> | Returns the absolute value of this value. |
| **sign** | <code>method</code> | <code>dart double sign</code> | The sign of the double's numerical value. |
| **round** | <code>method</code> | <code>dart int round()</code> | Returns the integer closest to this number. |
| **floor** | <code>method</code> | <code>dart int floor()</code> | Returns the greatest integer no greater than this number. |
| **ceil** | <code>method</code> | <code>dart int ceil()</code> | Returns the least integer that is not smaller than this number. |
| **truncate** | <code>method</code> | <code>dart int truncate()</code> | Returns the integer obtained by discarding any fractional |
| **roundToDouble** | <code>method</code> | <code>dart double roundToDouble()</code> | Returns the integer double value closest to <code>this</code>. |
| **floorToDouble** | <code>method</code> | <code>dart double floorToDouble()</code> | Returns the greatest integer double value no greater than <code>this</code>. |
| **ceilToDouble** | <code>method</code> | <code>dart double ceilToDouble()</code> | Returns the least integer double value no smaller than <code>this</code>. |
| **truncateToDouble** | <code>method</code> | <code>dart double truncateToDouble()</code> | Returns the integer double value obtained by discarding any fractional |

## References

The **DoubleSignalExtension** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>

