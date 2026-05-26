import 'package:flutter/foundation.dart';

import '../../signals_core.dart';

/// Extension on [ValueListenable] to seamlessly bridge standard Flutter values to reactive signals.
extension SignalValueListenableUtils<T> on ValueListenable<T> {
  /// {@template value}
  /// ## ReadonlySignal from ValueListenable
  ///
  /// Converted [ValueListenable] objects become readable signals that automatically listen
  /// to the underlying source. When the source updates, the signal updates.
  ///
  /// The signal automatically manages the subscription, disposing of the listener when the
  /// signal itself is disposed.
  ///
  /// ### Example: Converting a ValueNotifier
  /// ```dart
  /// final ValueListenable<int> listenable = ValueNotifier(10);
  /// final signal = listenable.toSignal();
  ///
  /// print(signal.value); // 10
  /// ```
  ///
  /// ### Example: ValueListenable from ReadonlySignal
  /// To convert back to a standard [ValueListenable] for native Flutter compatibility:
  /// ```dart
  /// final signal = Signal(10);
  /// final listenable = signal.toValueListenable();
  /// ```
  ///
  /// @link https://dartsignals.dev/flutter/value-listenable
  /// {@endtemplate}
  ReadonlySignal<T> toSignal({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    final target = signal<T>(
      value,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );

    void updater() {
      target.value = value;
    }

    addListener(updater);
    target.onDispose(() => removeListener(updater));

    return target;
  }
}

/// A global helper function to convert a Flutter [ValueListenable] to a [ReadonlySignal].
///
/// This helper is a functional equivalent of the `toSignal()` extension method.
///
/// ### Example
/// ```dart
/// final scrollPosition = ValueNotifier(0.0);
/// final scrollSignal = valueListenableToSignal(scrollPosition);
/// ```
ReadonlySignal<T> valueListenableToSignal<T>(
  ValueListenable<T> valueListenable, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return valueListenable.toSignal(
    debugLabel: debugLabel,
    autoDispose: autoDispose,
  );
}
