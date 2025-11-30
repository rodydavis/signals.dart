import '../core/signals.dart';

/// Helper extensions for [ReadonlySignal<Iterable>]
extension ReadonlyIterableSignalExtension<E> on ReadonlySignal<Iterable<E>> {
  /// Check if any element matches
  bool any(bool Function(E element) test) {
    return value.any(test);
  }

  /// Cast iterable
  Iterable<R> cast<R>() {
    return value.cast<R>();
  }

  /// Check if contains
  bool contains(Object? value) {
    return this.value.contains(value);
  }

  /// Element at index
  E elementAt(int index) {
    return value.elementAt(index);
  }

  /// Check if every element matches
  bool every(bool Function(E element) test) {
    return value.every(test);
  }

  /// Expand
  Iterable<R> expand<R>(Iterable<R> Function(E element) toElements) {
    return value.expand(toElements);
  }

  /// First element
  E get first => value.first;

  /// First where
  E firstWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.firstWhere(test, orElse: orElse);
  }

  /// Fold
  R fold<R>(R initialValue, R Function(R previousValue, E element) combine) {
    return value.fold(initialValue, combine);
  }

  /// Followed by
  Iterable<E> followedBy(Iterable<E> other) {
    return value.followedBy(other);
  }

  /// Check if empty
  bool get isEmpty => value.isEmpty;

  /// Check if not empty
  bool get isNotEmpty => value.isNotEmpty;

  /// Iterator
  Iterator<E> get iterator => value.iterator;

  /// Join
  String join([String separator = ""]) {
    return value.join(separator);
  }

  /// Last element
  E get last => value.last;

  /// Last where
  E lastWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.lastWhere(test, orElse: orElse);
  }

  /// Length
  int get length => value.length;

  /// Map
  Iterable<R> map<R>(R Function(E e) toElement) {
    return value.map<R>(toElement);
  }

  /// Reduce
  E reduce(E Function(E value, E element) combine) {
    return value.reduce(combine);
  }

  /// Single element
  E get single => value.single;

  /// Single where
  E singleWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.singleWhere(test, orElse: orElse);
  }

  /// Skip
  Iterable<E> skip(int count) {
    return value.skip(count);
  }

  /// Skip while
  Iterable<E> skipWhile(bool Function(E value) test) {
    return value.skipWhile(test);
  }

  /// Take
  Iterable<E> take(int count) {
    return value.take(count);
  }

  /// Take while
  Iterable<E> takeWhile(bool Function(E value) test) {
    return value.takeWhile(test);
  }

  /// To list
  List<E> toList({bool growable = true}) {
    return value.toList(growable: growable);
  }

  /// To set
  Set<E> toSet() {
    return value.toSet();
  }

  /// Where
  Iterable<E> where(bool Function(E element) test) {
    return value.where(test);
  }

  /// Where type
  Iterable<R> whereType<R>() {
    return value.whereType<R>();
  }

  /// For each
  void forEach(void Function(E element) action) {
    value.forEach(action);
  }
}

/// Extensions for [Iterable<E>]
extension SignalIterableExtensions<E> on Iterable<E> {
  /// Return a signal from a Iterable value
  Signal<Iterable<E>> get $ => signal<Iterable<E>>(this);
}
