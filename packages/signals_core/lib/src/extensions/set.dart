// ignore_for_file: public_member_api_docs
import '../core/signals.dart';

/// Helper extensions for [ReadonlySignal<Set<E>>], providing delegators to compute set operations reactively.
///
/// ```dart
/// import 'package:signals_core/signals_core.dart';
///
/// final setA = {1, 2, 3}.$;
/// final setB = {3, 4, 5}.$;
/// final diff = computed(() => setA.difference(setB.value)); // {1, 2}
/// ```
extension ReadonlySetSignalExtension<E> on ReadonlySignal<Set<E>> {
  Set<R> cast<R>() {
    return value.cast<R>();
  }

  bool containsAll(Iterable<Object?> other) {
    return value.containsAll(other);
  }

  Set<E> difference(Set<Object?> other) {
    return value.difference(other);
  }

  Set<E> intersection(Set<Object?> other) {
    return value.intersection(other);
  }

  E? lookup(Object? object) {
    return value.lookup(object);
  }

  Set<E> union(Set<E> other) {
    return value.union(other);
  }
}

/// Helper extensions for [Signal<Set<E>>] to perform mutation operations that automatically notify downstreams.
///
/// Under the hood, these methods mutate the underlying set and call `set(..., force: true)` to trigger all listeners and computations.
///
/// ```dart
/// import 'package:signals_core/signals_core.dart';
///
/// final tags = <String>{}.$;
///
/// effect(() {
///   print('Tags: ${tags.value}');
/// });
///
/// tags.add('dart'); // Automatically prints: Tags: {dart}
/// tags.addAll(['flutter', 'signals']); // Automatically prints: Tags: {dart, flutter, signals}
/// ```
extension SetSignalExtension<E> on Signal<Set<E>> {
  bool add(E value) {
    final list = this.value;
    final result = list.add(value);
    set(list, force: true);
    return result;
  }

  void addAll(Iterable<E> elements) {
    final list = value;
    list.addAll(elements);
    set(list, force: true);
  }

  void clear() => set(<E>{}, force: true);

  bool remove(Object? value) {
    final list = this.value;
    final result = list.remove(value);
    set(list, force: true);
    return result;
  }

  void removeAll(Iterable<Object?> elements) {
    final list = value;
    list.removeAll(elements);
    set(list, force: true);
  }

  void removeWhere(bool Function(E element) test) {
    final list = value;
    list.removeWhere(test);
    set(list, force: true);
  }

  void retainAll(Iterable<Object?> elements) {
    final list = value;
    list.retainAll(elements);
    set(list, force: true);
  }

  void retainWhere(bool Function(E element) test) {
    final list = value;
    list.retainWhere(test);
    set(list, force: true);
  }
}

/// Utility extension on [Set] to easily lift a set into a reactive [Signal].
extension SignalSetExtensions<E> on Set<E> {
  /// Lift a primitive [Set] into a reactive [Signal<Set<E>>].
  ///
  /// ```dart
  /// import 'package:signals_core/signals_core.dart';
  ///
  /// final tags = {'sports', 'news'}.$;
  /// print(tags.value); // {'sports', 'news'}
  /// ```
  Signal<Set<E>> get $ => signal<Set<E>>(this);
}
