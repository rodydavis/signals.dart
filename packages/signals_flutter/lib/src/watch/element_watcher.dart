part of 'watch.dart';

// coverage:ignore-start
final _elementRefs = <int, ElementWatcher>{};
bool _removing = false;

void _removeSignalWatchers() {
  if (_removing) return;
  _removing = true;
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    _elementRefs.removeWhere((key, value) => value.element.target == null);
    _removing = false;
  });
}

/// Helper class to track signals and effects
/// with the lifecycle of an element.
@visibleForTesting
class ElementWatcher {
  /// Helper class to track signals and effects
  /// with the lifecycle of an element.
  ElementWatcher(this.id, this.label, this.element);

  /// Get [ElementWatcher] for a given signal id
  static ElementWatcher? get(int id) => _elementRefs[id];

  /// Unique id to store with the element
  final int id;

  /// Internal label used to track the current widget
  final String label;

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
      value.onDispose(() => unwatch(value));
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
      value.onDispose(() => unlisten(value, cb));
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
    _watchCleanup = effect(
      () {
        for (final s in _watchSignals.values) {
          s.value;
        }
        if (_watchSignals.isNotEmpty) rebuild();
      },
      debugLabel: 'watch=>$label',
    );
  }

  /// Restart the listeners
  void subscribeListen(ReadonlySignal signal) {
    _listenCleanup.putIfAbsent(
      signal.globalId,
      () => effect(
        () {
          signal.value;
          notify(signal);
        },
        debugLabel: 'listen=>$label',
      ),
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
  void rebuild() async {
    final target = element.target;
    if (target == null) {
      dispose();
      return;
    }
    if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
      await SchedulerBinding.instance.endOfFrame;
    }
    if (!target.mounted) return;
    target.markNeedsBuild();
  }

  /// Dispose of the element watcher and all the listeners
  void dispose() {
    _watchCleanup?.call();
    for (final cleanup in _listenCleanup.values) {
      cleanup();
    }
    _removeSignalWatchers();
  }
}
// coverage:ignore-end
