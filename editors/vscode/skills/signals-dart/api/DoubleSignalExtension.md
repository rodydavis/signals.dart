# extension `DoubleSignalExtension`

Helper extensions for [ReadonlySignal<double>](/types/readonlysignal), enabling direct reactive arithmetic and rounding operations on double signals.

```dart
import 'package:signals_core/signals_core.dart';

final doubleSignal = 2.5.$;
final rounded = doubleSignal.round(); // 3
final negated = -doubleSignal; // -2.5
```

---

## Members of `DoubleSignalExtension`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **remainder** | `method` | `double remainder(num other)` | Returns the remainder of this value divided by **other**. |
| **+** | `method` | `double +(num other)` | Returns the sum of this value and **other**. |
| **-** | `method` | `double -(num other)` | Returns the difference of this value and **other**. |
| ***** | `method` | `double *(num other)` | Returns the product of this value and **other**. |
| **%** | `method` | `double %(num other)` | Returns the modulo of this value and **other**. |
| **/** | `method` | `double /(num other)` | Returns the division of this value and **other**. |
| **~/** | `method` | `int ~/(num other)` | Returns the truncating division of this value and **other**. |
| **-** | `method` | `double -()` | Returns the negation of this value. |
| **abs** | `method` | `double abs()` | Returns the absolute value of this value. |
| **sign** | `method` | `double sign` | The sign of the double's numerical value.

Returns -1.0 if the value is less than zero,
+1.0 if the value is greater than zero,
and the value itself if it is -0.0, 0.0 or NaN. |
| **round** | `method` | `int round()` | Returns the integer closest to this number.

Rounds away from zero when there is no closest integer:
 <code>(3.5).round() == 4</code> and <code>(-3.5).round() == -4</code>.

Throws an **UnsupportedError** if this number is not finite
(NaN or an infinity).
```dart
print(3.0.round()); // 3
print(3.25.round()); // 3
print(3.5.round()); // 4
print(3.75.round()); // 4
print((-3.5).round()); // -4
``` |
| **floor** | `method` | `int floor()` | Returns the greatest integer no greater than this number.

Rounds the number towards negative infinity.

Throws an **UnsupportedError** if this number is not finite
(NaN or infinity).
```dart
print(1.99999.floor()); // 1
print(2.0.floor()); // 2
print(2.99999.floor()); // 2
print((-1.99999).floor()); // -2
print((-2.0).floor()); // -2
print((-2.00001).floor()); // -3
``` |
| **ceil** | `method` | `int ceil()` | Returns the least integer that is not smaller than this number.

Rounds the number towards infinity.

Throws an **UnsupportedError** if this number is not finite
(NaN or an infinity).
```dart
print(1.99999.ceil()); // 2
print(2.0.ceil()); // 2
print(2.00001.ceil()); // 3
print((-1.99999).ceil()); // -1
print((-2.0).ceil()); // -2
print((-2.00001).ceil()); // -2
``` |
| **truncate** | `method` | `int truncate()` | Returns the integer obtained by discarding any fractional
part of this number.

Rounds the number towards zero.

Throws an **UnsupportedError** if this number is not finite
(NaN or an infinity).
```dart
print(2.00001.truncate()); // 2
print(1.99999.truncate()); // 1
print(0.5.truncate()); // 0
print((-0.5).truncate()); // 0
print((-1.5).truncate()); // -1
print((-2.5).truncate()); // -2
``` |
| **roundToDouble** | `method` | `double roundToDouble()` | Returns the integer double value closest to <code>this</code>.

Rounds away from zero when there is no closest integer:
 <code>(3.5).roundToDouble() == 4</code> and <code>(-3.5).roundToDouble() == -4</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is not
a finite value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>,
and <code>-0.0</code> is therefore considered closer to negative numbers than <code>0.0</code>.
This means that for a value <code>d</code> in the range <code>-0.5 < d < 0.0</code>,
the result is <code>-0.0</code>.
```dart
print(3.0.roundToDouble()); // 3.0
print(3.25.roundToDouble()); // 3.0
print(3.5.roundToDouble()); // 4.0
print(3.75.roundToDouble()); // 4.0
print((-3.5).roundToDouble()); // -4.0
``` |
| **floorToDouble** | `method` | `double floorToDouble()` | Returns the greatest integer double value no greater than <code>this</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is not
a finite value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>.
A number <code>d</code> in the range <code>0.0 < d < 1.0</code> will return <code>0.0</code>.
```dart
print(1.99999.floorToDouble()); // 1.0
print(2.0.floorToDouble()); // 2.0
print(2.99999.floorToDouble()); // 2.0
print((-1.99999).floorToDouble()); // -2.0
print((-2.0).floorToDouble()); // -2.0
print((-2.00001).floorToDouble()); // -3.0
``` |
| **ceilToDouble** | `method` | `double ceilToDouble()` | Returns the least integer double value no smaller than <code>this</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is not
a finite value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>.
A number <code>d</code> in the range <code>-1.0 < d < 0.0</code> will return <code>-0.0</code>.
```dart
print(1.99999.ceilToDouble()); // 2.0
print(2.0.ceilToDouble()); // 2.0
print(2.00001.ceilToDouble()); // 3.0
print((-1.99999).ceilToDouble()); // -1.0
print((-2.0).ceilToDouble()); // -2.0
print((-2.00001).ceilToDouble()); // -2.0
``` |
| **truncateToDouble** | `method` | `double truncateToDouble()` | Returns the integer double value obtained by discarding any fractional
digits from <code>this</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is not
a finite value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>.
A number <code>d</code> in the range <code>-1.0 < d < 0.0</code> will return <code>-0.0</code>, and
in the range <code>0.0 < d < 1.0</code> it will return 0.0.
```dart
print(2.5.truncateToDouble()); // 2.0
print(2.00001.truncateToDouble()); // 2.0
print(1.99999.truncateToDouble()); // 1.0
print(0.5.truncateToDouble()); // 0.0
print((-0.5).truncateToDouble()); // -0.0
print((-1.5).truncateToDouble()); // -1.0
print((-2.5).truncateToDouble()); // -2.0
``` |
