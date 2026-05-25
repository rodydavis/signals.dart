part of 'signals.dart';

/// Global callback when any signal is read.
void Function(signals.ReadonlySignal)? onSignalRead;

/// Read only signals can just retrieve a value but not update or cause mutations
abstract class ReadonlySignal<T> = signals.ReadonlySignal<T>
    with ReadonlySignalMixin<T>, SignalsAutoDisposeMixin<T>;

/// Readonly signal mixin for adding addition helper methods
mixin ReadonlySignalMixin<T> on signals.ReadonlySignal<T> {
  /// Check if a signal value is set (does not subscribe)
  bool get isInitialized;

  /// Internal hook for after a signal is created
  @internal
  void afterCreate(T val);

  /// Internal hook for after a signal is updated
  @internal
  void beforeUpdate(T val);

  /// Debug label for Debug Mode
  String? get debugLabel;

  @override
  T get value {
    onSignalRead?.call(this);
    return super.value;
  }
}

/// Create a new plain readonly signal
ReadonlySignal<T> readonly<T>(
  /// The initial value for the signal
  T value,
) {
  return signal<T>(value);
}
