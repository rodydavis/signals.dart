import 'package:flutter/foundation.dart';
import 'package:signals_core/signals_core.dart';

/// Extension on [ValueNotifier] to provide helpful methods for signals
extension SignalValueNotifierUtils<T> on ValueNotifier<T> {
  /// Convert an existing [ValueNotifier] to [Signal]
  Signal<T> toSignal({String? debugLabel}) {
    final s = signal<T>(value, debugLabel: debugLabel);
    void update() => () => s.value = value;
    addListener(update);
    s.subscribe((_) => value = s.value);
    s.onDispose(() => removeListener(update));
    return s;
  }
}

/// Convert a [ValueNotifier] to [Signal] to be used in builders
Signal<T> valueNotifierToSignal<T>(ValueNotifier<T> valueNotifier) {
  return valueNotifier.toSignal();
}