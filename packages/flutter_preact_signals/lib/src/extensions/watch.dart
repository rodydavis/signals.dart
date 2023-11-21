import 'package:flutter/material.dart';
import 'package:preact_signals/preact_signals.dart';

/// Signal extensions
extension SignalUtils<T> on ReadonlySignal<T> {
  /// Rebuild the [Element] that the current signal is inside of
  T watch(BuildContext context) => watchSignal<T>(context, this);
}

/// Watch a signal value and rebuild the context of the [Element]
/// if mounted and mark it as dirty
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
