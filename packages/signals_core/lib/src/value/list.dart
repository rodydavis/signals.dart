part of 'value.dart';

/// A [Signal] that holds a [List].
class ListSignal<E> extends Signal<List<E>>
    with IterableSignalMixin<E, List<E>>, ListSignalMixin<E, List<E>>
    implements List<E> {
  /// Creates a [ListSignal] with the given [value].
  ListSignal(
    super.value, {
    super.options,
  });

  /// Inject: Update current signal value with iterable
  ListSignal<E> operator <<(Iterable<E> other) {
    value.addAll(other);
    set(value, force: true);
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
  bool operator ==(Object other) {
    return other is ListSignal<E> && value == other.value;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      globalId.hashCode,
      value.hashCode,
      for (final item in value) item.hashCode,
    ]);
  }
}

/// Create an [ListSignal] from [List]
ListSignal<T> listSignal<T>(
  List<T> list, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return ListSignal<T>(
    list,
    options: SignalOptions<List<T>>(
      name: debugLabel,
      autoDispose: autoDispose,
    ),
  );
}

/// Extension on future to provide helpful methods for signals
extension SignalListUtils<T> on List<T> {
  /// Convert an existing list to [ListSignal]
  ListSignal<T> toSignal({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return ListSignal(
      this,
      options: SignalOptions<List<T>>(
        name: debugLabel,
        autoDispose: autoDispose,
      ),
    );
  }
}
