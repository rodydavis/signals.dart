// ignore_for_file: public_member_api_docs
import 'dart:math';

import '../core/signals.dart';

/// A mixin that adds reactive `List` methods and operators to a [Signal]
/// holding a [List] value.
///
/// This mixin delegates all standard [List] operations (such as mutations like `add`,
/// `remove`, `insert`, `sort`, and `clear`, and accessor operators like `[]` and `[]=`)
/// to the underlying list, while ensuring that any reads register a dependency
/// and any mutations automatically trigger reactive updates.
///
/// :::note
/// This mixin only works with signals that have a value type extending [List<E>].
/// :::
///
/// ### Example Usage
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// class MyListSignal extends Signal<List<int>>
///     with IterableSignalMixin<int, List<int>>, ListSignalMixin<int, List<int>> {
///   MyListSignal(super.internalValue);
/// }
///
/// void main() {
///   final numbers = MyListSignal([1, 2, 3]);
///
///   effect(() {
///     print('Elements: $numbers, Length: ${numbers.length}');
///   }); // Prints: "Elements: [1, 2, 3], Length: 3"
///
///   // Adding an element (automatically calls set() and triggers updates)
///   numbers.add(4); // Prints: "Elements: [1, 2, 3, 4], Length: 4"
///
///   // Modifying an element by index (triggers updates)
///   numbers[0] = 10; // Prints: "Elements: [10, 2, 3, 4], Length: 4"
/// }
/// ```
///
/// :::tip
/// Since mutations on `ListSignalMixin` notify listeners automatically, you do not
/// need to assign `numbers.value = ...` to force updates. Methods like `add`, `addAll`,
/// and operator `[]=` take care of notification.
/// :::
abstract mixin class ListSignalMixin<E, T extends List<E>>
    implements Signal<T>, List<E> {
  @override
  List<R> cast<R>() {
    return value.cast<R>();
  }

  @override
  set first(E val) {
    value.first = val;
    set(value, force: true);
  }

  @override
  E get last => value.last;

  @override
  set last(E val) {
    value.last = val;
    set(value, force: true);
  }

  @override
  set length(int value) {
    this.value.length = value;
    set(this.value, force: true);
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
    set(this.value, force: true);
  }

  @override
  void add(E value) {
    this.value.add(value);
    set(this.value, force: true);
  }

  @override
  void addAll(Iterable<E> iterable) {
    value.addAll(iterable);
    set(value, force: true);
  }

  @override
  Map<int, E> asMap() {
    return value.asMap();
  }

  @override
  void clear() {
    value.clear();
    set(value, force: true);
  }

  @override
  Iterable<R> expand<R>(Iterable<R> Function(E element) toElements) {
    return value.expand<R>(toElements);
  }

  @override
  void fillRange(int start, int end, [E? fillValue]) {
    value.fillRange(start, end, fillValue);
    set(value, force: true);
  }

  @override
  E firstWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.firstWhere(test, orElse: orElse);
  }

  @override
  R fold<R>(R initialValue, R Function(R previousValue, E element) combine) {
    return value.fold<R>(initialValue, combine);
  }

  @override
  Iterable<E> followedBy(Iterable<E> other) {
    return value.followedBy(other);
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
    set(value, force: true);
  }

  @override
  void insertAll(int index, Iterable<E> iterable) {
    value.insertAll(index, iterable);
    set(value, force: true);
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
  bool remove(Object? value) {
    final result = this.value.remove(value);
    if (result) {
      set(this.value, force: true);
    }
    return result;
  }

  @override
  E removeAt(int index) {
    final result = value.removeAt(index);
    set(value, force: true);
    return result;
  }

  @override
  E removeLast() {
    final result = value.removeLast();
    set(value, force: true);
    return result;
  }

  @override
  void removeRange(int start, int end) {
    value.removeRange(start, end);
    set(value, force: true);
  }

  @override
  void removeWhere(bool Function(E element) test) {
    value.removeWhere(test);
    set(value, force: true);
  }

  @override
  void replaceRange(int start, int end, Iterable<E> replacements) {
    value.replaceRange(start, end, replacements);
    set(value, force: true);
  }

  @override
  void retainWhere(bool Function(E element) test) {
    value.retainWhere(test);
    set(value, force: true);
  }

  @override
  Iterable<E> get reversed => value.reversed;

  @override
  void setAll(int index, Iterable<E> iterable) {
    value.setAll(index, iterable);
    set(value, force: true);
  }

  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    value.setRange(start, end, iterable, skipCount);
    set(value, force: true);
  }

  @override
  void shuffle([Random? random]) {
    value.shuffle(random);
    set(value, force: true);
  }

  @override
  void sort([int Function(E a, E b)? compare]) {
    value.sort(compare);
    set(value, force: true);
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
}
