import 'package:flutter/foundation.dart';
import 'package:preact_signals/preact_signals.dart';

extension SignalValueNotifierUtils<T> on ValueNotifier<T> {
  MutableSignal<T> toSignal() {
    final s = signal<T>(value);
    addListener(() => s.value = value);
    return s;
  }
}

extension SignalValueListenableUtils<T> on ValueListenable<T> {
  ReadonlySignal<T> toSignal() {
    final s = signal<T>(value);
    addListener(() => s.value = value);
    return s;
  }
}

ReadonlySignal<T> valueListenableToSignal<T>(ValueListenable<T> notifier) {
  final s = signal<T>(notifier.value);
  notifier.addListener(() => s.value = notifier.value);
  return s;
}

MutableSignal<T> valueNotifierToSignal<T>(ValueListenable<T> notifier) {
  final s = signal<T>(notifier.value);
  notifier.addListener(() => s.value = notifier.value);
  return s;
}
