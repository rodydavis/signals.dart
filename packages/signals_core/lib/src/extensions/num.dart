import '../core/signals.dart';

/// Helper extensions for [ReadonlySignal<num>]
extension NumSignalExtension on ReadonlySignal<num> {
  /// Adds [other] to this number.
  ///
  /// The result is an [int], as described by [int.+],
  /// if both this number and [other] is an integer,
  /// otherwise the result is a [double].
  num operator +(num other) => value + other;

  /// Subtracts [other] from this number.
  ///
  /// The result is an [int], as described by [int.-],
  /// if both this number and [other] is an integer,
  /// otherwise the result is a [double].
  num operator -(num other) => value - other;

  /// Multiplies this number by [other].
  ///
  /// The result is an [int], as described by [int.*],
  /// if both this number and [other] are integers,
  /// otherwise the result is a [double].
  num operator *(num other) => value * other;

  /// Euclidean modulo of this number by [other].
  ///
  /// Returns the remainder of the Euclidean division.
  /// The Euclidean division of two integers `a` and `b`
  /// yields two integers `q` and `r` such that
  /// `a == b * q + r` and `0 <= r < b.abs()`.
  ///
  /// The Euclidean division is only defined for integers, but can be easily
  /// extended to work with doubles. In that case, `q` is still an integer,
  /// but `r` may have a non-integer value that still satisfies `0 <= r < |b|`.
  ///
  /// The sign of the returned value `r` is always positive.
  ///
  /// See [remainder] for the remainder of the truncating division.
  ///
  /// The result is an [int], as described by [int.%],
  /// if both this number and [other] are integers,
  /// otherwise the result is a [double].
  ///
  /// Example:
  /// ```dart
  /// print(5 % 3); // 2
  /// print(-5 % 3); // 1
  /// print(5 % -3); // 2
  /// print(-5 % -3); // 1
  /// ```
  num operator %(num other) => value % other;

  /// Divides this number by [other].
  double operator /(num other) => value / other;

  /// Truncating division operator.
  ///
  /// Performs truncating division of this number by [other].
  /// Truncating division is division where a fractional result
  /// is converted to an integer by rounding towards zero.
  ///
  /// If both operands are [int]s, then [other] must not be zero.
  /// Then `a ~/ b` corresponds to `a.remainder(b)`
  /// such that `a == (a ~/ b) * b + a.remainder(b)`.
  ///
  /// If either operand is a [double], then the other operand is converted
  /// to a double before performing the division and truncation of the result.
  /// Then `a ~/ b` is equivalent to `(a / b).truncate()`.
  /// This means that the intermediate result of the double division
  /// must be a finite integer (not an infinity or [double.nan]).
  int operator ~/(num other) => value ~/ other;

  /// The negation of this value.
  ///
  /// The negation of a number is a number of the same kind
  /// (`int` or `double`) representing the negation of the
  /// numbers numerical value (the result of subtracting the
  /// number from zero), if that value *exists*.
  ///
  /// Negating a double gives a number with the same magnitude
  /// as the original value (`number.abs() == (-number).abs()`),
  /// and the opposite sign (`-(number.sign) == (-number).sign`).
  ///
  /// Negating an integer, `-number`, is equivalent to subtracting
  /// it from zero, `0 - number`.
  ///
  /// (Both properties generally also hold for the other type,
  /// but with a few edge case exceptions).
  num operator -() => -value;

  /// The remainder of the truncating division of `this` by [other].
  ///
  /// The result `r` of this operation satisfies:
  /// `this == (this ~/ other) * other + r`.
  /// As a consequence, the remainder `r` has the same sign as the dividend
  /// `this`.
  ///
  /// The result is an [int], as described by [int.remainder],
  /// if both this number and [other] are integers,
  /// otherwise the result is a [double].
  ///
  /// Example:
  /// ```dart
  /// print(5.remainder(3)); // 2
  /// print(-5.remainder(3)); // -2
  /// print(5.remainder(-3)); // 2
  /// print(-5.remainder(-3)); // -2
  /// ```
  num remainder(num other) => value.remainder(other);

  /// Whether this number is numerically smaller than [other].
  ///
  /// Returns `true` if this number is smaller than [other].
  /// Returns `false` if this number is greater than or equal to [other]
  /// or if either value is a NaN value like [double.nan].
  bool operator <(num other) => value < other;

  /// Whether this number is numerically smaller than or equal to [other].
  ///
  /// Returns `true` if this number is smaller than or equal to [other].
  /// Returns `false` if this number is greater than [other]
  /// or if either value is a NaN value like [double.nan].
  bool operator <=(num other) => value <= other;

  /// Whether this number is numerically greater than [other].
  ///
  /// Returns `true` if this number is greater than [other].
  /// Returns `false` if this number is smaller than or equal to [other]
  /// or if either value is a NaN value like [double.nan].
  bool operator >(num other) => value > other;

  /// Whether this number is numerically greater than or equal to [other].
  ///
  /// Returns `true` if this number is greater than or equal to [other].
  /// Returns `false` if this number is smaller than [other]
  /// or if either value is a NaN value like [double.nan].
  bool operator >=(num other) => value >= other;

  /// Whether this number is a Not-a-Number value.
  ///
  /// Is `true` if this number is the [double.nan] value
  /// or any other of the possible [double] NaN values.
  /// Is `false` if this number is an integer,
  /// a finite double or an infinite double ([double.infinity]
  /// or [double.negativeInfinity]).
  ///
  /// All numbers satisfy exactly one of [isInfinite], [isFinite]
  /// and `isNaN`.
  bool get isNaN => value.isNaN;

  /// Whether this number is negative.
  ///
  /// A number is negative if it's smaller than zero,
  /// or if it is the double `-0.0`.
  /// This precludes a NaN value like [double.nan] from being negative.
  bool get isNegative => value.isNegative;

  /// Whether this number is positive infinity or negative infinity.
  ///
  /// Only satisfied by [double.infinity] and [double.negativeInfinity].
  ///
  /// All numbers satisfy exactly one of `isInfinite`, [isFinite]
  /// and [isNaN].
  bool get isInfinite => value.isInfinite;

  /// Whether this number is finite.
  ///
  /// The only non-finite numbers are NaN values, positive infinity, and
  /// negative infinity. All integers are finite.
  ///
  /// All numbers satisfy exactly one of [isInfinite], `isFinite`
  /// and [isNaN].
  bool get isFinite => value.isFinite;

  /// The absolute value of this number.
  ///
  /// The absolute value is the value itself, if the value is non-negative,
  /// and `-value` if the value is negative.
  ///
  /// Integer overflow may cause the result of `-value` to stay negative.
  ///
  /// ```dart
  /// print((2).abs()); // 2
  /// print((-2.5).abs()); // 2.5
  /// ```
  num abs() => value.abs();

  /// Negative one, zero or positive one depending on the sign and
  /// numerical value of this number.
  ///
  /// The value minus one if this number is less than zero,
  /// plus one if this number is greater than zero,
  /// and zero if this number is equal to zero.
  ///
  /// Returns NaN if this number is a [double] NaN value.
  ///
  /// Returns a number of the same type as this number.
  /// For doubles, `(-0.0).sign` is `-0.0`.
  ///
  /// The result satisfies:
  /// ```dart
  /// n == n.sign * n.abs()
  /// ```
  /// for all numbers `n` (except NaN, because NaN isn't `==` to itself).
  num get sign => value.sign;

  /// The integer closest to this number.
  ///
  /// Rounds away from zero when there is no closest integer:
  ///  `(3.5).round() == 4` and `(-3.5).round() == -4`.
  ///
  /// The number must be finite (see [isFinite]).
  ///
  /// If the value is greater than the highest representable positive integer,
  /// the result is that highest positive integer.
  /// If the value is smaller than the highest representable negative integer,
  /// the result is that highest negative integer.
  int round() => value.round();

  /// The greatest integer no greater than this number.
  ///
  /// Rounds fractional values towards negative infinity.
  ///
  /// The number must be finite (see [isFinite]).
  ///
  /// If the value is greater than the highest representable positive integer,
  /// the result is that highest positive integer.
  /// If the value is smaller than the highest representable negative integer,
  /// the result is that highest negative integer.
  int floor() => value.floor();

  /// The least integer no smaller than `this`.
  ///
  /// Rounds fractional values towards positive infinity.
  ///
  /// The number must be finite (see [isFinite]).
  ///
  /// If the value is greater than the highest representable positive integer,
  /// the result is that highest positive integer.
  /// If the value is smaller than the highest representable negative integer,
  /// the result is that highest negative integer.
  int ceil() => value.ceil();

  /// The integer obtained by discarding any fractional digits from `this`.
  ///
  /// Rounds fractional values towards zero.
  ///
  /// The number must be finite (see [isFinite]).
  ///
  /// If the value is greater than the highest representable positive integer,
  /// the result is that highest positive integer.
  /// If the value is smaller than the highest representable negative integer,
  /// the result is that highest negative integer.
  int truncate() => value.truncate();

  /// The double integer value closest to this value.
  ///
  /// Rounds away from zero when there is no closest integer:
  ///  `(3.5).roundToDouble() == 4` and `(-3.5).roundToDouble() == -4`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is a
  /// non-finite double value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`,
  /// and `-0.0` is therefore considered closer to negative numbers than `0.0`.
  /// This means that for a value `d` in the range `-0.5 < d < 0.0`,
  /// the result is `-0.0`.
  double roundToDouble() => value.roundToDouble();

  /// Returns the greatest double integer value no greater than `this`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is a
  /// non-finite double value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`.
  /// A number `d` in the range `0.0 < d < 1.0` will return `0.0`.
  double floorToDouble() => value.floorToDouble();

  /// Returns the least double integer value no smaller than `this`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is a
  /// non-finite double value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`.
  /// A number `d` in the range `-1.0 < d < 0.0` will return `-0.0`.
  double ceilToDouble() => value.ceilToDouble();

  /// Returns the double integer value obtained by discarding any fractional
  /// digits from the double value of `this`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is a
  /// non-finite double value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`.
  /// A number `d` in the range `-1.0 < d < 0.0` will return `-0.0`, and
  /// in the range `0.0 < d < 1.0` it will return 0.0.
  double truncateToDouble() => value.truncateToDouble();

  /// Returns this [num] clamped to be in the range [lowerLimit]-[upperLimit].
  ///
  /// The comparison is done using [compareTo] and therefore takes `-0.0` into
  /// account. This also implies that [double.nan] is treated as the maximal
  /// double value.
  ///
  /// The arguments [lowerLimit] and [upperLimit] must form a valid range where
  /// `lowerLimit.compareTo(upperLimit) <= 0`.
  ///
  /// Example:
  /// ```dart
  /// var result = 10.5.clamp(5, 10.0); // 10.0
  /// result = 0.75.clamp(5, 10.0); // 5
  /// result = (-10).clamp(-5, 5.0); // -5
  /// result = (-0.0).clamp(-5, 5.0); // -0.0
  /// ```
  num clamp(num lowerLimit, num upperLimit) =>
      value.clamp(lowerLimit, upperLimit);

  /// Truncates this [num] to an integer and returns the result as an [int].
  ///
  /// Equivalent to [truncate].
  int toInt() => value.toInt();

  /// This number as a [double].
  ///
  /// If an integer number is not precisely representable as a [double],
  /// an approximation is returned.
  double toDouble() => value.toDouble();

  /// A decimal-point string-representation of this number.
  ///
  /// Converts this number to a [double]
  /// before computing the string representation,
  /// as by [toDouble].
  ///
  /// If the absolute value of `this` is greater than or equal to `10^21`, then
  /// this methods returns an exponential representation computed by
  /// `this.toStringAsExponential()`. Otherwise the result
  /// is the closest string representation with exactly [fractionDigits] digits
  /// after the decimal point. If [fractionDigits] equals 0, then the decimal
  /// point is omitted.
  ///
  /// The parameter [fractionDigits] must be an integer satisfying:
  /// `0 <= fractionDigits <= 20`.
  ///
  /// Examples:
  /// ```dart
  /// 1.toStringAsFixed(3);  // 1.000
  /// (4321.12345678).toStringAsFixed(3);  // 4321.123
  /// (4321.12345678).toStringAsFixed(5);  // 4321.12346
  /// 123456789012345.toStringAsFixed(3);  // 123456789012345.000
  /// 10000000000000000.toStringAsFixed(4); // 10000000000000000.0000
  /// 5.25.toStringAsFixed(0); // 5
  /// ```
  String toStringAsFixed(int fractionDigits) =>
      value.toStringAsFixed(fractionDigits);

  /// An exponential string-representation of this number.
  ///
  /// Converts this number to a [double]
  /// before computing the string representation.
  ///
  /// If [fractionDigits] is given, then it must be an integer satisfying:
  /// `0 <= fractionDigits <= 20`. In this case the string contains exactly
  /// [fractionDigits] after the decimal point. Otherwise, without the parameter,
  /// the returned string uses the shortest number of digits that accurately
  /// represent this number.
  ///
  /// If [fractionDigits] equals 0, then the decimal point is omitted.
  /// Examples:
  /// ```dart
  /// 1.toStringAsExponential();       // 1e+0
  /// 1.toStringAsExponential(3);      // 1.000e+0
  /// 123456.toStringAsExponential();  // 1.23456e+5
  /// 123456.toStringAsExponential(3); // 1.235e+5
  /// 123.toStringAsExponential(0);    // 1e+2
  /// ```
  String toStringAsExponential([int? fractionDigits]) =>
      value.toStringAsExponential(fractionDigits);

  /// A string representation with [precision] significant digits.
  ///
  /// Converts this number to a [double]
  /// and returns a string representation of that value
  /// with exactly [precision] significant digits.
  ///
  /// The parameter [precision] must be an integer satisfying:
  /// `1 <= precision <= 21`.
  ///
  /// Examples:
  /// ```dart
  /// 1.toStringAsPrecision(2);       // 1.0
  /// 1e15.toStringAsPrecision(3);    // 1.00e+15
  /// 1234567.toStringAsPrecision(3); // 1.23e+6
  /// 1234567.toStringAsPrecision(9); // 1234567.00
  /// 12345678901234567890.toStringAsPrecision(20); // 12345678901234567168
  /// 12345678901234567890.toStringAsPrecision(14); // 1.2345678901235e+19
  /// 0.00000012345.toStringAsPrecision(15); // 1.23450000000000e-7
  /// 0.0000012345.toStringAsPrecision(15);  // 0.00000123450000000000
  /// ```
  String toStringAsPrecision(int precision) =>
      value.toStringAsPrecision(precision);
}

/// Extensions for [num]
extension SignalNumExtensions on num {
  /// Return a signal from a num value
  Signal<num> get $ => signal<num>(this);
}
