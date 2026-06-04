// ignore_for_file: public_member_api_docs
import '../core/signals.dart';

/// A mixin that adds reactive `Iterable` methods and properties to a [Signal]
/// holding an [Iterable] value.
///
/// This mixin delegates all standard [Iterable] operations (such as `length`,
/// `first`, `last`, `map`, `where`, and `any`) directly to the underlying
/// collection, while ensuring that any read operations register a reactive
/// dependency on the signal.
///
/// :::note
/// This mixin only works with signals that have a value type extending [Iterable<E>].
/// :::
///
/// ### Example Usage
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// class MyIterableSignal extends Signal<Iterable<int>>
///     with IterableSignalMixin<int, Iterable<int>> {
///   MyIterableSignal(super.internalValue);
/// }
///
/// void main() {
///   final numbers = MyIterableSignal([1, 2, 3]);
///
///   // Set up a reactive effect that prints the list size and first element
///   effect(() {
///     print('Size: ${numbers.length}, First: ${numbers.first}');
///   }); // Prints: "Size: 3, First: 1"
///
///   // Update the signal value (triggers the effect)
///   numbers.value = [10, 20, 30, 40]; // Prints: "Size: 4, First: 10"
/// }
/// ```
///
/// :::caution
/// Direct mutation of elements inside the iterable will NOT notify listeners
/// unless you reassign the value or use a specialized signal class like `ListSignal`,
/// `SetSignal`, or `MapSignal` which automatically trigger updates when modified.
/// :::
abstract mixin class IterableSignalMixin<E, T extends Iterable<E>>
    implements Signal<T>, Iterable<E> {
  @override
  bool any(bool Function(E element) test) {
    return value.any(test);
  }

  @override
  Iterable<R> cast<R>() {
    return value.cast<R>();
  }

  @override
  bool contains(Object? value) {
    return this.value.contains(value);
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
  Iterable<R> expand<R>(Iterable<R> Function(E element) toElements) {
    return value.expand(toElements);
  }

  @override
  E get first => value.first;

  @override
  E firstWhere(bool Function(E element) test, {E Function()? orElse}) {
    return value.firstWhere(test, orElse: orElse);
  }

  @override
  R fold<R>(R initialValue, R Function(R previousValue, E element) combine) {
    return value.fold(initialValue, combine);
  }

  @override
  Iterable<E> followedBy(Iterable<E> other) {
    return value.followedBy(other);
  }

  @override
  void forEach(void Function(E element) action) {
    value.forEach(action);
    set(value, force: true);
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

  @override
  Iterable<R> map<R>(R Function(E e) toElement) {
    return value.map<R>(toElement);
  }

  @override
  E reduce(E Function(E value, E element) combine) {
    return value.reduce(combine);
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
  Iterable<E> where(bool Function(E element) test) {
    return value.where(test);
  }

  @override
  Iterable<R> whereType<R>() {
    return value.whereType<R>();
  }
}
