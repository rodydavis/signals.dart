import 'package:flutter/material.dart';

import '../flutter_preact_signals.dart';

// Local set of subscribes that will hold the element to rebuild
final _subscribers = <(int, int), WeakReference<Element>>{};

/// Watch a signal value and rebuild the context of the [Element]
/// if mounted and mark it as dirty
T watchSignal<T>(BuildContext context, ReadonlySignal<T> signal) {
  if (context is Element) {
    // Create a key with the global id of the signal and the target widget
    final key = (signal.globalId, context.hashCode);
    // checks if the widget is already subscribed to the signal
    if (!_subscribers.containsKey(key)) {
      // Save the element as a weak reference to allow for garbage collection
      _subscribers[key] = WeakReference(context);
      // Subscribe to signal once
      signal.subscribe((_) {
        // Grab the element from the subscriber map
        final element = _subscribers[key]!;
        if (element.target != null) {
          // Only trigger update if mounted
          if (element.target!.mounted == true) {
            // Mark the widget as dirty and multiple updates
            // will be batched into one rerender
            element.target!.markNeedsBuild();
          }
        } else {
          // Element garbage collected so we can safely remove
          _subscribers.remove(key);
        }
      });
    } else {
      // Clear out any garbage collected widgets
      _subscribers.removeWhere((key, value) => value.target == null);
    }
  }
  // Grab the current value without subscribing
  return signal.peek();
}
