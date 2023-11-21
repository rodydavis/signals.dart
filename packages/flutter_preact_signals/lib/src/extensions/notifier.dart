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

ReadonlySignal<T> signalFromValueListenable<T>(ValueListenable<T> notifier) {
  final s = signal<T>(notifier.value);
  notifier.addListener(() => s.value = notifier.value);
  return s;
}

MutableSignal<T> signalFromValueNotifier<T>(ValueNotifier<T> notifier) {
  final s = signal<T>(notifier.value);
  var local = false;
  notifier.addListener(() {
    if (local) {
      local = false;
      return;
    }
    s.value = notifier.value;
  });
  effect(() {
    final val = s.value;
    local = true;
    notifier.value = val;
  });
  return s;
}
