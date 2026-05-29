---
title: "Type: IntSignalExtension"
description: "API reference and details for IntSignalExtension from signals.dart."
---

# IntSignalExtension

<Info>
  <strong>Kind:</strong> <code>extension</code> &nbsp;|&nbsp;
  <strong>Package:</strong> <code>package:signals_core</code>
</Info>

## Extension: IntSignalExtension

```dart
extension IntSignalExtension on ReadonlySignal<int>
```

Helper extensions for [ReadonlySignal<int>](/types/readonlysignal)

### Members of IntSignalExtension

| Member | Type | Signature | Description |
| :--- | :--- | :--- | :--- |
| **&** | <code>method</code> | <code>dart int &(int other)</code> | Bit-wise and operator. |
| **|** | <code>method</code> | <code>dart int |(int other)</code> | Bit-wise or operator. |
| **^** | <code>method</code> | <code>dart int ^(int other)</code> | Bit-wise exclusive-or operator. |
| **~** | <code>method</code> | <code>dart int ~()</code> | The bit-wise negate operator. |
| **<<** | <code>method</code> | <code>dart int <<(int shiftAmount)</code> | Shift the bits of this integer to the left by **shiftAmount**. |
| **>>** | <code>method</code> | <code>dart int >>(int shiftAmount)</code> | Shift the bits of this integer to the right by **shiftAmount**. |
| **>>>** | <code>method</code> | <code>dart int >>>(int shiftAmount)</code> | Bitwise unsigned right shift by **shiftAmount** bits. |
| **modPow** | <code>method</code> | <code>dart int modPow(int exponent, int modulus)</code> | Returns this integer to the power of **exponent** modulo **modulus**. |
| **modInverse** | <code>method</code> | <code>dart int modInverse(int modulus)</code> | Returns the modular multiplicative inverse of this integer |
| **gcd** | <code>method</code> | <code>dart int gcd(int other)</code> | Returns the greatest common divisor of this integer and **other**. |
| **isEven** | <code>method</code> | <code>dart bool isEven</code> | Returns true if and only if this integer is even. |
| **isOdd** | <code>method</code> | <code>dart bool isOdd</code> | Returns true if and only if this integer is odd. |
| **bitLength** | <code>method</code> | <code>dart int bitLength</code> | Returns the minimum number of bits required to store this integer. |
| **toUnsigned** | <code>method</code> | <code>dart int toUnsigned(int width)</code> | Returns the least significant **width** bits of this integer as a |
| **toSigned** | <code>method</code> | <code>dart int toSigned(int width)</code> | Returns the least significant **width** bits of this integer, extending the |
| **-** | <code>method</code> | <code>dart int -()</code> | Return the negative value of this integer. |
| **abs** | <code>method</code> | <code>dart int abs()</code> | Returns the absolute value of this integer. |
| **sign** | <code>method</code> | <code>dart int sign</code> | Returns the sign of this integer. |
| **round** | <code>method</code> | <code>dart int round()</code> | Returns <code>this</code>. |
| **floor** | <code>method</code> | <code>dart int floor()</code> | Returns <code>this</code>. |
| **ceil** | <code>method</code> | <code>dart int ceil()</code> | Returns <code>this</code>. |
| **truncate** | <code>method</code> | <code>dart int truncate()</code> | Returns <code>this</code>. |
| **roundToDouble** | <code>method</code> | <code>dart double roundToDouble()</code> | Returns <code>this.toDouble()</code>. |
| **floorToDouble** | <code>method</code> | <code>dart double floorToDouble()</code> | Returns <code>this.toDouble()</code>. |
| **ceilToDouble** | <code>method</code> | <code>dart double ceilToDouble()</code> | Returns <code>this.toDouble()</code>. |
| **truncateToDouble** | <code>method</code> | <code>dart double truncateToDouble()</code> | Returns <code>this.toDouble()</code>. |
| **toRadixString** | <code>method</code> | <code>dart String toRadixString(int radix)</code> | Converts this **int** to a string representation in the given **radix**. |

## References

The **IntSignalExtension** type is referenced and used in the following pages:

* [Signal](/packages/signals_flutter/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_flutter/core)</span>
* [Signal](/packages/signals_core/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals_core/core)</span>
* [Signal](/packages/signals/core/signal) <span style="opacity: 0.6; font-size: 0.85em;">(signals/core)</span>
* [signals-dart AI Skill](/skills/signals-dart) <span style="opacity: 0.6; font-size: 0.85em;">(skills)</span>

