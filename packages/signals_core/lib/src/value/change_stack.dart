part of 'value.dart';

/// Change stack signal that can be used to call undo/redo on a value.
///
/// ```dart
/// final s = ChangeStackSignal(0, limit: 5);
/// s.value = 1;
/// s.value = 2;
/// s.value = 3;
/// print(s.value); // 3
/// s.undo();
/// print(s.value); // 2
/// s.redo();
/// print(s.value); // 3
/// ```
class ChangeStackSignal<T> extends Signal<T> with ChangeStackSignalMixin<T> {
  /// Change stack signal that can be used to call undo/redo on a value.
  ///
  /// ```dart
  /// final s = ChangeStackSignal(0, limit: 5);
  /// s.value = 1;
  /// s.value = 2;
  /// s.value = 3;
  /// print(s.value); // 3
  /// s.undo();
  /// print(s.value); // 2
  /// s.redo();
  /// print(s.value); // 3
  /// ```
  ChangeStackSignal(
    super.value, {
    int? limit,
    ChangeSignalOptions<T>? options,
    @Deprecated('Use options: ChangeSignalOptions(autoDispose: ...) instead')
    bool? autoDispose,
    @Deprecated('Use options: ChangeSignalOptions(name: ...) instead')
    String? debugLabel,
  }) : super(
          options: options ??
              ChangeSignalOptions<T>(
                limit: limit,
                autoDispose: autoDispose ?? false,
                name: debugLabel,
              ),
        ) {
    this.limit = limit ?? options?.limit;
  }
}

/// Change stack signal that can be used to call undo/redo on a value.
///
/// ```dart
/// final s = changeStack(0);
/// s.value = 1;
/// s.value = 2;
/// s.value = 3;
/// print(s.value); // 3
/// s.undo();
/// print(s.value); // 2
/// s.redo();
/// print(s.value); // 3
/// ```
ChangeStackSignal<T> changeStack<T>(
  T value, {
  int? limit,
  ChangeSignalOptions<T>? options,
  @Deprecated('Use options: ChangeSignalOptions(autoDispose: ...) instead')
  bool? autoDispose,
  @Deprecated('Use options: ChangeSignalOptions(name: ...) instead')
  String? debugLabel,
}) {
  return ChangeStackSignal<T>(
    value,
    limit: limit,
    options: options ??
        ChangeSignalOptions<T>(
          limit: limit,
          autoDispose: autoDispose ?? false,
          name: debugLabel,
        ),
  );
}

/// Configuration options for a [ChangeStackSignal].
typedef ChangeStackSignalOptions<T> = ChangeSignalOptions<T>;

/// Configuration options for a [ChangeStackSignal].
class ChangeSignalOptions<T> extends SignalOptions<T> {
  /// The limit of changes to keep in the undo/redo stack.
  final int? limit;

  /// Creates a new [ChangeSignalOptions] instance.
  const ChangeSignalOptions({
    this.limit,
    super.name,
    super.autoDispose,
    super.watched,
    super.unwatched,
  });

  @override
  ChangeSignalOptions<T> copyWith({
    int? limit,
    String? name,
    bool? autoDispose,
    void Function()? watched,
    void Function()? unwatched,
  }) {
    return ChangeSignalOptions<T>(
      limit: limit ?? this.limit,
      name: name ?? this.name,
      autoDispose: autoDispose ?? this.autoDispose,
      watched: watched ?? this.watched,
      unwatched: unwatched ?? this.unwatched,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChangeSignalOptions<T> &&
        other.limit == limit &&
        other.name == name &&
        other.autoDispose == autoDispose &&
        other.watched == watched &&
        other.unwatched == unwatched;
  }

  @override
  int get hashCode => Object.hash(limit, name, autoDispose, watched, unwatched);
}
