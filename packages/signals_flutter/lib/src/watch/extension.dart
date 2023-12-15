// Local set of subscribes that will hold the element to rebuild
import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart';

import 'widget.dart';

typedef _Key = (int, int);
typedef _Subscribers = Map<_Key, (WeakReference<Element>, VoidCallback)>;
final _Subscribers _listenSubscribers = {};
final _Subscribers _watchSubscribers = {};

/// Subscriber count for listeners
@visibleForTesting
int getSignalListenSubscriberCount() => _listenSubscribers.length;

/// Subscriber count for watchers
@visibleForTesting
int getSignalWatchSubscriberCount() => _watchSubscribers.length;

bool _clearing = false;
void clearSubscribers() {
  if (_clearing) return;
  _clearing = true;
  for (final (_, cleanup) in _listenSubscribers.values) {
    cleanup();
  }
  _listenSubscribers.clear();
  for (final (_, cleanup) in _watchSubscribers.values) {
    cleanup();
  }
  _watchSubscribers.clear();
  _clearing = false;
}

void _rebuild(WeakReference<Element> element) {
  element.target?.markNeedsBuild();
}

/// Watch a signal value and rebuild the context of the [Element]
/// if mounted and mark it as dirty
T watchSignal<T>(
  BuildContext context,
  ReadonlySignal<T> signal, {
  String? debugLabel,
}) {
  _watch(context, signal, false, _rebuild, debugLabel);
  // Grab the current value without subscribing
  return signal.peek();
}

/// Remove all subscribers for a given signal for watchers
void unwatchSignal<T>(BuildContext context, ReadonlySignal<T> signal) {
  // Remove keys for signal hashcode
  final items = [
    ..._watchSubscribers.entries.where((e) => e.key.$2 == signal.globalId),
  ];
  for (final item in items) {
    final (_, cleanup) = item.value;
    cleanup();
  }
  _watchSubscribers.removeWhere((key, value) => key.$2 == signal.globalId);
}

/// Remove all subscribers for a given signal for listeners
void unlistenSignal<T>(BuildContext context, ReadonlySignal<T> signal) {
  // Remove keys for signal hashcode
  final items = [
    ..._listenSubscribers.entries.where((e) => e.key.$2 == signal.globalId),
  ];
  for (final item in items) {
    final (_, cleanup) = item.value;
    cleanup();
  }
  _listenSubscribers.removeWhere((key, value) => key.$2 == signal.globalId);
}

/// Remove all subscribers for a given context
void unwatchElement(
  WeakReference<Element> context, {
  bool watch = true,
  bool listen = true,
}) {
  // Remove keys for element hashcode
  final items = [
    if (watch)
      ..._watchSubscribers.entries.where((e) => e.key.$1 == context.hashCode),
    if (listen)
      ..._listenSubscribers.entries.where((e) => e.key.$1 == context.hashCode),
  ];
  for (final item in items) {
    final (_, cleanup) = item.value;
    cleanup();
  }
  if (watch) {
    _watchSubscribers.removeWhere((key, value) => key.$1 == context.hashCode);
  }
  if (listen) {
    _listenSubscribers.removeWhere((key, value) => key.$1 == context.hashCode);
  }
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
  VoidCallback callback, {
  String? debugLabel,
}) {
  _watch(context, signal, true, (element) => callback(), debugLabel);
}

_Key _key<T>(BuildContext context, ReadonlySignal<T> signal) {
  return (signal.globalId, context.hashCode);
}

void _watch<T>(
  BuildContext context,
  ReadonlySignal<T> signal,
  bool listen,
  void Function(WeakReference<Element> element) onUpdate,
  String? debugLabel,
) {
  if (context is Element && (context is! Watch || listen)) {
    // Ignore watching if the parent is a watch widget
    // Create a key with the global id of the signal and the target widget
    final key = _key(context, signal);
    // checks if the widget is already subscribed to the signal
    _Subscribers subscribers;
    if (listen) {
      subscribers = _listenSubscribers;
    } else {
      subscribers = _watchSubscribers;
    }
    if (!subscribers.containsKey(key)) {
      // Save the element as a weak reference to allow for garbage collection
      // Subscribe to signal once
      final cleanup = effect(() {
        signal.value;
        // Grab the element from the subscriber map
        final (element, _) = subscribers[key] ?? (WeakReference(context), null);
        if (element.target != null) {
          // Only trigger update if mounted
          if (element.target!.mounted == true) {
            // Mark the widget as dirty and multiple updates
            // will be batched into one rerender
            onUpdate(element);
          }
        } else {
          // Element garbage collected so we can safely remove
          subscribers.remove(key);
        }
      }, debugLabel: debugLabel);
      subscribers[key] = (WeakReference(context), cleanup);
    }
  }
}
