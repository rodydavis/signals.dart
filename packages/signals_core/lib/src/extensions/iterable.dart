import '../core/signals.dart';

/// Helper extensions for [ReadonlySignal<Iterable>]
extension ReadonlyIterableSignalExtension<E> on ReadonlySignal<Iterable<E>> {
  bool any(bool Function(E element) test) {
    return value.any(test);
  }

  Iterable<R> cast<R>() {
    return value.cast<R>();
  }

  bool contains(Object? value) {
    return this.value.contains(value);
  }

  E elementAt(int index) {
    return value.elementAt(index);
  }

  bool every(bool Function(E element) test) {
    return value.every(test);
  }

  Iterable<R> expand<R>(Iterable<R> Function(E element) toElements) {
    return value.expand(toElements);
  }

  E get first => value.first;

  E firstWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.firstWhere(test, orElse: orElse);
  }

  R fold<R>(R initialValue, R Function(R previousValue, E element) combine) {
    return value.fold(initialValue, combine);
  }

  Iterable<E> followedBy(Iterable<E> other) {
    return value.followedBy(other);
  }

  bool get isEmpty => value.isEmpty;

  bool get isNotEmpty => value.isNotEmpty;

  Iterator<E> get iterator => value.iterator;

  String join([String separator = ""]) {
    return value.join(separator);
  }

  E get last => value.last;

  E lastWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.lastWhere(test, orElse: orElse);
  }

  int get length => value.length;

  Iterable<R> map<R>(R Function(E e) toElement) {
    return value.map<R>(toElement);
  }

  E reduce(E Function(E value, E element) combine) {
    return value.reduce(combine);
  }

  E get single => value.single;

  E singleWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.singleWhere(test, orElse: orElse);
  }

  Iterable<E> skip(int count) {
    return value.skip(count);
  }

  Iterable<E> skipWhile(bool Function(E value) test) {
    return value.skipWhile(test);
  }

  Iterable<E> take(int count) {
    return value.take(count);
  }

  Iterable<E> takeWhile(bool Function(E value) test) {
    return value.takeWhile(test);
  }

  List<E> toList({bool growable = true}) {
    return value.toList(growable: growable);
  }

  Set<E> toSet() {
    return value.toSet();
  }

  Iterable<E> where(bool Function(E element) test) {
    return value.where(test);
  }

  Iterable<R> whereType<R>() {
    return value.whereType<R>();
  }

  void forEach(void Function(E element) action) {
    value.forEach(action);
  }
}

/// Extensions for [Iterable<E>]
extension SignalIterableExtensions<E> on Iterable<E> {
  /// Return a signal from a Iterable value
  Signal<Iterable<E>> get $ => signal<Iterable<E>>(this);
}
