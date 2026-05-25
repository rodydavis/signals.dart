/// Signal equality check
abstract class SignalEquality<T> {
  /// @nodoc
  const SignalEquality();

  /// Check if two values are equal
  bool equals(Object? a, Object? b);

  /// Standard equality check (a == b)
  static SignalEquality<T> standard<T>() =>
      const SignalStandardEquality<Never>();

  /// Identity equality check (identical(a, b))
  static SignalEquality<T> identity<T>() =>
      const SignalIdentityEquality<Never>();

  /// Deep equality check
  static SignalEquality<T> deep<T>() => const SignalDeepEquality<Never>();

  /// Custom equality check
  factory SignalEquality.custom(bool Function(T a, T b) fn) =
      SignalCustomEquality<T>;
}

/// Standard equality check (a == b)
class SignalStandardEquality<T> extends SignalEquality<T> {
  /// Creates a new [SignalStandardEquality] instance.
  const SignalStandardEquality();
  @override
  bool equals(Object? a, Object? b) => a == b;
}

/// Identity equality check (identical(a, b))
class SignalIdentityEquality<T> extends SignalEquality<T> {
  /// Creates a new [SignalIdentityEquality] instance.
  const SignalIdentityEquality();
  @override
  bool equals(Object? a, Object? b) => identical(a, b);
}

/// Custom equality check using a custom function
class SignalCustomEquality<T> extends SignalEquality<T> {
  final bool Function(T a, T b) _fn;

  /// Creates a new [SignalCustomEquality] instance.
  const SignalCustomEquality(this._fn);
  @override
  bool equals(Object? a, Object? b) {
    if (a is! T || b is! T) return false;
    return _fn(a, b);
  }
}

/// Deep equality check for collections
class SignalDeepEquality<T> extends SignalEquality<T> {
  /// Creates a new [SignalDeepEquality] instance.
  const SignalDeepEquality();
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
      if (a.length != b.length) return false;
      final bList = b.toList();
      for (final elementA in a) {
        bool found = false;
        for (int i = 0; i < bList.length; i++) {
          if (equals(elementA, bList[i])) {
            bList.removeAt(i);
            found = true;
            break;
          }
        }
        if (!found) return false;
      }
      return true;
    }

    // 6. Fallback to standard value equality
    return a == b;
  }
}
