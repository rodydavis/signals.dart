import 'package:flutter/material.dart';
import 'package:preact_signals/preact_signals.dart';

/// Signal extensions
extension SignalUtils<T> on ReadonlySignal<T> {
  /// Rebuild the [Element] that the current signal is inside of
  T watch(BuildContext context) => watchSignal<T>(context, this);
}

final Set<String> _subscribers = {};

/// Watch a signal value and rebuild the context of the [Element]
/// if mounted and mark it as dirty
T watchSignal<T>(BuildContext context, ReadonlySignal<T> signal) {
  if (context is Element) {
    final elementRef = WeakReference(context);
    final key = '${signal.hashCode} ${elementRef.target.hashCode}';

    // checks if the widget is already subscribed to the signal
    if (!_subscribers.contains(key)) {
      _subscribers.add(key);
      signal.subscribe((_) {
        if (elementRef.target?.mounted ?? false) {
          elementRef.target?.markNeedsBuild();
        }
      });
    }
  }
  return signal.peek();
}
