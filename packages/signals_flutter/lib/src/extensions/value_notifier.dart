import 'package:flutter/foundation.dart';

import '../../signals_core.dart';

/// Extension on [ValueNotifier] to seamlessly bridge standard Flutter mutable values to reactive signals.
extension SignalValueNotifierUtils<T> on ValueNotifier<T> {
  /// {@template value}
  /// ## Bi-directional Signal and ValueNotifier Interoperability
  ///
  /// Converted [ValueNotifier] objects become mutable [Signal] instances. Setting the value
  /// on the signal or the notifier automatically propagates the update to the other.
  /// 
  /// The subscription is fully memory-safe and automatically unsubscribed when the signal
  /// is disposed.
  ///
  /// ### Example: Converting a ValueNotifier to a Signal
  /// ```dart
  /// final notifier = ValueNotifier(10);
  /// final signal = notifier.toSignal();
  /// 
  /// signal.value = 20;
  /// print(notifier.value); // 20
  /// 
  /// notifier.value = 30;
  /// print(signal.value); // 30
  /// ```
  ///
  /// ### Example: Converting a Signal to a ValueNotifier
  /// To bridge back to a standard [ValueNotifier] for Flutter compatibility:
  /// ```dart
  /// final signal = Signal(10);
  /// final notifier = signal.toValueNotifier();
  /// ```
  /// 
  /// @link https://dartsignals.dev/flutter/value-notifier
  /// {@endtemplate}
  Signal<T> toSignal({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    bool? self;
    final target = signal<T>(
      value,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
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

/// A global helper function to convert a Flutter [ValueNotifier] to a mutable [Signal].
/// 
/// Updates to either the notifier or the returned signal will automatically update the other.
/// This helper is a functional equivalent of the `toSignal()` extension method.
/// 
/// ### Example
/// ```dart
/// final textControllerValue = ValueNotifier('');
/// final textSignal = valueNotifierToSignal(textControllerValue);
/// ```
Signal<T> valueNotifierToSignal<T>(
  ValueNotifier<T> valueNotifier, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return valueNotifier.toSignal(
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}
