part of 'value.dart';

/// A [Signal] that holds a [List].
class ListSignal<E> extends Signal<List<E>>
    with IterableSignalMixin<E, List<E>>, ListSignalMixin<E, List<E>>
    implements List<E> {
  /// Creates a [ListSignal] with the given [value].
  ListSignal(
    super.value, {
    ListSignalOptions<E>? options,
    @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: ListSignalOptions(name: ...) instead')
    String? debugLabel,
  }) : super(
          options: options ??
              ListSignalOptions<E>(
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        );

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
  ListSignalOptions<T>? options,
  @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: ListSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return ListSignal<T>(
    list,
    options: options ??
        ListSignalOptions<T>(
          autoDispose: autoDispose ?? false,
          name: debugLabel,
        ),
  );
}

/// Utility extension methods on [List] to convert them to [ListSignal]s.
extension SignalListUtils<T> on List<T> {
  /// Convert an existing list to [ListSignal]
  ListSignal<T> toSignal({
    ListSignalOptions<T>? options,
    @Deprecated('Use options: ListSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: ListSignalOptions(name: ...) instead')
    String? debugLabel,
  }) {
    return ListSignal<T>(
      this,
      options: options ??
          ListSignalOptions<T>(
            autoDispose: autoDispose ?? false,
            name: debugLabel,
          ),
    );
  }
}

/// Configuration options for a [ListSignal].
class ListSignalOptions<E> extends SignalOptions<List<E>> {
  /// Creates a new [ListSignalOptions] instance.
  const ListSignalOptions({
    super.name,
    super.autoDispose,
    super.watched,
    super.unwatched,
  });

  @override
  ListSignalOptions<E> copyWith({
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
  }) {
    return ListSignalOptions<E>(
      name: name ?? this.name,
      autoDispose: autoDispose ?? this.autoDispose,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ListSignalOptions<E> &&
        other.name == name &&
        other.autoDispose == autoDispose &&
        other.watched == watched &&
        other.unwatched == unwatched;
  }

  @override
  int get hashCode => Object.hash(name, autoDispose, watched, unwatched);
}
