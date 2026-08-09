# extension `NumSignalExtension`

Helper extensions for [ReadonlySignal<num>](/types/readonlysignal), providing convenient reactive math and comparison operations without needing to manually unwrap <code>.value</code>.

```dart
import 'package:signals_core/signals_core.dart';

final a = 5.0.$;
final sum = a + 3; // 8.0 (evaluates reactively)
final isGreater = a > 4; // true
```

---

## Members of `NumSignalExtension`

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **+** | `method` | `num +(num other)` | Adds **other** to this number.

The result is an **int**, as described by [int.+],
if both this number and **other** is an integer,
otherwise the result is a **double**. |
| **-** | `method` | `num -(num other)` | Subtracts **other** from this number.

The result is an **int**, as described by **int.-**,
if both this number and **other** is an integer,
otherwise the result is a **double**. |
| ***** | `method` | `num *(num other)` | Multiplies this number by **other**.

The result is an **int**, as described by [int.*],
if both this number and **other** are integers,
otherwise the result is a **double**. |
| **%** | `method` | `num %(num other)` | Euclidean modulo of this number by **other**.

Returns the remainder of the Euclidean division.
The Euclidean division of two integers <code>a</code> and <code>b</code>
yields two integers <code>q</code> and <code>r</code> such that
<code>a == b * q + r</code> and <code>0 <= r < b.abs()</code>.

The Euclidean division is only defined for integers, but can be easily
extended to work with doubles. In that case, <code>q</code> is still an integer,
but <code>r</code> may have a non-integer value that still satisfies <code>0 <= r < |b|</code>.

The sign of the returned value <code>r</code> is always positive.

See **remainder** for the remainder of the truncating division.

The result is an **int**, as described by [int.%],
if both this number and **other** are integers,
otherwise the result is a **double**.

Example:
```dart
print(5 % 3); // 2
print(-5 % 3); // 1
print(5 % -3); // 2
print(-5 % -3); // 1
``` |
| **/** | `method` | `double /(num other)` | Divides this number by **other**. |
| **~/** | `method` | `int ~/(num other)` | Truncating division operator.

Performs truncating division of this number by **other**.
Truncating division is division where a fractional result
is converted to an integer by rounding towards zero.

If both operands are **int**s, then **other** must not be zero.
Then <code>a ~/ b</code> corresponds to <code>a.remainder(b)</code>
such that <code>a == (a ~/ b) * b + a.remainder(b)</code>.

If either operand is a **double**, then the other operand is converted
to a double before performing the division and truncation of the result.
Then <code>a ~/ b</code> is equivalent to <code>(a / b).truncate()</code>.
This means that the intermediate result of the double division
must be a finite integer (not an infinity or **double.nan**). |
| **-** | `method` | `num -()` | The negation of this value.

The negation of a number is a number of the same kind
(<code>int</code> or <code>double</code>) representing the negation of the
numbers numerical value (the result of subtracting the
number from zero), if that value *exists*.

Negating a double gives a number with the same magnitude
as the original value (<code>number.abs() == (-number).abs()</code>),
and the opposite sign (<code>-(number.sign) == (-number).sign</code>).

Negating an integer, <code>-number</code>, is equivalent to subtracting
it from zero, <code>0 - number</code>.

(Both properties generally also hold for the other type,
but with a few edge case exceptions). |
| **remainder** | `method` | `num remainder(num other)` | The remainder of the truncating division of <code>this</code> by **other**.

The result <code>r</code> of this operation satisfies:
<code>this == (this ~/ other) * other + r</code>.
As a consequence, the remainder <code>r</code> has the same sign as the dividend
<code>this</code>.

The result is an **int**, as described by **int.remainder**,
if both this number and **other** are integers,
otherwise the result is a **double**.

Example:
```dart
print(5.remainder(3)); // 2
print(-5.remainder(3)); // -2
print(5.remainder(-3)); // 2
print(-5.remainder(-3)); // -2
``` |
| **<** | `method` | `bool <(num other)` | Whether this number is numerically smaller than **other**.

Returns <code>true</code> if this number is smaller than **other**.
Returns <code>false</code> if this number is greater than or equal to **other**
or if either value is a NaN value like **double.nan**. |
| **<=** | `method` | `bool <=(num other)` | Whether this number is numerically smaller than or equal to **other**.

Returns <code>true</code> if this number is smaller than or equal to **other**.
Returns <code>false</code> if this number is greater than **other**
or if either value is a NaN value like **double.nan**. |
| **>** | `method` | `bool >(num other)` | Whether this number is numerically greater than **other**.

Returns <code>true</code> if this number is greater than **other**.
Returns <code>false</code> if this number is smaller than or equal to **other**
or if either value is a NaN value like **double.nan**. |
| **>=** | `method` | `bool >=(num other)` | Whether this number is numerically greater than or equal to **other**.

Returns <code>true</code> if this number is greater than or equal to **other**.
Returns <code>false</code> if this number is smaller than **other**
or if either value is a NaN value like **double.nan**. |
| **isNaN** | `method` | `bool isNaN` | Whether this number is a Not-a-Number value.

Is <code>true</code> if this number is the **double.nan** value
or any other of the possible **double** NaN values.
Is <code>false</code> if this number is an integer,
a finite double or an infinite double (**double.infinity**
or **double.negativeInfinity**).

All numbers satisfy exactly one of **isInfinite**, **isFinite**
and <code>isNaN</code>. |
| **isNegative** | `method` | `bool isNegative` | Whether this number is negative.

A number is negative if it's smaller than zero,
or if it is the double <code>-0.0</code>.
This precludes a NaN value like **double.nan** from being negative. |
| **isInfinite** | `method` | `bool isInfinite` | Whether this number is positive infinity or negative infinity.

Only satisfied by **double.infinity** and **double.negativeInfinity**.

All numbers satisfy exactly one of <code>isInfinite</code>, **isFinite**
and **isNaN**. |
| **isFinite** | `method` | `bool isFinite` | Whether this number is finite.

The only non-finite numbers are NaN values, positive infinity, and
negative infinity. All integers are finite.

All numbers satisfy exactly one of **isInfinite**, <code>isFinite</code>
and **isNaN**. |
| **abs** | `method` | `num abs()` | The absolute value of this number.

The absolute value is the value itself, if the value is non-negative,
and <code>-value</code> if the value is negative.

Integer overflow may cause the result of <code>-value</code> to stay negative.

```dart
print((2).abs()); // 2
print((-2.5).abs()); // 2.5
``` |
| **sign** | `method` | `num sign` | Negative one, zero or positive one depending on the sign and
numerical value of this number.

The value minus one if this number is less than zero,
plus one if this number is greater than zero,
and zero if this number is equal to zero.

Returns NaN if this number is a **double** NaN value.

Returns a number of the same type as this number.
For doubles, <code>(-0.0).sign</code> is <code>-0.0</code>.

The result satisfies:
```dart
n == n.sign * n.abs()
```
for all numbers <code>n</code> (except NaN, because NaN isn't <code>==</code> to itself). |
| **round** | `method` | `int round()` | The integer closest to this number.

Rounds away from zero when there is no closest integer:
 <code>(3.5).round() == 4</code> and <code>(-3.5).round() == -4</code>.

The number must be finite (see **isFinite**).

If the value is greater than the highest representable positive integer,
the result is that highest positive integer.
If the value is smaller than the highest representable negative integer,
the result is that highest negative integer. |
| **floor** | `method` | `int floor()` | The greatest integer no greater than this number.

Rounds fractional values towards negative infinity.

The number must be finite (see **isFinite**).

If the value is greater than the highest representable positive integer,
the result is that highest positive integer.
If the value is smaller than the highest representable negative integer,
the result is that highest negative integer. |
| **ceil** | `method` | `int ceil()` | The least integer no smaller than <code>this</code>.

Rounds fractional values towards positive infinity.

The number must be finite (see **isFinite**).

If the value is greater than the highest representable positive integer,
the result is that highest positive integer.
If the value is smaller than the highest representable negative integer,
the result is that highest negative integer. |
| **truncate** | `method` | `int truncate()` | The integer obtained by discarding any fractional digits from <code>this</code>.

Rounds fractional values towards zero.

The number must be finite (see **isFinite**).

If the value is greater than the highest representable positive integer,
the result is that highest positive integer.
If the value is smaller than the highest representable negative integer,
the result is that highest negative integer. |
| **roundToDouble** | `method` | `double roundToDouble()` | The double integer value closest to this value.

Rounds away from zero when there is no closest integer:
 <code>(3.5).roundToDouble() == 4</code> and <code>(-3.5).roundToDouble() == -4</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is a
non-finite double value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>,
and <code>-0.0</code> is therefore considered closer to negative numbers than <code>0.0</code>.
This means that for a value <code>d</code> in the range <code>-0.5 < d < 0.0</code>,
the result is <code>-0.0</code>. |
| **floorToDouble** | `method` | `double floorToDouble()` | Returns the greatest double integer value no greater than <code>this</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is a
non-finite double value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>.
A number <code>d</code> in the range <code>0.0 < d < 1.0</code> will return <code>0.0</code>. |
| **ceilToDouble** | `method` | `double ceilToDouble()` | Returns the least double integer value no smaller than <code>this</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is a
non-finite double value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>.
A number <code>d</code> in the range <code>-1.0 < d < 0.0</code> will return <code>-0.0</code>. |
| **truncateToDouble** | `method` | `double truncateToDouble()` | Returns the double integer value obtained by discarding any fractional
digits from the double value of <code>this</code>.

If this is already an integer valued double, including <code>-0.0</code>, or it is a
non-finite double value, the value is returned unmodified.

For the purpose of rounding, <code>-0.0</code> is considered to be below <code>0.0</code>.
A number <code>d</code> in the range <code>-1.0 < d < 0.0</code> will return <code>-0.0</code>, and
in the range <code>0.0 < d < 1.0</code> it will return 0.0. |
| **clamp** | `method` | `num clamp(num lowerLimit, num upperLimit)` | Returns this **num** clamped to be in the range **lowerLimit**-**upperLimit**.

The comparison is done using **compareTo** and therefore takes <code>-0.0</code> into
account. This also implies that **double.nan** is treated as the maximal
double value.

The arguments **lowerLimit** and **upperLimit** must form a valid range where
<code>lowerLimit.compareTo(upperLimit) <= 0</code>.

Example:
```dart
var result = 10.5.clamp(5, 10.0); // 10.0
result = 0.75.clamp(5, 10.0); // 5
result = (-10).clamp(-5, 5.0); // -5
result = (-0.0).clamp(-5, 5.0); // -0.0
``` |
| **toInt** | `method` | `int toInt()` | Truncates this **num** to an integer and returns the result as an **int**.

Equivalent to **truncate**. |
| **toDouble** | `method` | `double toDouble()` | This number as a **double**.

If an integer number is not precisely representable as a **double**,
an approximation is returned. |
| **toStringAsFixed** | `method` | `String toStringAsFixed(int fractionDigits)` | A decimal-point string-representation of this number.

Converts this number to a **double**
before computing the string representation,
as by **toDouble**.

If the absolute value of <code>this</code> is greater than or equal to <code>10^21</code>, then
this methods returns an exponential representation computed by
<code>this.toStringAsExponential()</code>. Otherwise the result
is the closest string representation with exactly **fractionDigits** digits
after the decimal point. If **fractionDigits** equals 0, then the decimal
point is omitted.

The parameter **fractionDigits** must be an integer satisfying:
<code>0 <= fractionDigits <= 20</code>.

Examples:
```dart
1.toStringAsFixed(3);  // 1.000
(4321.12345678).toStringAsFixed(3);  // 4321.123
(4321.12345678).toStringAsFixed(5);  // 4321.12346
123456789012345.toStringAsFixed(3);  // 123456789012345.000
10000000000000000.toStringAsFixed(4); // 10000000000000000.0000
5.25.toStringAsFixed(0); // 5
``` |
| **toStringAsExponential** | `method` | `String toStringAsExponential([int? fractionDigits])` | An exponential string-representation of this number.

Converts this number to a **double**
before computing the string representation.

If **fractionDigits** is given, then it must be an integer satisfying:
<code>0 <= fractionDigits <= 20</code>. In this case the string contains exactly
**fractionDigits** after the decimal point. Otherwise, without the parameter,
the returned string uses the shortest number of digits that accurately
represent this number.

If **fractionDigits** equals 0, then the decimal point is omitted.
Examples:
```dart
1.toStringAsExponential();       // 1e+0
1.toStringAsExponential(3);      // 1.000e+0
123456.toStringAsExponential();  // 1.23456e+5
123456.toStringAsExponential(3); // 1.235e+5
123.toStringAsExponential(0);    // 1e+2
``` |
| **toStringAsPrecision** | `method` | `String toStringAsPrecision(int precision)` | A string representation with **precision** significant digits.

Converts this number to a **double**
and returns a string representation of that value
with exactly **precision** significant digits.

The parameter **precision** must be an integer satisfying:
<code>1 <= precision <= 21</code>.

Examples:
```dart
1.toStringAsPrecision(2);       // 1.0
1e15.toStringAsPrecision(3);    // 1.00e+15
1234567.toStringAsPrecision(3); // 1.23e+6
1234567.toStringAsPrecision(9); // 1234567.00
12345678901234567890.toStringAsPrecision(20); // 12345678901234567168
12345678901234567890.toStringAsPrecision(14); // 1.2345678901235e+19
0.00000012345.toStringAsPrecision(15); // 1.23450000000000e-7
0.0000012345.toStringAsPrecision(15);  // 0.00000123450000000000
``` |
