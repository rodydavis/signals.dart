import 'package:flutter/widgets.dart';

import '../../signals_flutter.dart';

class ElementWatcher {
  ElementWatcher(this.key, this.element);

  final int key;
  final WeakReference<Element> element;
  EffectCleanup? _watchCleanup;
  final _listenCleanup = <int, EffectCleanup>{};

  bool _watch = false;
  final _listeners = <int, Set<VoidCallback>>{};
  final _watchSignals = <int, ReadonlySignal>{};
  final _listenSignals = <int, ReadonlySignal>{};

  bool get active {
    final w = _watchSignals.isNotEmpty && _watch;
    final l = _listenSignals.isNotEmpty && _listeners.isNotEmpty;
    return w || l;
  }

  void watch(ReadonlySignal value) {
    if (!_watchSignals.containsKey(value.globalId)) {
      _watchSignals[value.globalId] = value;
      _watch = true;
      subscribeWatch();
    }
  }

  void unwatch(ReadonlySignal value) {
    if (_watchSignals.containsKey(value.globalId)) {
      _watchSignals.remove(value.globalId);
      _watch = _watchSignals.isNotEmpty;
      subscribeWatch();
    }
  }

  void listen(ReadonlySignal value, VoidCallback cb) {
    if (!_listenSignals.containsKey(value.globalId)) {
      _listenSignals[value.globalId] = value;
      subscribeListen(value);
    }
    _listeners[value.globalId] ??= {};
    _listeners[value.globalId]!.add(cb);
  }

  void unlisten(ReadonlySignal value, VoidCallback cb) {
    if (!_listenSignals.containsKey(value.globalId)) {
      _listenSignals.remove(value.globalId);
      final cleanup = _listenCleanup.remove(value.globalId);
      cleanup?.call();
    }
    _listeners[value.globalId] ??= {};
    _listeners[value.globalId]!.remove(cb);
  }

  void subscribeWatch() {
    _watchCleanup?.call();
    _watchCleanup = effect(() {
      if (element.target == null) {
        dispose();
        return;
      }
      for (final s in _watchSignals.values) {
        s.value;
      }
      if (element.target?.mounted == true) {
        if (_watch) rebuild();
      }
    });
  }

  void subscribeListen(ReadonlySignal signal) {
    _listenCleanup.putIfAbsent(
      signal.globalId,
      () => effect(() {
        if (element.target == null) {
          dispose();
          return;
        }
        signal.value;
        if (element.target?.mounted == true) {
          notify(signal);
        }
      }),
    );
  }

  void notify(ReadonlySignal signal) {
    final listeners = _listeners[signal.globalId] ?? {};
    for (final listener in listeners) {
      listener();
    }
  }

  void rebuild() {
    element.target?.markNeedsBuild();
  }

  void dispose() {
    _watchCleanup?.call();
    for (final cleanup in _listenCleanup.values) {
      cleanup();
    }
    _listenCleanup.clear();
    _listeners.clear();
    _watch = false;
  }
}
