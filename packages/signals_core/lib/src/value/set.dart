part of 'value.dart';

/// A [Signal] that holds a [Set].
class SetSignal<E> extends Signal<Set<E>>
    with IterableSignalMixin<E, Set<E>>, SetSignalMixin<E, Set<E>>
    implements Set<E> {
  /// Creates a [SetSignal] with the given [value].
  SetSignal(
    super.value, {
    super.options,
  });

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
  bool operator ==(Object other) {
    return other is SetSignal<E> && value == other.value;
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

/// Create an [SetSignal] from [Set]
SetSignal<T> setSignal<T>(
  Set<T> set, {
  String? debugLabel,
  bool autoDispose = false,
  SignalOptions<Set<T>>? options,
}) {
  return SetSignal<T>(
    set,
    options: options ??
        SignalOptions<Set<T>>(
          name: debugLabel,
          autoDispose: autoDispose,
        ),
  );
}

/// Extension on future to provide helpful methods for signals
extension SignalSetUtils<T> on Set<T> {
  /// Convert an existing list to [SetSignal]
  SetSignal<T> toSignal({
    String? debugLabel,
    bool autoDispose = false,
    SignalOptions<Set<T>>? options,
  }) {
    return SetSignal(
      this,
      options: options ??
          SignalOptions<Set<T>>(
            name: debugLabel,
            autoDispose: autoDispose,
          ),
    );
  }
}
