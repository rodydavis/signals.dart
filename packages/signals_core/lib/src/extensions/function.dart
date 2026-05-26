import '../core/signals.dart';

/// Utility extension on a getter function `T Function()` to instantly convert it into a [Computed] signal.
extension SignalFunctionExtensions<T extends Object> on T Function() {
  /// Return a cached, derived [Computed<T>] signal from this getter function.
  ///
  /// ```dart
  /// import 'package:signals_core/signals_core.dart';
  ///
  /// final count = signal(0);
  /// final doubleCount = (() => count.value * 2).$;
  ///
  /// print(doubleCount.value); // 0
  /// count.value = 5;
  /// print(doubleCount.value); // 10
  /// ```
  Computed<T> get $ => computed<T>(this);
}
