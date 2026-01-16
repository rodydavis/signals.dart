/// Signal equality check
abstract class SignalEquality<T> {
  /// @nodoc
  const SignalEquality();

  /// Check if two values are equal
  bool equals(T a, T b);

  /// Standard equality check (a == b)
  static SignalEquality<T> standard<T>() => _StandardEquality<T>();

  /// Identity equality check (identical(a, b))
  static SignalEquality<T> identity<T>() => _IdentityEquality<T>();

  /// Deep equality check
  static SignalEquality<T> deep<T>() => _DeepEquality<T>();

  /// Custom equality check
  factory SignalEquality.custom(bool Function(T a, T b) fn) =
      _CustomEquality<T>;
}

class _StandardEquality<T> extends SignalEquality<T> {
  const _StandardEquality();
  @override
  bool equals(T a, T b) => a == b;
}

class _IdentityEquality<T> extends SignalEquality<T> {
  const _IdentityEquality();
  @override
  bool equals(T a, T b) => identical(a, b);
}

class _CustomEquality<T> extends SignalEquality<T> {
  final bool Function(T a, T b) _fn;
  const _CustomEquality(this._fn);
  @override
  bool equals(T a, T b) => _fn(a, b);
}

class _DeepEquality<T> extends SignalEquality<T> {
  const _DeepEquality();
  @override
  bool equals(T a, T b) {
    // 1. Optimization: Check if they are the exact same object in memory
    if (identical(a, b)) return true;

    // 2. Early return if not a collection (handle primitives, nulls, and other objects)
    // This avoids unnecessary type checks for simple types like int, String, etc.
    if (a is! List && a is! Map && a is! Set) return a == b;

    // 3. Handle Lists (Arrays) recursively
    if (a is List && b is List) {
      if (a.length != b.length) return false;
      for (int i = 0; i < a.length; i++) {
        if (!equals(a[i], b[i])) return false;
      }
      return true;
    }

    // 4. Handle Maps (Key-Value pairs) recursively
    if (a is Map && b is Map) {
      if (a.length != b.length) return false;
      for (final key in a.keys) {
        // Check if key exists and if the value matches recursively
        if (!b.containsKey(key) || !equals(a[key], b[key])) return false;
      }
      return true;
    }

    // 5. Handle Sets (Unordered unique items)
    // Note: This relies on the element's `==` operator because Sets are hash-based.
    // True deep equality for Sets of objects without custom == is computationally
    // expensive (O(N^2)) and rarely needed, so we use standard set equality here.
    if (a is Set && b is Set) {
      return a.length == b.length && a.containsAll(b);
    }

    // 6. Fallback to standard value equality (operator ==)
    return a == b;
  }
}
