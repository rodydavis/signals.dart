import '../core/signals.dart';

/// Helper extensions for [ReadonlySignal<Set>]
extension ReadonlySetSignalExtension<E> on ReadonlySignal<Set<E>> {
  /// Cast the set to a new type
  Set<R> cast<R>() {
    return value.cast<R>();
  }

  /// Check if the set contains all elements
  bool containsAll(Iterable<Object?> other) {
    return value.containsAll(other);
  }

  /// Create a new set with elements that are not in the other set
  Set<E> difference(Set<Object?> other) {
    return value.difference(other);
  }

  /// Create a new set with elements that are in both sets
  Set<E> intersection(Set<Object?> other) {
    return value.intersection(other);
  }

  /// Lookup an object in the set
  E? lookup(Object? object) {
    return value.lookup(object);
  }

  /// Create a new set with elements from both sets
  Set<E> union(Set<E> other) {
    return value.union(other);
  }
}

/// Helper extensions for [Signal<Set>]
extension SetSignalExtension<E> on Signal<Set<E>> {
  /// Add a value to the set
  bool add(E value) {
    final list = this.value;
    final result = list.add(value);
    set(list, force: true);
    return result;
  }

  /// Add all elements to the set
  void addAll(Iterable<E> elements) {
    final list = value;
    list.addAll(elements);
    set(list, force: true);
  }

  /// Clear the set
  void clear() => set(<E>{}, force: true);

  /// Remove a value from the set
  bool remove(Object? value) {
    final list = this.value;
    final result = list.remove(value);
    set(list, force: true);
    return result;
  }

  /// Remove all elements from the set
  void removeAll(Iterable<Object?> elements) {
    final list = value;
    list.removeAll(elements);
    set(list, force: true);
  }

  /// Remove elements that match the test
  void removeWhere(bool Function(E element) test) {
    final list = value;
    list.removeWhere(test);
    set(list, force: true);
  }

  /// Retain all elements from the set
  void retainAll(Iterable<Object?> elements) {
    final list = value;
    list.retainAll(elements);
    set(list, force: true);
  }

  /// Retain elements that match the test
  void retainWhere(bool Function(E element) test) {
    final list = value;
    list.retainWhere(test);
    set(list, force: true);
  }
}

/// Extensions for [Set<E>]
extension SignalSetExtensions<E> on Set<E> {
  /// Return a signal from a Set value
  Signal<Set<E>> get $ => signal<Set<E>>(this);
}
