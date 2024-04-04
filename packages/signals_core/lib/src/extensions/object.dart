import '../core/signals.dart';

/// Extension on Object to provide helpful methods for signals
extension SignalObjectUtils<T extends Object> on T {
  /// Convert an existing Object to [Signal<T>]
  Signal<T> toSignal({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return signal<T>(
      this,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }
}

/// Extension on nullable Object to provide helpful methods for signals
extension SignalOptionalObjectUtils<T extends Object> on T? {
  /// Convert an existing nullable Object to [Signal<T?>]
  Signal<T?> toSignal({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return signal<T?>(
      this,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }
}
