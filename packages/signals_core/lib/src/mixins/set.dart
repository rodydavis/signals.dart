// ignore_for_file: public_member_api_docs
import '../core/signals.dart';

/// A mixin that adds reactive `Set` methods and operations to a [Signal]
/// holding a [Set] value.
///
/// This mixin delegates all standard [Set] operations (such as mutations like `add`,
/// `remove`, `addAll`, `removeAll`, `retainAll`, and `clear`) to the underlying set,
/// while ensuring that any reads register a dependency and any mutations
/// automatically trigger reactive updates.
///
/// :::note
/// This mixin only works with signals that have a value type extending [Set<E>].
/// :::
///
/// ### Example Usage
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// class MySetSignal extends Signal<Set<int>>
///     with IterableSignalMixin<int, Set<int>>, SetSignalMixin<int, Set<int>> {
///   MySetSignal(super.internalValue);
/// }
///
/// void main() {
///   final numbers = MySetSignal({1, 2, 3});
///
///   effect(() {
///     print('Elements: $numbers, Length: ${numbers.length}');
///   }); // Prints: "Elements: {1, 2, 3}, Length: 3"
///
///   // Adding an element (automatically calls set() and triggers updates)
///   numbers.add(4); // Prints: "Elements: {1, 2, 3, 4}, Length: 4"
///
///   // Removing an element (triggers updates)
///   numbers.remove(1); // Prints: "Elements: {2, 3, 4}, Length: 3"
/// }
/// ```
///
/// :::tip
/// Since mutations on `SetSignalMixin` notify listeners automatically, you do not
/// need to assign `numbers.value = ...` to force updates. Methods like `add`, `addAll`,
/// and `remove` take care of notification.
/// :::
abstract mixin class SetSignalMixin<E, T extends Set<E>>
    implements Signal<T>, Set<E> {
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
    if (result) {
      set(list, force: true);
    }
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
