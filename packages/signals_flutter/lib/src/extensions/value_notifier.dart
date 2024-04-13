import 'package:flutter/foundation.dart';

import '../core/signal_value_listenable.dart';

/// Extension on [ValueNotifier] to provide helpful methods for signals
extension SignalValueNotifierUtils<T> on ValueNotifier<T> {
  /// {@template value}
  /// ## Signal from ValueNotifier
  ///
  /// To create a mutable signal from a `ValueNotifier`, use the `toSignal` extension:
  ///
  /// ```dart
  /// final notifier = ValueNotifier(10);
  /// final signal = notifier.toSignal();
  /// ```
  ///
  /// > Setting the value on the signal or notifier will update the other.
  ///
  /// ## ValueNotifier from Signal
  ///
  /// To create a `ValueNotifier` from a mutable signal, use the `toValueNotifier` extension:
  ///
  /// ```dart
  /// final signal = Signal(10);
  /// final notifier = signal.toValueNotifier();
  /// ```
  ///
  /// > Setting the value on the signal or notifier will update the other.
  /// @link https://dartsignals.dev/flutter/value-notifier
  /// {@endtemplate}
  SignalValueNotifier<T> toSignal({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return SignalValueNotifier<T>.fromValueNotifier(this);
  }
}

/// {@template value}
/// ## Signal from ValueNotifier
///
/// To create a mutable signal from a `ValueNotifier`, use the `toSignal` extension:
///
/// ```dart
/// final notifier = ValueNotifier(10);
/// final signal = notifier.toSignal();
/// ```
///
/// > Setting the value on the signal or notifier will update the other.
///
/// ## ValueNotifier from Signal
///
/// To create a `ValueNotifier` from a mutable signal, use the `toValueNotifier` extension:
///
/// ```dart
/// final signal = Signal(10);
/// final notifier = signal.toValueNotifier();
/// ```
///
/// > Setting the value on the signal or notifier will update the other.
/// @link https://dartsignals.dev/flutter/value-notifier
/// {@endtemplate}
SignalValueNotifier<T> valueNotifierToSignal<T>(
  ValueNotifier<T> valueNotifier, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return SignalValueNotifier<T>.fromValueNotifier(
    valueNotifier,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}
