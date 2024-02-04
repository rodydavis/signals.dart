import 'dart:collection';

import '../core/signals.dart';

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
class ChangeStackSignal<T> extends ValueSignal<T> {
  ChangeStackSignal(
    super.value, {
    super.debugLabel,
    this.limit,
    super.autoDispose,
    super.equality,
  });

  /// Max values to keep in history
  final int? limit;
  final Queue<SignalChange<T>> _undo = ListQueue();
  final Queue<SignalChange<T>> _redo = ListQueue();

  /// List of changes in the history
  SignalChange<T>? get history => _undo.lastOrNull;

  /// List of changes in the redo stack
  SignalChange<T>? get redos => _redo.firstOrNull;

  /// Can redo the previous change
  bool get canRedo => _redo.isNotEmpty;

  /// Can undo the previous change
  bool get canUndo => _undo.isNotEmpty;

  /// Add new change and clear redo stack
  @override
  set value(T val) {
    final SignalChange<T> change = (
      previousValue: super.value,
      value: val,
    );
    _undo.addLast(change);
    _moveForward();
    forceUpdate(val);
  }

  /// Redo Previous Undo
  void redo() {
    if (!canRedo) return;
    final change = _redo.removeFirst();
    forceUpdate(change.value);
    _undo.addLast(change);
  }

  /// Undo Last Change
  void undo() {
    if (!canUndo) return;
    final change = _undo.removeLast();
    forceUpdate(change.previousValue);
    _redo.addFirst(change);
  }

  /// Clear the history for redo and undo
  void clear() {
    clearUndo();
    clearRedo();
  }

  /// Clear undo stack
  void clearUndo() {
    _undo.clear();
  }

  /// Clear redo stack
  void clearRedo() {
    _redo.clear();
  }

  void _moveForward() {
    _redo.clear();
    if (limit != null && _undo.length > limit! + 1) {
      _undo.removeFirst();
    }
  }
}

/// Signal change that contains a snapshot of the
/// previous value and next value
typedef SignalChange<T> = ({
  T previousValue,
  T value,
});

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
  SignalEquality<T>? equality,
}) {
  return ChangeStackSignal<T>(
    value,
    debugLabel: debugLabel,
    limit: limit,
    autoDispose: autoDispose,
    equality: equality,
  );
}
