part of 'value.dart';

/// Options for [ChangeStackSignal]
class ChangeStackSignalOptions<T> extends SignalOptions<T> {
  /// The limit of the history
  final int? limit;

  /// Options for [ChangeStackSignal]
  const ChangeStackSignalOptions({
    super.name,
    super.autoDispose,
    super.equalityCheck,
    super.watched,
    super.unwatched,
    this.limit,
  });
}

/// Change stack signal that can be used to call undo/redo on a value.
///
/// ```dart
/// final s = ChangeStackSignal(0, options: ChangeStackSignalOptions(limit: 5));
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
  /// final s = ChangeStackSignal(0, options: ChangeStackSignalOptions(limit: 5));
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
    ChangeStackSignalOptions<T>? options,
  }) : super(options: options) {
    limit = options?.limit;
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
  ChangeStackSignalOptions<T>? options,
}) {
  return ChangeStackSignal<T>(
    value,
    options: options,
  );
}
