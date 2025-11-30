import '../core/signals.dart';

/// Helper extensions for [ReadonlySignal<Set>]
extension ReadonlySetSignalExtension<E> on ReadonlySignal<Set<E>> {
  Set<R> cast<R>() {
    return value.cast<R>();
  }

  bool containsAll(Iterable<Object?> other) {
    return value.containsAll(other);
  }

  Set<E> difference(Set<Object?> other) {
    return value.difference(other);
  }

  Set<E> intersection(Set<Object?> other) {
    return value.intersection(other);
  }

  E? lookup(Object? object) {
    return value.lookup(object);
  }

  Set<E> union(Set<E> other) {
    return value.union(other);
  }
}

/// Helper extensions for [Signal<Set>]
extension SetSignalExtension<E> on Signal<Set<E>> {
  bool add(E value) {
    final list = this.value;
    final result = list.add(value);
    set(list, force: true);
    return result;
  }

  void addAll(Iterable<E> elements) {
    final list = value;
    list.addAll(elements);
    set(list, force: true);
  }

  void clear() => set(<E>{}, force: true);

  bool remove(Object? value) {
    final list = this.value;
    final result = list.remove(value);
    set(list, force: true);
    return result;
  }

  void removeAll(Iterable<Object?> elements) {
    final list = value;
    list.removeAll(elements);
    set(list, force: true);
  }

  void removeWhere(bool Function(E element) test) {
    final list = value;
    list.removeWhere(test);
    set(list, force: true);
  }

  void retainAll(Iterable<Object?> elements) {
    final list = value;
    list.retainAll(elements);
    set(list, force: true);
  }

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
