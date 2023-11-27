import 'package:flutter/foundation.dart';
import 'package:preact_signals/preact_signals.dart';

/// Extension on [ValueNotifier] to provide helpful methods for signals
extension SignalValueNotifierUtils<T> on ValueNotifier<T> {
  /// Convert an existing [ValueNotifier] to [MutableSignal]
  MutableSignal<T> toSignal({String? debugLabel}) {
    final s = signal<T>(value, debugLabel: debugLabel);
    addListener(() => s.value = value);
    s.subscribe((_) => value = s.value);
    return s;
  }
}
