part of 'signals.dart';

/// Signal that can be extended and used as a class
class ValueSignal<T> extends _Signal<T> implements Signal<T> {
  ValueSignal(
    super.value, {
    super.debugLabel,
    super.equality,
    super.autoDispose,
  });

  /// Should only be called to update the value of a signal if checks for equality
  /// have already been made.
  ///
  /// This is primarily used by the `ValueSignal` class to update the value
  /// since the reference is always the same.
  void forceUpdate([T? val]) {
    if (equality != null && val != null) {
      final same = equality!(value, val);
      if (same) return;
    }
    set(val ?? value, force: true);
  }
}

/// Create a `value` signal
ValueSignal<T> valueSignal<T>(
  T value, {
  String? debugLabel,
  SignalEquality<T>? equality,
}) {
  return ValueSignal<T>(
    value,
    debugLabel: debugLabel,
    equality: equality,
  );
}
