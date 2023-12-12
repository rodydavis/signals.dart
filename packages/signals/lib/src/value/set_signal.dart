import '../core/signals.dart';

/// A [Signal] that holds a [Set].
class SetSignal<E> extends ValueSignal<Set<E>> implements Set<E> {
  /// Creates a [SetSignal] with the given [value].
  SetSignal(super.value, {super.debugLabel});

  @override
  bool add(E value) {
    final result = this.value.add(value);
    forceUpdate(this.value);
    return result;
  }

  @override
  void addAll(Iterable<E> elements) {
    value.addAll(elements);
    forceUpdate(value);
  }

  @override
  bool any(bool Function(E element) test) {
    return value.any(test);
  }

  @override
  Set<R> cast<R>() {
    return value.cast<R>();
  }

  @override
  void clear() {
    value.clear();
    forceUpdate(value);
  }

  @override
  bool contains(Object? value) {
    return this.value.contains(value);
  }

  @override
  bool containsAll(Iterable<Object?> other) {
    return value.containsAll(other);
  }

  @override
  Set<E> difference(Set<Object?> other) {
    return value.difference(other);
  }

  @override
  E elementAt(int index) {
    return value.elementAt(index);
  }

  @override
  bool every(bool Function(E element) test) {
    return value.every(test);
  }

  @override
  Iterable<T> expand<T>(Iterable<T> Function(E element) toElements) {
    return value.expand(toElements);
  }

  @override
  E get first => value.first;

  @override
  E firstWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.firstWhere(test, orElse: orElse);
  }

  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) {
    return value.fold(initialValue, combine);
  }

  @override
  Iterable<E> followedBy(Iterable<E> other) {
    return value.followedBy(other);
  }

  @override
  void forEach(void Function(E element) action) {
    value.forEach(action);
    forceUpdate(value);
  }

  @override
  Set<E> intersection(Set<Object?> other) {
    return value.intersection(other);
  }

  @override
  bool get isEmpty => value.isEmpty;

  @override
  bool get isNotEmpty => value.isNotEmpty;

  @override
  Iterator<E> get iterator => value.iterator;

  @override
  String join([String separator = ""]) {
    return value.join(separator);
  }

  @override
  E get last => value.last;

  @override
  E lastWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.lastWhere(test, orElse: orElse);
  }

  @override
  int get length => value.length;

  /// Inject: Update current signal value with iterable
  SetSignal<E> operator <<(Set<E> other) {
    value.addAll(other);
    forceUpdate(value);
    return this;
  }

  /// Fork: create a new signal with value is the concatenation of source signal and iterable parameter
  SetSignal<E> operator &(Set<E> other) {
    final rs = Set<E>.from(peek())..addAll(other);
    return SetSignal(rs);
  }

  /// Pipe: create a new signal by sending value from source to other
  SetSignal<E> operator |(Signal<Iterable<E>> other) {
    final rs = Set<E>.from(peek())..addAll(other.peek());
    return SetSignal(rs);
  }

  @override
  E? lookup(Object? object) {
    return value.lookup(object);
  }

  @override
  Iterable<T> map<T>(T Function(E e) toElement) {
    return value.map<T>(toElement);
  }

  @override
  E reduce(E Function(E value, E element) combine) {
    return value.reduce(combine);
  }

  @override
  bool remove(Object? value) {
    final result = this.value.remove(value);
    forceUpdate(this.value);
    return result;
  }

  @override
  void removeAll(Iterable<Object?> elements) {
    value.removeAll(elements);
    forceUpdate(value);
  }

  @override
  void removeWhere(bool Function(E element) test) {
    value.removeWhere(test);
    forceUpdate(value);
  }

  @override
  void retainAll(Iterable<Object?> elements) {
    value.retainAll(elements);
    forceUpdate(value);
  }

  @override
  void retainWhere(bool Function(E element) test) {
    value.retainWhere(test);
    forceUpdate(value);
  }

  @override
  E get single => value.single;

  @override
  E singleWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.singleWhere(test, orElse: orElse);
  }

  @override
  Iterable<E> skip(int count) {
    return value.skip(count);
  }

  @override
  Iterable<E> skipWhile(bool Function(E value) test) {
    return value.skipWhile(test);
  }

  @override
  Iterable<E> take(int count) {
    return value.take(count);
  }

  @override
  Iterable<E> takeWhile(bool Function(E value) test) {
    return value.takeWhile(test);
  }

  @override
  List<E> toList({bool growable = true}) {
    return value.toList(growable: growable);
  }

  @override
  Set<E> toSet() {
    return value.toSet();
  }

  @override
  Set<E> union(Set<E> other) {
    return value.union(other);
  }

  @override
  Iterable<E> where(bool Function(E element) test) {
    return value.where(test);
  }

  @override
  Iterable<T> whereType<T>() {
    return value.whereType<T>();
  }

  @override
  bool operator ==(Object other) {
    return other is SetSignal<E> && value == other.value;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      globalId.hashCode,
      value.hashCode,
      for (final item in value) item.hashCode
    ]);
  }
}

/// Create an [SetSignal] from [Set]
SetSignal<T> setSignal<T>(
  Set<T> list, {
  String? debugLabel,
}) {
  return SetSignal<T>(
    list,
    debugLabel: debugLabel,
  );
}
