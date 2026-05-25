part of 'value.dart';

/// A [Signal] that holds a [Iterable].
class IterableSignal<E> extends Signal<Iterable<E>>
    with IterableSignalMixin<E, Iterable<E>>
    implements Iterable<E> {
  /// Creates a [IterableSignal] with the given [value].
  IterableSignal(
    super.value, {
    IterableSignalOptions<E>? options,
    @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: IterableSignalOptions(name: ...) instead')
    String? debugLabel,
  }) : super(
          options: options ??
              IterableSignalOptions<E>(
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        );

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

/// Creates an [IterableSignal] with the given [iterable].
IterableSignal<T> iterableSignal<T>(
  Iterable<T> iterable, {
  IterableSignalOptions<T>? options,
  @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: IterableSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return IterableSignal<T>(
    iterable,
    options: options ??
        IterableSignalOptions<T>(
          autoDispose: autoDispose ?? false,
          name: debugLabel,
        ),
  );
}

/// Utility extension methods on [Iterable] to convert them to [IterableSignal]s.
extension SignalIterableUtils<T> on Iterable<T> {
  /// Convert an existing list to [IterableSignal]
  IterableSignal<T> toSignal({
    IterableSignalOptions<T>? options,
    @Deprecated('Use options: IterableSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: IterableSignalOptions(name: ...) instead')
    String? debugLabel,
  }) {
    return IterableSignal<T>(
      this,
      options: options ??
          IterableSignalOptions<T>(
            autoDispose: autoDispose ?? false,
            name: debugLabel,
          ),
    );
  }
}

/// Configuration options for a [IterableSignal].
class IterableSignalOptions<E> extends SignalOptions<Iterable<E>> {
  /// Creates a new [IterableSignalOptions] instance.
  const IterableSignalOptions({
    super.name,
    super.autoDispose,
    super.watched,
    super.unwatched,
    super.equality = const SignalDeepEquality(),
  });

  @override
  IterableSignalOptions<E> copyWith({
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
    SignalEquality<Iterable<E>>? equality,
  }) {
    return IterableSignalOptions<E>(
      name: name ?? this.name,
      autoDispose: autoDispose ?? this.autoDispose,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
      equality: equality ?? equalityCheck,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IterableSignalOptions<E> &&
        other.name == name &&
        other.autoDispose == autoDispose &&
        other.watched == watched &&
        other.unwatched == unwatched &&
        other.equalityCheck == equalityCheck;
  }

  @override
  int get hashCode =>
      Object.hash(name, autoDispose, watched, unwatched, equalityCheck);
}
