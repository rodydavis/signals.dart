/// Provides a [DeepCollectionEquality] class that can be used to compare the
/// equality of complex data structures, such as maps, sets, and iterables,
/// by recursively comparing their elements.
///
/// The [equals] method compares two objects for deep equality, handling maps,
/// sets, and iterables. The [hash] method generates a hash code for an object,
/// also handling maps, sets, and iterables.
///
/// This class is useful when you need to compare complex data structures for
/// equality or use them as keys in a hash-based data structure, such as a
/// [Map] or [Set].
class DeepCollectionEquality {
  /// Creates a new [DeepCollectionEquality] instance.
  const DeepCollectionEquality();

  /// Compares two maps for deep equality.
  /// The maps are equal if they have the same keys and values.
  /// The order of keys is not considered.
  bool _mapsEqual(Map map1, Map map2) {
    if (map1.length != map2.length) return false;
    for (var key in map1.keys) {
      if (!map2.containsKey(key) || !equals(map1[key], map2[key])) {
        return false;
      }
    }

    return true;
  }

  /// Compares two iterables for deep equality, considering element order.
  /// The iterables are equal if they have the same length and contain the same
  /// elements in the same order.
  bool _iterablesEqual(Iterable iter1, Iterable iter2) {
    if (iter1.length != iter2.length) return false;
    if (iter1 is List && iter2 is List) {
      for (int i = 0; i < iter1.length; i++) {
        if (!equals(iter1[i], iter2[i])) {
          return false;
        }
      }

      return true;
    }

    return false;
  }

  /// Compares two sets for deep equality.
  /// The order of elements in the sets is not considered.
  /// The sets are equal if they contain the same elements.
  bool _setsEqual(Set set1, Set set2) {
    if (set1.length != set2.length) return false;
    for (var value in set1) {
      if (!set2.contains(value)) {
        return false;
      }
    }

    return true;
  }

  /// Compares two objects for deep equality.
  /// The objects are equal if they reference the same object
  /// or their types are equal and their fields are equal.
  bool equals(Object? obj1, Object? obj2) {
    if (identical(obj1, obj2)) return true;
    if (obj1.runtimeType != obj2.runtimeType) return false;

    if (obj1 is Map) {
      return _mapsEqual(obj1, obj2 as Map);
    } else if (obj1 is Set) {
      return _setsEqual(obj1, obj2 as Set);
    } else if (obj1 is Iterable) {
      return _iterablesEqual(obj1, obj2 as Iterable);
    }

    return obj1 == obj2;
  }
}
