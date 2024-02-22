part of 'signals.dart';

/// Signal that can be extended and used as a class
class ValueSignal<T> extends _SignalBase<T> implements Signal<T> {
  /// Signal that can be extended and used as a class
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
  T forceUpdate([T? val]) {
    if (equality != null && val != null) {
      final same = equality!(value, val);
      if (same) return value;
    }
    final newValue = val ?? value;
    set(newValue, force: true);
    return newValue;
  }
}

/// Create a `value` signal
ValueSignal<T> valueSignal<T>(
  T value, {
  String? debugLabel,
  SignalEquality<T>? equality,
  bool autoDispose = false,
}) {
  return ValueSignal<T>(
    value,
    debugLabel: debugLabel,
    equality: equality,
    autoDispose: autoDispose,
  );
}
