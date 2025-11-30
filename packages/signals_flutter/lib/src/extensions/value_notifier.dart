import 'package:flutter/foundation.dart';

import '../../signals_core.dart';

/// Extension on [ValueNotifier] to provide helpful methods for signals
extension SignalValueNotifierUtils<T> on ValueNotifier<T> {
  /// {@template value}
  /// ## SignalValueNotifier
  ///
  /// To create a `ValueNotifier` that is also a `Signal`:
  ///
  /// ```dart
  /// final signal = SignalValueNotifier<int>(10);
  /// // or
  /// final signal = signalValueNotifier<int>(10);
  ///
  /// expect(signal.value, 10);
  /// expect(signal is Signal<int>, true);
  /// expect(signal is ValueNotifier<int>, true);
  /// ```
  ///
  /// > Setting the value on the signal will update the notifier and vice versa.
  ///
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
  Signal<T> toSignal({
    SignalOptions<T>? options,
  }) {
    bool? self;
    final target = signal<T>(
      value,
      options: options,
    );

    void updater() {
      if (self == false) {
        // Update from signal
      } else {
        // Normal flow
        self = true;
        target.value = value;
        self = null;
      }
    }

    addListener(updater);
    target.onDispose(() => removeListener(updater));

    target.subscribe((val) {
      if (self == true) {
        // Update from value notifier
      } else {
        // Normal flow
        self = false;
        value = val;
        self = null;
      }
    });

    return target;
  }
}

/// {@template value}
/// ## SignalValueNotifier
///
/// To create a `ValueNotifier` that is also a `Signal`:
///
/// ```dart
/// final signal = SignalValueNotifier<int>(10);
/// // or
/// final signal = signalValueNotifier<int>(10);
///
/// expect(signal.value, 10);
/// expect(signal is Signal<int>, true);
/// expect(signal is ValueNotifier<int>, true);
/// ```
///
/// > Setting the value on the signal will update the notifier and vice versa.
///
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
Signal<T> valueNotifierToSignal<T>(
  ValueNotifier<T> valueNotifier, {
  SignalOptions<T>? options,
}) {
  return valueNotifier.toSignal(
    options: options,
  );
}
