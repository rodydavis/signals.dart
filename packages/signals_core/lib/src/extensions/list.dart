import 'dart:math';

// ignore_for_file: public_member_api_docs

import '../core/signals.dart';

/// Helper extensions for [ReadonlySignal<List>]
extension ReadonlyListSignalExtension<E> on ReadonlySignal<List<E>> {
  List<R> cast<R>() {
    return value.cast<R>();
  }

  E get last => value.last;

  List<E> operator +(List<E> other) {
    return value + other;
  }

  E operator [](int index) {
    return value[index];
  }

  Map<int, E> asMap() {
    return value.asMap();
  }

  Iterable<R> expand<R>(Iterable<R> Function(E element) toElements) {
    return value.expand<R>(toElements);
  }

  E firstWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.firstWhere(test, orElse: orElse);
  }

  R fold<R>(R initialValue, R Function(R previousValue, E element) combine) {
    return value.fold<R>(initialValue, combine);
  }

  Iterable<E> followedBy(Iterable<E> other) {
    return value.followedBy(other);
  }

  Iterable<E> getRange(int start, int end) {
    return value.getRange(start, end);
  }

  int indexOf(E element, [int start = 0]) {
    return value.indexOf(element, start);
  }

  int indexWhere(bool Function(E element) test, [int start = 0]) {
    return value.indexWhere(test, start);
  }

  int lastIndexOf(E element, [int? start]) {
    return value.lastIndexOf(element, start);
  }

  int lastIndexWhere(bool Function(E element) test, [int? start]) {
    return value.lastIndexWhere(test, start);
  }

  Iterable<E> get reversed => value.reversed;

  /// Return a new array that is sorted by the [compare] function
  List<E> sorted([int Function(E a, E b)? compare]) {
    final items = value.toList();
    items.sort(compare);
    return items;
  }

  List<E> sublist(int start, [int? end]) {
    return value.sublist(start, end);
  }
}

/// Helper extensions for [Signal<List>]
extension ListSignalExtension<E> on Signal<List<E>> {
  set first(E val) {
    value.first = val;
    set(value, force: true);
  }

  set last(E val) {
    value.last = val;
    set(value, force: true);
  }

  set length(int value) {
    this.value.length = value;
    set(this.value, force: true);
  }

  void operator []=(int index, E value) {
    this.value[index] = value;
    set(this.value, force: true);
  }

  void add(E value) {
    this.value.add(value);
    set(this.value, force: true);
  }

  void addAll(Iterable<E> iterable) {
    value.addAll(iterable);
    set(value, force: true);
  }

  void clear() {
    value.clear();
    set(value, force: true);
  }

  void fillRange(int start, int end, [E? fillValue]) {
    value.fillRange(start, end, fillValue);
    set(value, force: true);
  }

  void insert(int index, E element) {
    value.insert(index, element);
    set(value, force: true);
  }

  void insertAll(int index, Iterable<E> iterable) {
    value.insertAll(index, iterable);
    set(value, force: true);
  }

  bool remove(Object? value) {
    final result = this.value.remove(value);
    set(this.value, force: true);
    return result;
  }

  E removeAt(int index) {
    final result = value.removeAt(index);
    set(value, force: true);
    return result;
  }

  E removeLast() {
    final result = value.removeLast();
    set(value, force: true);
    return result;
  }

  void removeRange(int start, int end) {
    value.removeRange(start, end);
    set(value, force: true);
  }

  void removeWhere(bool Function(E element) test) {
    value.removeWhere(test);
    set(value, force: true);
  }

  void replaceRange(int start, int end, Iterable<E> replacements) {
    value.replaceRange(start, end, replacements);
    set(value, force: true);
  }

  void retainWhere(bool Function(E element) test) {
    value.retainWhere(test);
    set(value, force: true);
  }

  void setAll(int index, Iterable<E> iterable) {
    value.setAll(index, iterable);
    set(value, force: true);
  }

  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    value.setRange(start, end, iterable, skipCount);
    set(value, force: true);
  }

  void shuffle([Random? random]) {
    value.shuffle(random);
    set(value, force: true);
  }

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
