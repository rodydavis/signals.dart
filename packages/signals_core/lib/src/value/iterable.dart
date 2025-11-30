part of 'value.dart';

/// A [Signal] that holds a [Iterable].
class IterableSignal<E> extends Signal<Iterable<E>>
    with IterableSignalMixin<E, Iterable<E>>
    implements Iterable<E> {
  /// Creates a [IterableSignal] with the given [value].
  IterableSignal(
    super.value, {
    super.debugLabel,
    super.autoDispose,
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
  String? debugLabel,
  bool autoDispose = false,
}) {
  return IterableSignal<T>(
    iterable,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}

/// Extension on future to provide helpful methods for signals
extension SignalIterableUtils<T> on Iterable<T> {
  /// Convert an existing list to [IterableSignal]
  IterableSignal<T> toSignal({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return IterableSignal<T>(
      this,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }
}
