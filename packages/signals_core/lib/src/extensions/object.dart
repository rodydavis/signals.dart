import '../core/signals.dart';

/// Extension on Object to provide helpful methods for signals
extension SignalObjectUtils<T extends Object> on T {
  /// Convert an existing Object to [Signal<T>]
  @Deprecated('use [asSignal] instead to prevent unintended casts')
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

  /// Convert an existing Object to [Signal<T>]
  Signal<T> asSignal({
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

/// Connivent methods for signal values
extension OptionalSignalObjectUtils<T extends Object> on T {
  /// Convert an existing Object to [Signal<T>]
  Signal<T> get $ => signal<T>(this);
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
