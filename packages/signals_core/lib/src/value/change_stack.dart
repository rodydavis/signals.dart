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
    super.debugLabel,
    super.autoDispose,
  }) {
    this.limit = limit;
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
  String? debugLabel,
  int? limit,
  bool autoDispose = false,
}) {
  return ChangeStackSignal<T>(
    value,
    debugLabel: debugLabel,
    limit: limit,
    autoDispose: autoDispose,
  );
}
