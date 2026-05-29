---
title: "Type: NumSignalExtension"
description: "API reference and details for NumSignalExtension from signals.dart."
---

# NumSignalExtension

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: NumSignalExtension

```dart
extension NumSignalExtension on ReadonlySignal<num>
```

Helper extensions for [ReadonlySignal<num>](/types/readonlysignal), providing convenient reactive math and comparison operations without needing to manually unwrap <code>.value</code>.

```dart
import 'package:signals_core/signals_core.dart';

final a = 5.0.$;
final sum = a + 3; // 8.0 (evaluates reactively)
final isGreater = a > 4; // true
```

### Members of NumSignalExtension

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **+** | <code>method</code> | <code>dart num +(num other)</code> | Adds **other** to this number. |
| **-** | <code>method</code> | <code>dart num -(num other)</code> | Subtracts **other** from this number. |
| ***** | <code>method</code> | <code>dart num *(num other)</code> | Multiplies this number by **other**. |
| **%** | <code>method</code> | <code>dart num %(num other)</code> | Euclidean modulo of this number by **other**. |
| **/** | <code>method</code> | <code>dart double /(num other)</code> | Divides this number by **other**. |
| **~/** | <code>method</code> | <code>dart int ~/(num other)</code> | Truncating division operator. |
| **-** | <code>method</code> | <code>dart num -()</code> | The negation of this value. |
| **remainder** | <code>method</code> | <code>dart num remainder(num other)</code> | The remainder of the truncating division of <code>this</code> by **other**. |
| **<** | <code>method</code> | <code>dart bool <(num other)</code> | Whether this number is numerically smaller than **other**. |
| **<=** | <code>method</code> | <code>dart bool <=(num other)</code> | Whether this number is numerically smaller than or equal to **other**. |
| **>** | <code>method</code> | <code>dart bool >(num other)</code> | Whether this number is numerically greater than **other**. |
| **>=** | <code>method</code> | <code>dart bool >=(num other)</code> | Whether this number is numerically greater than or equal to **other**. |
| **isNaN** | <code>method</code> | <code>dart bool isNaN</code> | Whether this number is a Not-a-Number value. |
| **isNegative** | <code>method</code> | <code>dart bool isNegative</code> | Whether this number is negative. |
| **isInfinite** | <code>method</code> | <code>dart bool isInfinite</code> | Whether this number is positive infinity or negative infinity. |
| **isFinite** | <code>method</code> | <code>dart bool isFinite</code> | Whether this number is finite. |
| **abs** | <code>method</code> | <code>dart num abs()</code> | The absolute value of this number. |
| **sign** | <code>method</code> | <code>dart num sign</code> | Negative one, zero or positive one depending on the sign and |
| **round** | <code>method</code> | <code>dart int round()</code> | The integer closest to this number. |
| **floor** | <code>method</code> | <code>dart int floor()</code> | The greatest integer no greater than this number. |
| **ceil** | <code>method</code> | <code>dart int ceil()</code> | The least integer no smaller than <code>this</code>. |
| **truncate** | <code>method</code> | <code>dart int truncate()</code> | The integer obtained by discarding any fractional digits from <code>this</code>. |
| **roundToDouble** | <code>method</code> | <code>dart double roundToDouble()</code> | The double integer value closest to this value. |
| **floorToDouble** | <code>method</code> | <code>dart double floorToDouble()</code> | Returns the greatest double integer value no greater than <code>this</code>. |
| **ceilToDouble** | <code>method</code> | <code>dart double ceilToDouble()</code> | Returns the least double integer value no smaller than <code>this</code>. |
| **truncateToDouble** | <code>method</code> | <code>dart double truncateToDouble()</code> | Returns the double integer value obtained by discarding any fractional |
| **clamp** | <code>method</code> | <code>dart num clamp(num lowerLimit, num upperLimit)</code> | Returns this **num** clamped to be in the range **lowerLimit**-**upperLimit**. |
| **toInt** | <code>method</code> | <code>dart int toInt()</code> | Truncates this **num** to an integer and returns the result as an **int**. |
| **toDouble** | <code>method</code> | <code>dart double toDouble()</code> | This number as a **double**. |
| **toStringAsFixed** | <code>method</code> | <code>dart String toStringAsFixed(int fractionDigits)</code> | A decimal-point string-representation of this number. |
| **toStringAsExponential** | <code>method</code> | <code>dart String toStringAsExponential([int? fractionDigits])</code> | An exponential string-representation of this number. |
| **toStringAsPrecision** | <code>method</code> | <code>dart String toStringAsPrecision(int precision)</code> | A string representation with **precision** significant digits. |

## References

The **NumSignalExtension** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

