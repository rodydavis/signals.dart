import '../core/signals.dart';
import 'iterable.dart';

/// A [Signal] that holds a [Set].
class SetSignal<E> extends IterableSignal<E> implements Set<E> {
  /// Creates a [SetSignal] with the given [value].
  SetSignal(
    super.value, {
    super.debugLabel,
    super.autoDispose,
  });

  @override
  Set<E> get value => super.value as Set<E>;

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
  void clear() => set({}, force: true);

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

  /// Inject: Update current signal value with iterable
  SetSignal<E> operator <<(Set<E> other) {
    final list = value;
    list.addAll(other);
    set(list, force: true);
    return SetSignal(list);
  }

  /// Fork: create a new signal with value is the concatenation of source signal and iterable parameter
  SetSignal<E> operator &(Set<E> other) {
    final list = value;
    final rs = Set<E>.from(list)..addAll(other);
    return SetSignal(rs);
  }

  /// Pipe: create a new signal by sending value from source to other
  SetSignal<E> operator |(Signal<Iterable<E>> other) {
    final list = value;
    final rs = Set<E>.from(list)..addAll(other.peek());
    return SetSignal(rs);
  }

  @override
  E? lookup(Object? object) {
    return value.lookup(object);
  }

  @override
  bool remove(Object? value) {
    final list = this.value;
    final result = list.remove(value);
    set(list, force: true);
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

/// Create an [SetSignal] from [Set]
SetSignal<T> setSignal<T>(
  Set<T> list, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return SetSignal<T>(
    list,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}

/// Extension on future to provide helpful methods for signals
extension SignalSetUtils<T> on Set<T> {
  /// Convert an existing list to [SetSignal]
  SetSignal<T> toSignal({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return SetSignal(
      this,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }
}
