part of 'value.dart';

/// A [Signal] that holds a [Iterable].
class IterableSignal<E> extends Signal<Iterable<E>>
    with IterableSignalMixin<E, Iterable<E>>
    implements Iterable<E> {
  /// Creates a [IterableSignal] with the given [value].
  /// Creates a [IterableSignal] with the given [value].
  IterableSignal(
    super.value, {
    super.options,
  });

  @override
  bool operator ==(Object other) {
    return other is IterableSignal<E> && value == other.value;
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

/// Create an [IterableSignal] from [Iterable]
IterableSignal<T> iterableSignal<T>(
  Iterable<T> iterable, {
  SignalOptions<Iterable<T>>? options,
}) {
  return IterableSignal<T>(
    iterable,
    options: options,
  );
}

/// Extension on future to provide helpful methods for signals
extension SignalIterableUtils<T> on Iterable<T> {
  /// Convert an existing list to [IterableSignal]
  IterableSignal<T> toSignal({
    SignalOptions<Iterable<T>>? options,
  }) {
    return IterableSignal<T>(
      this,
      options: options,
    );
  }
}
