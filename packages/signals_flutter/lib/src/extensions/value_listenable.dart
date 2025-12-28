import 'package:flutter/foundation.dart';

import '../../signals_core.dart';
import '../core/options.dart';

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
    FlutterSignalOptions<T>? options,
  }) {
    final target = signal<T>(
      value,
      options: options,
    );

    void updater() {
      target.value = value;
    }

    addListener(updater);
    target.onDispose(() => removeListener(updater));

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
  FlutterSignalOptions<T>? options,
}) {
  return valueListenable.toSignal(
    options: options,
  );
}
