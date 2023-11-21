import 'package:flutter/foundation.dart';
import 'package:preact_signals/preact_signals.dart';

extension SignalValueNotifierUtils<T> on ValueNotifier<T> {
  MutableSignal<T> toSignal() {
    final s = signal(value);
    addListener(() => s.value = value);
    return s;
  }
}

extension SignalValueListenableUtils<T> on ValueListenable<T> {
  ReadonlySignal<T> toSignal() {
    final s = signal(value);
    addListener(() => s.value = value);
    return s;
  }
}
