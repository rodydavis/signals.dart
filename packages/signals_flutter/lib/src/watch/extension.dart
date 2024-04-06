// ignore_for_file: public_member_api_docs, sort_constructors_first
// Local set of subscribes that will hold the element to rebuild
import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart';

import 'widget.dart';
import 'element_watcher.dart';

final _elementRefs = <int, ElementWatcher>{};

void removeSignalWatchers() {
  _elementRefs.removeWhere((key, value) => value.element.target == null);
}

/// Watch a signal value and rebuild the context of the [Element]
/// if mounted and mark it as dirty
T watchSignal<T>(
  BuildContext context,
  ReadonlySignal<T> signal, {
  String? debugLabel,
}) {
  if (context is Watch) return signal.value;
  if (context is Element) {
    final key = context.hashCode;
    if (_elementRefs[key] == null) {
      final watcher = ElementWatcher(key, WeakReference(context));
      _elementRefs[key] = watcher;
    }
    _elementRefs[key]?.watch(signal);
  }
  // Grab the current value without subscribing
  return signal.peek();
}

/// Remove all subscribers for a given signal for watchers
void unwatchSignal<T>(BuildContext context, ReadonlySignal<T> signal) {
  if (context is Watch) return;
  final key = context.hashCode;
  _elementRefs[key]?.unwatch(signal);
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
  void Function() callback, {
  String? debugLabel,
}) {
  if (context is Element) {
    final key = context.hashCode;
    if (_elementRefs[key] == null) {
      final watcher = ElementWatcher(key, WeakReference(context));
      _elementRefs[key] = watcher;
    }
    _elementRefs[key]?.listen(signal, callback);
  }
}

/// Remove all subscribers for a given signal for watchers
void unlistenSignal<T>(
  BuildContext context,
  ReadonlySignal<T> signal,
  void Function() callback, {
  String? debugLabel,
}) {
  final key = context.hashCode;
  _elementRefs[key]?.unlisten(signal, callback);
}
