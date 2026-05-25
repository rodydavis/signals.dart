part of 'value.dart';

/// A [Signal] that holds a [Set].
class SetSignal<E> extends Signal<Set<E>>
    with IterableSignalMixin<E, Set<E>>, SetSignalMixin<E, Set<E>>
    implements Set<E> {
  /// Creates a [SetSignal] with the given [value].
  SetSignal(
    super.value, {
    SetSignalOptions<E>? options,
    @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: SetSignalOptions(name: ...) instead')
    String? debugLabel,
  }) : super(
          options: options ??
              SetSignalOptions<E>(
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        );

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

/// Creates a [SetSignal] with the given [list] (Set).
SetSignal<T> setSignal<T>(
  Set<T> list, {
  SetSignalOptions<T>? options,
  @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: SetSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return SetSignal<T>(
    list,
    options: options ??
        SetSignalOptions<T>(
          autoDispose: autoDispose ?? false,
          name: debugLabel,
        ),
  );
}

/// Utility extension methods on [Set] to convert them to [SetSignal]s.
extension SignalSetUtils<T> on Set<T> {
  /// Convert an existing list to [SetSignal]
  SetSignal<T> toSignal({
    SetSignalOptions<T>? options,
    @Deprecated('Use options: SetSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: SetSignalOptions(name: ...) instead')
    String? debugLabel,
  }) {
    return SetSignal(
      this,
      options: options ??
          SetSignalOptions<T>(
            autoDispose: autoDispose ?? false,
            name: debugLabel,
          ),
    );
  }
}

/// Configuration options for a [SetSignal].
class SetSignalOptions<E> extends SignalOptions<Set<E>> {
  /// Creates a new [SetSignalOptions] instance.
  const SetSignalOptions({
    super.name,
    super.autoDispose,
    super.watched,
    super.unwatched,
    super.equality = const SignalDeepEquality(),
  });

  @override
  SetSignalOptions<E> copyWith({
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
    SignalEquality<Set<E>>? equality,
  }) {
    return SetSignalOptions<E>(
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
    return other is SetSignalOptions<E> &&
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
