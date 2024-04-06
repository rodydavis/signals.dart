import 'package:flutter/widgets.dart';

import '../../signals_flutter.dart';

/// Helper class to track signals and effects
/// with the lifecycle of an element.
class ElementWatcher {
  /// Helper class to track signals and effects
  /// with the lifecycle of an element.
  ElementWatcher(this.id, this.element);

  /// Unique id to store with the element
  final int id;

  /// Flutter element that is usually a widget
  ///
  final WeakReference<Element> element;

  EffectCleanup? _watchCleanup;
  final _listenCleanup = <int, EffectCleanup>{};
  final _listeners = <int, VoidCallback>{};
  final _watchSignals = <int, ReadonlySignal>{};
  final _listenSignals = <int, ReadonlySignal>{};

  /// Check if the watcher is active via non empty listeners.
  bool get active {
    final w = _watchSignals.isNotEmpty;
    final l = _listenSignals.isNotEmpty && _listeners.isNotEmpty;
    return w || l;
  }

  /// Watch a signal on am element
  void watch(ReadonlySignal value) {
    if (!_watchSignals.containsKey(value.globalId)) {
      _watchSignals[value.globalId] = value;
      subscribeWatch();
    }
  }

  /// Remove the listener of an element for a given signal
  void unwatch(ReadonlySignal value) {
    if (_watchSignals.containsKey(value.globalId)) {
      _watchSignals.remove(value.globalId);
      subscribeWatch();
    }
  }

  /// Attach a callback to the widget
  void listen(ReadonlySignal value, VoidCallback cb) {
    if (!_listenSignals.containsKey(value.globalId)) {
      _listenSignals[value.globalId] = value;
      subscribeListen(value);
    }
    _listeners[value.globalId] = cb;
  }

  /// Stop calling the callback for a signal
  void unlisten(ReadonlySignal value, VoidCallback cb) {
    if (!_listenSignals.containsKey(value.globalId)) {
      _listenSignals.remove(value.globalId);
      final cleanup = _listenCleanup.remove(value.globalId);
      cleanup?.call();
    }
    _listeners.remove(value.globalId);
  }

  /// Restart the subsribers
  void subscribeWatch() {
    _watchCleanup?.call();
    _watchCleanup = effect(() {
      for (final s in _watchSignals.values) {
        s.value;
      }
      if (_watchSignals.isNotEmpty) rebuild();
    });
  }

  /// Restart the listeners
  void subscribeListen(ReadonlySignal signal) {
    _listenCleanup.putIfAbsent(
      signal.globalId,
      () => effect(() {
        signal.value;
        notify(signal);
      }),
    );
  }

  /// Notify a listener for a given signal
  void notify(ReadonlySignal signal) {
    final target = element.target;
    if (target == null) {
      dispose();
      return;
    }
    if (!target.mounted) return;
    final listener = _listeners[signal.globalId];
    listener?.call();
  }

  /// Rebuild the widget
  void rebuild() {
    final target = element.target;
    if (target == null) {
      dispose();
      return;
    }
    if (!target.mounted) return;
    if (target.dirty) return;
    target.markNeedsBuild();
  }

  /// Dispose of the element watcher and all the listeners
  void dispose() {
    _watchCleanup?.call();
    for (final cleanup in _listenCleanup.values) {
      cleanup();
    }
    _listenCleanup.clear();
    _listeners.clear();
  }
}
