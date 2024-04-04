import '../core/signals.dart';

/// A callback function that can be used to update a signal.
typedef SignalsCallbackFunction<T> = Function(Function(T value));

/// A callback function that can be used to update a signal.
extension SignalsCallbackFunctionUtils<T> on SignalsCallbackFunction<T> {
  /// Convert a callback function to a signal
  ///
  /// ```dart
  /// final element = document.querySelector('#id')!;
  /// final s = element.addEventListener.toSignal();
  /// ```
  ReadonlySignal<T> toSignal(
    T initialValue, {
    bool autoDispose = false,
    String? debugLabel,
  }) {
    final s = signal<T>(
      initialValue,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
    this(s.set);
    return s;
  }
}
