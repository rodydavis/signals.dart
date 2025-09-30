import '../core/signals.dart';

/// Helper extensions for [ReadonlySignal<Comparable<T>>]
extension ComparableSignalExtension<T extends Comparable> on ReadonlySignal<T> {
  /// Compares this object to another object.
  ///
  /// Returns a value like a [Comparator] when comparing `this` to [other].
  /// That is, it returns a negative integer if `this` is ordered before [other],
  /// a positive integer if `this` is ordered after [other],
  /// and zero if `this` and [other] are ordered together.
  ///
  /// The [other] argument must be a value that is comparable to this object.
  int compareTo(T other) => value.compareTo(other);
}

/// Extensions for [Comparable<T>]
extension SignalComparableExtensions<T> on Comparable<T> {
  /// Return a signal from a Comparable value
  Signal<Comparable<T>> get $ => signal<Comparable<T>>(this);
}
