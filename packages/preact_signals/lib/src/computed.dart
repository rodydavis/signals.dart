part of 'signals.dart';

class Computed<T> extends ReadonlySignal<T> implements Listenable {
  final T Function() _fn;

  @override
  final int globalId;

  @override
  Node? _sources;

  int _globalVersion;

  @override
  int _flags;

  Object? _error;

  bool _initialized = false;
  late T _value;

  Computed(T Function() fn)
      : _fn = fn,
        _globalVersion = globalVersion - 1,
        _flags = OUTDATED,
        version = 0,
        globalId = ++_lastGlobalId;

  @override
  bool refresh() {
    this._flags &= ~NOTIFIED;

    if ((this._flags & RUNNING) != 0) {
      return false;
    }

    // If this computed signal has subscribed to updates from its dependencies
    // (TRACKING flag set) and none of them have notified about changes (OUTDATED
    // flag not set), then the computed value can't have changed.
    if ((this._flags & (OUTDATED | TRACKING)) == TRACKING) {
      return true;
    }
    this._flags &= ~OUTDATED;

    if (this._globalVersion == globalVersion) {
      return true;
    }
    this._globalVersion = globalVersion;

    // Mark this computed signal running before checking the dependencies for value
    // changes, so that the RUNNING flag can be used to notice cyclical dependencies.
    this._flags |= RUNNING;
    if (version > 0 && !needsToRecompute(this)) {
      this._flags &= ~RUNNING;
      return true;
    }

    final prevContext = evalContext;
    try {
      prepareSources(this);
      evalContext = this;
      final value = this._fn();
      if ((this._flags & HAS_ERROR) != 0 ||
          !_initialized ||
          _value != value ||
          version == 0) {
        _value = value;
        if (!_initialized) _initialized = true;
        _flags &= ~HAS_ERROR;
        version++;
      }
    } catch (err) {
      _error = err;
      _flags |= HAS_ERROR;
      version++;
    }
    evalContext = prevContext;
    cleanupSources(this);
    _flags &= ~RUNNING;
    return true;
  }

  @override
  void subscribeToNode(Node node) {
    if (targets == null) {
      _flags |= OUTDATED | TRACKING;

      // A computed signal subscribes lazily to its dependencies when it
      // gets its first subscriber.
      for (var node = _sources; node != null; node = node.nextSource) {
        node.source.subscribeToNode(node);
      }
    }
    ReadonlySignal.__subscribe(this, node);
  }

  @override
  void unsubscribeFromNode(Node node) {
    // Only run the unsubscribe step if the computed signal has any subscribers.
    if (targets != null) {
      signalUnsubscribe(this, node);

      // Computed signal unsubscribes from its dependencies when it loses its last subscriber.
      // This makes it possible for unreferences subgraphs of computed signals to get garbage collected.
      if (targets == null) {
        _flags &= ~TRACKING;

        for (var node = _sources; node != null; node = node.nextSource) {
          node.source.unsubscribeFromNode(node);
        }
      }
    }
  }

  @override
  void _notify() {
    if (!((_flags & NOTIFIED) != 0)) {
      _flags |= OUTDATED | NOTIFIED;

      for (var node = targets; node != null; node = node.nextTarget) {
        node.target._notify();
      }
    }
  }

  @override
  T get value {
    if ((_flags & RUNNING) != 0) {
      throw Exception('Cycle detected');
    }

    final node = addDependency(this);
    refresh();
    if (node != null) {
      node.version = version;
    }
    if ((_flags & HAS_ERROR) != 0) {
      throw _error!;
    }
    return _value;
  }

  @override
  int version;

  @override
  void Function() subscribe(void Function(T value) fn) {
    return signalSubscribe(this, fn);
  }
}

/// Create a new signal that is computed based on the values of other signals.
///
/// The returned computed signal is read-only, and its value is automatically
/// updated when any signals accessed from within the callback function change.
///
/// @param fn The effect callback.
/// @returns A new read-only signal.
ReadonlySignal<T> computed<T>(T Function() compute) {
  return Computed<T>(compute);
}
