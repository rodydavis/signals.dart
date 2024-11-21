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
mixin ChangeStackSignalMixin<T> on Signal<T> {
  /// Max values to keep in history
  int? limit;

  final Queue<SignalChange<T>> _undo = ListQueue();
  final Queue<SignalChange<T>> _redo = ListQueue();

  /// List of changes in the history
  Iterable<SignalChange<T>> get history => _undo;

  /// List of changes in the redo stack
  Iterable<SignalChange<T>> get redos => _redo;

  /// Can redo the previous change
  bool get canRedo => _redo.isNotEmpty;

  /// Can undo the previous change
  bool get canUndo => _undo.isNotEmpty;

  @override
  bool set(
    T val, {
    bool force = false,
  }) {
    final prev = super.value;
    final updated = super.set(val, force: force);
    if (!updated) return false;
    _undo.addLast((previousValue: prev, value: val));
    _redo.clear();
    if (limit != null && _undo.length > limit!) {
      _undo.removeFirst();
    }
    return true;
  }

  /// Redo Previous Undo
  void redo() {
    if (!canRedo) return;
    final change = _redo.removeFirst();
    super.set(change.value, force: true);
    _undo.addLast(change);
  }

  /// Undo Last Change
  void undo() {
    if (!canUndo) return;
    final change = _undo.removeLast();
    super.set(change.previousValue, force: true);
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
}

/// Signal change that contains a snapshot of the
/// previous value and next value
typedef SignalChange<T> = ({
  T previousValue,
  T value,
});
