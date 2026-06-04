import 'dart:collection';

import '../core/signals.dart';

/// A mixin that adds undo, redo, and state history replay capabilities to a [Signal].
///
/// [ChangeStackSignalMixin] keeps track of past states of a signal's value in a double-ended
/// queue, allowing you to easily go back to previous values using [undo] and go forward to subsequent
/// values using [redo]. You can inspect if undo or redo are available via [canUndo] and [canRedo].
///
/// You can also set a [limit] on the maximum size of the history stack, preventing memory leak
/// issues in long-running scenarios.
///
/// :::note
/// If you only need access to the initial and immediate previous values of a signal (without a full
/// history stack or undo/redo mechanisms), use the lightweight [TrackedSignalMixin] instead.
/// :::
///
/// ### Example Usage
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// class HistorySignal extends Signal<int> with ChangeStackSignalMixin<int> {
///   HistorySignal(super.internalValue);
/// }
///
/// void main() {
///   final counter = HistorySignal(0);
///   counter.limit = 5; // Cap history stack to 5 items
///
///   counter.value = 1;
///   counter.value = 2;
///   counter.value = 3;
///
///   print('Current: ${counter.value}'); // Prints: "Current: 3"
///   print('Can Undo: ${counter.canUndo}'); // Prints: "Can Undo: true"
///
///   // Undo last change
///   counter.undo();
///   print('Undone: ${counter.value}'); // Prints: "Undone: 2"
///
///   // Undo once more
///   counter.undo();
///   print('Undone: ${counter.value}'); // Prints: "Undone: 1"
///
///   // Redo the previous undo
///   counter.redo();
///   print('Redone: ${counter.value}'); // Prints: "Redone: 2"
/// }
/// ```
///
/// :::caution
/// This mixin only works with values that are immutable or are copied/cloned when changed.
/// If you mutate an object in-place directly without replacing the value using `set` or the `.value`
/// setter, the history queue will store references to the same mutated object, and undo/redo
/// will appear to do nothing.
/// :::
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
