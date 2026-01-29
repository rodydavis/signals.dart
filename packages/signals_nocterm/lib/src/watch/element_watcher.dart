part of 'watch.dart';

// coverage:ignore-start
final _elementRefs = <int, ElementWatcher>{};
bool _removing = false;

void _removeSignalWatchers() {
  if (_removing) return;
  _removing = true;
  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
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

  /// Internal label used to track the current component
  final String label;

  /// Nocterm element that is usually a component
  final WeakReference<Element> element;

  final _watch = <int, VoidCallback>{};
  final _listen = <int, VoidCallback>{};
  final _batch = <VoidCallback>{};

  /// Check if the watcher is active via non empty listeners.
  bool get active {
    return _watch.isNotEmpty || _listen.isNotEmpty;
  }

  /// Watch a signal on an element
  void watch(core.ReadonlySignal value) {
    _watch.putIfAbsent(
      value.globalId,
      () => value.subscribe((val) => rebuild()),
    );
  }

  /// Remove the listener of an element for a given signal
  void unwatch(core.ReadonlySignal value) {
    final dispose = _watch.remove(value.globalId);
    dispose?.call();
  }

  /// Attach a callback to the component
  void listen(core.ReadonlySignal value, VoidCallback cb) {
    _listen.putIfAbsent(
      value.globalId,
      () => value.subscribe((val) => _callback(cb, listener: true)),
    );
  }

  /// Stop calling the callback for a signal
  void unlisten(core.ReadonlySignal value, VoidCallback cb) {
    final dispose = _listen.remove(value.globalId);
    dispose?.call();
  }

  /// Rebuild the component
  void rebuild() async {
    final target = element.target;
    if (target == null) {
      dispose();
      return;
    }
    if (!target.mounted) return;

    final scheduler = SchedulerBinding.instance;
    if (scheduler.schedulerPhase != SchedulerPhase.idle) {
      await scheduler.endOfFrame;
      if (!target.mounted) return;
    }
    target.markNeedsBuild();
  }

  void _callback(VoidCallback cb, {bool listener = false}) async {
    final target = element.target;
    if (target == null) {
      dispose();
      return;
    }
    if (listener) {
      cb();
    } else {
      if (!target.mounted) return;
      if (_batch.contains(cb)) return;
      _batch.add(cb);
      _call();
    }
  }

  void _call() {
    for (final cb in _batch) {
      cb();
    }
    _batch.clear();
  }

  /// Dispose of the element watcher and all the listeners
  void dispose() {
    // Snapshot the values to prevent ConcurrentModificationError
    // if cleanup callbacks trigger signal updates that modify the maps
    final watchCleanups = List<VoidCallback>.of(_watch.values);
    final listenCleanups = List<VoidCallback>.of(_listen.values);
    _watch.clear();
    _listen.clear();
    for (final cleanup in watchCleanups) {
      cleanup();
    }
    for (final cleanup in listenCleanups) {
      cleanup();
    }
    _removeSignalWatchers();
  }
}
// coverage:ignore-end
