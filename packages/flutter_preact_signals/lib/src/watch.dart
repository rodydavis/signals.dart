import 'package:flutter/material.dart';
import 'package:preact_signals/preact_signals.dart';

extension SignalUtils<T> on ReadonlySignal<T> {
  T watch(BuildContext context) {
    final elementRef = WeakReference(context as Element);
    effect(() {
      value;
      if (elementRef.target?.mounted ?? false) {
        elementRef.target?.markNeedsBuild();
      }
    });
    return peek();
  }
}
