import 'dart:math';

import '../core/signals.dart';

/// Helper extensions for [ReadonlySignal<List>]
extension ReadonlyListSignalExtension<E> on ReadonlySignal<List<E>> {
  /// Cast the list to a new type
  List<R> cast<R>() {
    return value.cast<R>();
  }

  /// Get the last element
  E get last => value.last;

  /// Concatenate two lists
  List<E> operator +(List<E> other) {
    return value + other;
  }

  /// Get element at index
  E operator [](int index) {
    return value[index];
  }

  /// Convert list to map
  Map<int, E> asMap() {
    return value.asMap();
  }

  /// Expand the list
  Iterable<R> expand<R>(Iterable<R> Function(E element) toElements) {
    return value.expand<R>(toElements);
  }

  /// Find the first element that matches the test
  E firstWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.firstWhere(test, orElse: orElse);
  }

  /// Fold the list
  R fold<R>(R initialValue, R Function(R previousValue, E element) combine) {
    return value.fold<R>(initialValue, combine);
  }

  /// Followed by
  Iterable<E> followedBy(Iterable<E> other) {
    return value.followedBy(other);
  }

  /// Get range
  Iterable<E> getRange(int start, int end) {
    return value.getRange(start, end);
  }

  /// Index of element
  int indexOf(E element, [int start = 0]) {
    return value.indexOf(element, start);
  }

  /// Index where
  int indexWhere(bool Function(E element) test, [int start = 0]) {
    return value.indexWhere(test, start);
  }

  /// Last index of element
  int lastIndexOf(E element, [int? start]) {
    return value.lastIndexOf(element, start);
  }

  /// Last index where
  int lastIndexWhere(bool Function(E element) test, [int? start]) {
    return value.lastIndexWhere(test, start);
  }

  /// Reversed list
  Iterable<E> get reversed => value.reversed;

  /// Return a new array that is sorted by the [compare] function
  List<E> sorted([int Function(E a, E b)? compare]) {
    final items = value.toList();
    items.sort(compare);
    return items;
  }

  /// Sublist
  List<E> sublist(int start, [int? end]) {
    return value.sublist(start, end);
  }
}

/// Helper extensions for [Signal<List>]
extension ListSignalExtension<E> on Signal<List<E>> {
  /// Set first element
  set first(E val) {
    value.first = val;
    set(value, force: true);
  }

  /// Set last element
  set last(E val) {
    value.last = val;
    set(value, force: true);
  }

  /// Set length
  set length(int value) {
    this.value.length = value;
    set(this.value, force: true);
  }

  /// Set element at index
  void operator []=(int index, E value) {
    this.value[index] = value;
    set(this.value, force: true);
  }

  /// Add element
  void add(E value) {
    this.value.add(value);
    set(this.value, force: true);
  }

  /// Add all elements
  void addAll(Iterable<E> iterable) {
    value.addAll(iterable);
    set(value, force: true);
  }

  /// Clear list
  void clear() {
    value.clear();
    set(value, force: true);
  }

  /// Fill range
  void fillRange(int start, int end, [E? fillValue]) {
    value.fillRange(start, end, fillValue);
    set(value, force: true);
  }

  /// Insert element
  void insert(int index, E element) {
    value.insert(index, element);
    set(value, force: true);
  }

  /// Insert all elements
  void insertAll(int index, Iterable<E> iterable) {
    value.insertAll(index, iterable);
    set(value, force: true);
  }

  /// Remove element
  bool remove(Object? value) {
    final result = this.value.remove(value);
    set(this.value, force: true);
    return result;
  }

  /// Remove element at index
  E removeAt(int index) {
    final result = value.removeAt(index);
    set(value, force: true);
    return result;
  }

  /// Remove last element
  E removeLast() {
    final result = value.removeLast();
    set(value, force: true);
    return result;
  }

  /// Remove range
  void removeRange(int start, int end) {
    value.removeRange(start, end);
    set(value, force: true);
  }

  /// Remove where
  void removeWhere(bool Function(E element) test) {
    value.removeWhere(test);
    set(value, force: true);
  }

  /// Replace range
  void replaceRange(int start, int end, Iterable<E> replacements) {
    value.replaceRange(start, end, replacements);
    set(value, force: true);
  }

  /// Retain where
  void retainWhere(bool Function(E element) test) {
    value.retainWhere(test);
    set(value, force: true);
  }

  /// Set all
  void setAll(int index, Iterable<E> iterable) {
    value.setAll(index, iterable);
    set(value, force: true);
  }

  /// Set range
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    value.setRange(start, end, iterable, skipCount);
    set(value, force: true);
  }

  /// Shuffle
  void shuffle([Random? random]) {
    value.shuffle(random);
    set(value, force: true);
  }

  /// Sort
  void sort([int Function(E a, E b)? compare]) {
    value.sort(compare);
    set(value, force: true);
  }
}

/// Extensions for [List<E>]
extension SignalListExtensions<E> on List<E> {
  /// Return a signal from a List value
  Signal<List<E>> get $ => signal<List<E>>(this);
}
