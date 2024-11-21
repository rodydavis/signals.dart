import '../core/signals.dart';

/// Connivent methods for signal values
extension OptionalSignalObjectUtils<T extends Object> on T {
  /// Convert an existing Object to [Signal]
  Signal<T> get $ => signal<T>(this);
}

/// Extension on nullable Object to provide helpful methods for signals
extension SignalOptionalObjectUtils<T extends Object> on T? {
  /// Convert an existing Object to [Signal]
  Signal<T?> get $ => signal<T?>(this);
}
