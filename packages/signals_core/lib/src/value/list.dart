import 'dart:math';

import '../core/signals.dart';

/// A [Signal] that holds a [List].
class ListSignal<E> extends ValueSignal<List<E>> implements List<E> {
  /// Creates a [ListSignal] with the given [value].
  ListSignal(super.value, {super.debugLabel});

  @override
  E get first => value.first;

  @override
  set first(E val) {
    value.first = val;
    forceUpdate(value);
  }

  @override
  E get last => value.last;

  @override
  set last(E val) {
    value.last = val;
    forceUpdate(value);
  }

  @override
  int get length => value.length;

  @override
  set length(int value) {
    this.value.length = value;
    forceUpdate(this.value);
  }

  @override
  List<E> operator +(List<E> other) {
    return value + other;
  }

  @override
  E operator [](int index) {
    return value[index];
  }

  @override
  void operator []=(int index, E value) {
    this.value[index] = value;
    forceUpdate(this.value);
  }

  /// Inject: Update current signal value with iterable
  ListSignal<E> operator <<(Iterable<E> other) {
    value.addAll(other);
    forceUpdate(value);
    return this;
  }

  /// Fork: create a new signal which value is the concatenation of source signal and iterable parameter
  ListSignal<E> operator &(Iterable<E> other) {
    final rs = List<E>.from(peek())..addAll(other);
    return ListSignal(rs);
  }

  /// Pipe: create a new signal by sending value from source to other
  ListSignal<E> operator |(Signal<Iterable<E>> other) {
    final rs = List<E>.from(peek())..addAll(other.peek());
    return ListSignal(rs);
  }

  @override
  void add(E value) {
    this.value.add(value);
    forceUpdate(this.value);
  }

  @override
  void addAll(Iterable<E> iterable) {
    value.addAll(iterable);
    forceUpdate(value);
  }

  @override
  bool any(bool Function(E element) test) {
    return value.any(test);
  }

  @override
  Map<int, E> asMap() {
    return value.asMap();
  }

  @override
  List<R> cast<R>() {
    return value.cast<R>();
  }

  @override
  void clear() {
    value.clear();
    forceUpdate(value);
  }

  @override
  bool contains(Object? element) {
    return value.contains(element);
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
    return value.expand<T>(toElements);
  }

  @override
  void fillRange(int start, int end, [E? fillValue]) {
    value.fillRange(start, end, fillValue);
    forceUpdate(value);
  }

  @override
  E firstWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.firstWhere(test, orElse: orElse);
  }

  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) {
    return value.fold<T>(initialValue, combine);
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
  Iterable<E> getRange(int start, int end) {
    return value.getRange(start, end);
  }

  @override
  int indexOf(E element, [int start = 0]) {
    return value.indexOf(element, start);
  }

  @override
  int indexWhere(bool Function(E element) test, [int start = 0]) {
    return value.indexWhere(test, start);
  }

  @override
  void insert(int index, E element) {
    value.insert(index, element);
    forceUpdate(value);
  }

  @override
  void insertAll(int index, Iterable<E> iterable) {
    value.insertAll(index, iterable);
    forceUpdate(value);
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
  int lastIndexOf(E element, [int? start]) {
    return value.lastIndexOf(element, start);
  }

  @override
  int lastIndexWhere(bool Function(E element) test, [int? start]) {
    return value.lastIndexWhere(test, start);
  }

  @override
  E lastWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.lastWhere(test, orElse: orElse);
  }

  @override
  Iterable<T> map<T>(T Function(E e) toElement) {
    return value.map(toElement);
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
  E removeAt(int index) {
    final result = value.removeAt(index);
    forceUpdate(value);
    return result;
  }

  @override
  E removeLast() {
    final result = value.removeLast();
    forceUpdate(value);
    return result;
  }

  @override
  void removeRange(int start, int end) {
    value.removeRange(start, end);
    forceUpdate(value);
  }

  @override
  void removeWhere(bool Function(E element) test) {
    value.removeWhere(test);
    forceUpdate(value);
  }

  @override
  void replaceRange(int start, int end, Iterable<E> replacements) {
    value.replaceRange(start, end, replacements);
    forceUpdate(value);
  }

  @override
  void retainWhere(bool Function(E element) test) {
    value.retainWhere(test);
    forceUpdate(value);
  }

  @override
  Iterable<E> get reversed => value.reversed;

  @override
  void setAll(int index, Iterable<E> iterable) {
    value.setAll(index, iterable);
    forceUpdate(value);
  }

  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    value.setRange(start, end, iterable, skipCount);
    forceUpdate(value);
  }

  @override
  void shuffle([Random? random]) {
    value.shuffle(random);
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
  void sort([int Function(E a, E b)? compare]) {
    value.sort(compare);
    forceUpdate(value);
  }

  /// Return a new array that is sorted by the [compare] function
  List<E> sorted([int Function(E a, E b)? compare]) {
    final items = toList();
    items.sort(compare);
    return items;
  }

  @override
  List<E> sublist(int start, [int? end]) {
    return value.sublist(start, end);
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
  Iterable<E> where(bool Function(E element) test) {
    return value.where(test);
  }

  @override
  Iterable<T> whereType<T>() {
    return value.whereType<T>();
  }

  @override
  bool operator ==(Object other) {
    return other is ListSignal<E> && value == other.value;
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

/// Create an [ListSignal] from [List]
ListSignal<T> listSignal<T>(
  List<T> list, {
  String? debugLabel,
}) {
  return ListSignal<T>(
    list,
    debugLabel: debugLabel,
  );
}
