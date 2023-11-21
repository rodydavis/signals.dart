import 'package:flutter/material.dart';
import 'package:preact_signals/preact_signals.dart';

extension SignalUtils<T> on ReadonlySignal<T> {
  T watch(BuildContext context) => watchSignal<T>(context, this);
}

T watchSignal<T>(BuildContext context, ReadonlySignal<T> signal) {
  if (context is Element) {
    final elementRef = WeakReference(context);
    effect(() {
      signal.value;
      if (elementRef.target?.mounted ?? false) {
        elementRef.target?.markNeedsBuild();
      }
    });
  }
  return signal.peek();
}
