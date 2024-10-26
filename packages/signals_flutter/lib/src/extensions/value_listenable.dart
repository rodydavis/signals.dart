import 'package:flutter/foundation.dart';

import '../../signals_core.dart';

/// Extension on [ValueListenable] to provide helpful methods for signals
extension SignalValueListenableUtils<T> on ValueListenable<T> {
  /// {@template value}
  /// ## ReadonlySignal from ValueListenable
  ///
  /// To create a readonly signal from a `ValueListenable`, use the `toSignal` extension:
  ///
  /// ```dart
  /// final ValueListenable listenable = ValueNotifier(10);
  /// final signal = listenable.toSignal();
  /// ```
  ///
  /// ## ValueListenable from ReadonlySignal
  ///
  /// To create a `ValueListenable` from a readonly signal, use the `toValueListenable` extension:
  ///
  /// ```dart
  /// final signal = Signal(10);
  /// final listenable = signal.toValueListenable();
  /// ```
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
    target.onDispose(updater);

    return target;
  }
}

/// {@template value}
/// ## ReadonlySignal from ValueListenable
///
/// To create a readonly signal from a `ValueListenable`, use the `toSignal` extension:
///
/// ```dart
/// final ValueListenable listenable = ValueNotifier(10);
/// final signal = listenable.toSignal();
/// ```
///
/// ## ValueListenable from ReadonlySignal
///
/// To create a `ValueListenable` from a readonly signal, use the `toValueListenable` extension:
///
/// ```dart
/// final signal = Signal(10);
/// final listenable = signal.toValueListenable();
/// ```
/// @link https://dartsignals.dev/flutter/value-listenable
/// {@endtemplate}
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
