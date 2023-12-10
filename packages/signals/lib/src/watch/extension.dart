// Local set of subscribes that will hold the element to rebuild
import 'package:flutter/widgets.dart';
import 'package:signals/signals.dart';

import 'widget.dart';

final _subscribers = <(int, int), (WeakReference<Element>, VoidCallback)>{};

@visibleForTesting
// ignore: public_member_api_docs
int getSubscriberCount() => _subscribers.length;

bool _clearing = false;
void clearSubscribers() {
  if (_clearing) return;
  _clearing = true;
  for (final (_, cleanup) in _subscribers.values) {
    cleanup();
  }
  _subscribers.clear();
  _clearing = false;
}

/// Watch a signal value and rebuild the context of the [Element]
/// if mounted and mark it as dirty
T watchSignal<T>(
  BuildContext context,
  ReadonlySignal<T> signal,
) {
  _watch(context, signal, false, (element) {
    element.markNeedsBuild();
  });
  // Grab the current value without subscribing
  return signal.peek();
}

/// Used to listen for updates on a signal but not rebuild the nearest element
///
/// ```dart
/// final counter = signal(0);
/// ...
/// @override
/// Widget build(BuildContext context) {
///   listenSignal(context, counter, () {
///     if (counter.value == 10) {
///       final messenger = ScaffoldMessenger.of(context);
///       messenger.hideCurrentSnackBar();
///       messenger.showSnackBar(
///         const SnackBar(content: Text('You hit 10 clicks!')),
///       );
///     }
///   });
/// ...
/// }
/// ```
void listenSignal<T>(
  BuildContext context,
  ReadonlySignal<T> signal,
  VoidCallback callback,
) {
  _watch(context, signal, true, (element) {
    callback();
  });
}

void _watch<T>(
  BuildContext context,
  ReadonlySignal<T> signal,
  bool listen,
  void Function(Element element) onUpdate,
) {
  if (context is Element && (context is! Watch || listen)) {
    // Ignore watching if the parent is a watch widget
    // Create a key with the global id of the signal and the target widget
    final key = (
      signal.globalId,
      Object.hashAll([context.hashCode, if (listen) onUpdate.hashCode])
    );
    // checks if the widget is already subscribed to the signal
    if (!_subscribers.containsKey(key)) {
      // Save the element as a weak reference to allow for garbage collection
      // Subscribe to signal once
      final el = WeakReference(context);
      final cleanup = signal.subscribe((_) {
        // Grab the element from the subscriber map
        final (element, _) = _subscribers[key] ?? (el, null);
        if (element.target != null) {
          // Only trigger update if mounted
          if (element.target!.mounted == true) {
            // Mark the widget as dirty and multiple updates
            // will be batched into one rerender
            onUpdate(element.target!);
          }
        } else {
          // Element garbage collected so we can safely remove
          _subscribers.remove(key);
        }
      });
      _subscribers[key] = (el, cleanup);
    } else {
      // Clear out any garbage collected widgets
      _subscribers.removeWhere((key, value) => value.$1.target == null);
    }
  }
}
