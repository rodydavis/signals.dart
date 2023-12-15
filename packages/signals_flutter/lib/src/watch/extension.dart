// ignore_for_file: public_member_api_docs, sort_constructors_first
// Local set of subscribes that will hold the element to rebuild
import 'package:flutter/widgets.dart';
import 'package:signals_core/signals_core.dart';

import 'widget.dart';

final _elementRefs = <int, _ElementWatcher>{};

bool _initialized = false;
void _init() {
  if (_initialized) return;
  _initialized = true;
  WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
    final items = _elementRefs.entries.toList();
    for (final el in items) {
      if (el.value._element.target == null || !el.value.active) {
        _elementRefs.remove(el.key)?.dispose();
      }
    }
  });
}

class _ElementWatcher {
  _ElementWatcher(this.key, this._element);

  final int key;
  final WeakReference<Element> _element;
  EffectCleanup? _watchCleanup;
  EffectCleanup? _listenCleanup;

  bool _watch = false;
  final _listeners = <VoidCallback>{};
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
      if (!_watch) {
        _watch = true;
        subscribeWatch();
      }
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
      subscribeListen();
    }
    _listeners.add(cb);
  }

  void unlisten(ReadonlySignal value, VoidCallback cb) {
    if (!_listenSignals.containsKey(value.globalId)) {
      _listenSignals.remove(value.globalId);
      subscribeListen();
    }
    _listeners.remove(cb);
  }

  void subscribeWatch() {
    _watchCleanup?.call();
    _watchCleanup = effect(() {
      if (_element.target == null) {
        dispose();
        return;
      }
      for (final s in _watchSignals.values) {
        s.value;
      }
      if (_element.target?.mounted == true) {
        if (_watch) rebuild();
      }
    });
  }

  void subscribeListen() {
    _listenCleanup?.call();
    _listenCleanup = effect(() {
      if (_element.target == null) {
        dispose();
        return;
      }
      for (final s in _listenSignals.values) {
        s.value;
      }
      if (_element.target?.mounted == true) {
        notify();
      }
    });
  }

  void notify() {
    for (final listener in _listeners) {
      listener();
    }
  }

  void rebuild() {
    _element.target?.markNeedsBuild();
  }

  void dispose() {
    _watchCleanup?.call();
    _listenCleanup?.call();
    _listeners.clear();
    _watch = false;
    // _finalizer.detach(this);
  }
}

/// Watch a signal value and rebuild the context of the [Element]
/// if mounted and mark it as dirty
T watchSignal<T>(
  BuildContext context,
  ReadonlySignal<T> signal, {
  String? debugLabel,
}) {
  if (context is Element && context is! Watch) {
    final key = context.hashCode;
    if (_elementRefs[key] == null) {
      final watcher = _ElementWatcher(key, WeakReference(context));
      _elementRefs[key] = watcher;
      _init();
    }
    _elementRefs[key]?.watch(signal);
  }
  // Grab the current value without subscribing
  return signal.peek();
}

/// Remove all subscribers for a given signal for watchers
void unwatchSignal<T>(BuildContext context, ReadonlySignal<T> signal) {
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
      final watcher = _ElementWatcher(key, WeakReference(context));
      _elementRefs[key] = watcher;
      _init();
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
