import '../core/signals.dart';

/// Mixin to upgrade an set signal with reactive properties
mixin SetSignalMixin<E, T extends Set<E>> on Signal<T> implements Set<E> {
  @override
  bool add(E value) {
    final list = this.value;
    final result = list.add(value);
    set(list, force: true);
    return result;
  }

  @override
  void addAll(Iterable<E> elements) {
    final list = value;
    list.addAll(elements);
    set(list, force: true);
  }

  @override
  Set<R> cast<R>() {
    return value.cast<R>();
  }

  @override
  void clear() => set(<E>{} as T, force: true);

  @override
  bool containsAll(Iterable<Object?> other) {
    return value.containsAll(other);
  }

  @override
  Set<E> difference(Set<Object?> other) {
    return value.difference(other);
  }

  @override
  Set<E> intersection(Set<Object?> other) {
    return value.intersection(other);
  }

  @override
  E? lookup(Object? object) {
    return value.lookup(object);
  }

  @override
  bool remove(Object? value) {
    final list = this.value;
    final result = list.remove(value);
    set(list, force: true);
    return result;
  }

  @override
  void removeAll(Iterable<Object?> elements) {
    final list = value;
    list.removeAll(elements);
    set(list, force: true);
  }

  @override
  void removeWhere(bool Function(E element) test) {
    final list = value;
    list.removeWhere(test);
    set(list, force: true);
  }

  @override
  void retainAll(Iterable<Object?> elements) {
    final list = value;
    list.retainAll(elements);
    set(list, force: true);
  }

  @override
  void retainWhere(bool Function(E element) test) {
    final list = value;
    list.retainWhere(test);
    set(list, force: true);
  }

  @override
  Set<E> union(Set<E> other) {
    return value.union(other);
  }
}
