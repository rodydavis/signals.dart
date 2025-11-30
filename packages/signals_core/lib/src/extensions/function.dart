import '../core/signals.dart';

/// Extensions for [T Function()]
extension SignalFunctionExtensions<T extends Object> on T Function() {
  /// Return a computed from a Function value
  Computed<T> get $ => computed<T>(this);
}
