/// Defines the equality check algorithm used by signals to determine if a new value
/// actually differs from the current value.
///
/// By default, signals use standard Dart operator equality (`==`). However, you can configure
/// a signal to use different strategies, such as deep equality check for collections or custom comparator checks.
///
/// Strategies:
/// - [standard]: Default value equality (`a == b`).
/// - [identity]: Identity-based comparison (`identical(a, b)`).
/// - [deep]: Deep collection comparison for Lists, Maps, and Sets.
/// - [custom]: User-defined boolean comparison function.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// void main() {
///   // Create a list signal using deep equality check
///   final items = signal(
///     [1, 2, 3],
///     options: SignalOptions(
///       equality: SignalEquality.deep(),
///     ),
///   );
///
///   effect(() {
///     print('Items changed: ${items.value}');
///   });
///
///   // Reassigning an identical value structure does NOT trigger a rebuild!
///   items.value = [1, 2, 3];
///
///   // Triggers rebuild
///   items.value = [1, 2, 3, 4];
/// }
/// ```
abstract class SignalEquality<T> {
  /// @nodoc
  const SignalEquality();

  /// Check if two values are equal
  bool equals(Object? a, Object? b);

  /// Standard equality check (a == b)
  ///
  /// Matches two objects if their standard `==` operator returns true.
  /// This is the default strategy used by all signals.
  static SignalEquality<T> standard<T>() =>
      const SignalStandardEquality<Never>();

  /// Identity equality check (identical(a, b))
  ///
  /// Matches two objects only if they are the exact same instance in memory.
  static SignalEquality<T> identity<T>() =>
      const SignalIdentityEquality<Never>();

  /// Deep equality check
  ///
  /// Matches collections (Lists, Maps, Sets) recursively by comparing their items.
  static SignalEquality<T> deep<T>() => const SignalDeepEquality<Never>();

  /// Custom equality check
  ///
  /// Uses a user-provided boolean function [fn] to check for equality.
  factory SignalEquality.custom(bool Function(T a, T b) fn) =
      SignalCustomEquality<T>;
}

/// Standard equality check (a == b)
///
/// Matches two objects using the standard Dart operator `==`.
///
/// ### Example Usage
///
/// ```dart
/// final equality = SignalEquality.standard<int>();
/// print(equality.equals(5, 5)); // true
/// ```
class SignalStandardEquality<T> extends SignalEquality<T> {
  /// Creates a new [SignalStandardEquality] instance.
  const SignalStandardEquality();
  @override
  bool equals(Object? a, Object? b) => a == b;
}

/// Identity equality check (identical(a, b))
///
/// Matches two objects only if they point to the exact same instance in memory.
///
/// ### Example Usage
///
/// ```dart
/// final listA = [1, 2];
/// final listB = [1, 2];
/// final equality = SignalEquality.identity<List<int>>();
/// print(equality.equals(listA, listB)); // false
/// print(equality.equals(listA, listA)); // true
/// ```
class SignalIdentityEquality<T> extends SignalEquality<T> {
  /// Creates a new [SignalIdentityEquality] instance.
  const SignalIdentityEquality();
  @override
  bool equals(Object? a, Object? b) => identical(a, b);
}

/// Custom equality check using a custom function
///
/// Uses a custom comparison function to determine if two values of type [T] are equal.
///
/// ### Example Usage
///
/// ```dart
/// final equality = SignalEquality.custom((User a, User b) => a.id == b.id);
/// ```
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
///
/// Recursively compares Lists, Maps, and Sets to see if their nested elements are equal.
///
/// ### Example Usage
///
/// ```dart
/// final equality = SignalEquality.deep();
/// print(equality.equals([1, [2, 3]], [1, [2, 3]])); // true
/// ```
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
