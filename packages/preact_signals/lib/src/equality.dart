/// Signal equality check
abstract class SignalEquality<T> {
  /// @nodoc
  const SignalEquality();

  /// Check if two values are equal
  bool equals(Object? a, Object? b);

  /// Standard equality check (a == b)
  static SignalEquality<T> standard<T>() => const StandardEquality<Never>();

  /// Identity equality check (identical(a, b))
  static SignalEquality<T> identity<T>() => const IdentityEquality<Never>();

  /// Deep equality check
  static SignalEquality<T> deep<T>() => const DeepEquality<Never>();

  /// Custom equality check
  factory SignalEquality.custom(bool Function(T a, T b) fn) = CustomEquality<T>;
}

/// Standard equality check (a == b)
class StandardEquality<T> extends SignalEquality<T> {
  /// Creates a new [StandardEquality] instance.
  const StandardEquality();
  @override
  bool equals(Object? a, Object? b) => a == b;
}

/// Identity equality check (identical(a, b))
class IdentityEquality<T> extends SignalEquality<T> {
  /// Creates a new [IdentityEquality] instance.
  const IdentityEquality();
  @override
  bool equals(Object? a, Object? b) => identical(a, b);
}

/// Custom equality check using a custom function
class CustomEquality<T> extends SignalEquality<T> {
  final bool Function(T a, T b) _fn;

  /// Creates a new [CustomEquality] instance.
  const CustomEquality(this._fn);
  @override
  bool equals(Object? a, Object? b) {
    if (a is! T || b is! T) return false;
    return _fn(a, b);
  }
}

/// Deep equality check for collections
class DeepEquality<T> extends SignalEquality<T> {
  /// Creates a new [DeepEquality] instance.
  const DeepEquality();
  @override
  bool equals(Object? a, Object? b) {
    // 1. Optimization: Check if they are the exact same object in memory
    if (identical(a, b)) return true;

    // 2. Early return if not a collection (handle primitives, nulls, and other objects)
    if (a is! List && a is! Map && a is! Set) return a == b;

    // 3. Handle Lists recursively
    if (a is List && b is List) {
      if (a.length != b.length) return false;
      for (int i = 0; i < a.length; i++) {
        if (!equals(a[i], b[i])) return false;
      }
      return true;
    }

    // 4. Handle Maps recursively
    if (a is Map && b is Map) {
      if (a.length != b.length) return false;
      for (final key in a.keys) {
        if (!b.containsKey(key) || !equals(a[key], b[key])) return false;
      }
      return true;
    }

    // 5. Handle Sets
    if (a is Set && b is Set) {
      return a.length == b.length && a.containsAll(b);
    }

    // 6. Fallback to standard value equality
    return a == b;
  }
}
