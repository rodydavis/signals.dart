part of 'signals.dart';

/// Create a new signal that is computed based on the values of other signals.
///
/// The returned computed signal is read-only, and its value is automatically
/// updated when any signals accessed from within the callback function change.
class Computed<T> extends ReadonlySignal<T> implements Listenable {
  @internal
  T Function() fn;

  @override
  final int globalId;

  @override
  Node? sources;

  @internal
  int internalGlobalVersion;

  @override
  int flags;

  @internal
  Object? error;

  @internal
  bool initialized = false;

  @internal
  late T internalValue;

  Computed(this.fn)
      : internalGlobalVersion = globalVersion - 1,
        flags = OUTDATED,
        version = 0,
        globalId = ++lastGlobalId;

  @override
  bool refresh() {
    this.flags &= ~NOTIFIED;

    if ((this.flags & RUNNING) != 0) {
      return false;
    }

    // If this computed signal has subscribed to updates from its dependencies
    // (TRACKING flag set) and none of them have notified about changes (OUTDATED
    // flag not set), then the computed value can't have changed.
    if ((this.flags & (OUTDATED | TRACKING)) == TRACKING) {
      return true;
    }
    this.flags &= ~OUTDATED;

    if (this.internalGlobalVersion == globalVersion) {
      return true;
    }
    this.internalGlobalVersion = globalVersion;

    // Mark this computed signal running before checking the dependencies for value
    // changes, so that the RUNNING flag can be used to notice cyclical dependencies.
    this.flags |= RUNNING;
    if (version > 0 && !needsToRecompute(this)) {
      this.flags &= ~RUNNING;
      return true;
    }

    final prevContext = evalContext;
    try {
      prepareSources(this);
      evalContext = this;
      final value = this.fn();
      if ((this.flags & HAS_ERROR) != 0 ||
          !initialized ||
          internalValue != value ||
          version == 0) {
        internalValue = value;
        if (!initialized) initialized = true;
        flags &= ~HAS_ERROR;
        version++;
      }
    } catch (err) {
      error = err;
      flags |= HAS_ERROR;
      version++;
    }
    evalContext = prevContext;
    cleanupSources(this);
    flags &= ~RUNNING;
    return true;
  }

  @override
  void subscribeToNode(Node node) {
    if (targets == null) {
      flags |= OUTDATED | TRACKING;

      // A computed signal subscribes lazily to its dependencies when it
      // gets its first subscriber.
      for (var node = sources; node != null; node = node.nextSource) {
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
        flags &= ~TRACKING;

        for (var node = sources; node != null; node = node.nextSource) {
          node.source.unsubscribeFromNode(node);
        }
      }
    }
  }

  @override
  void notify() {
    if (!((flags & NOTIFIED) != 0)) {
      flags |= OUTDATED | NOTIFIED;

      for (var node = targets; node != null; node = node.nextTarget) {
        node.target.notify();
      }
    }
  }

  @override
  T get value {
    if ((flags & RUNNING) != 0) {
      throw Exception('Cycle detected');
    }

    final node = addDependency(this);
    refresh();
    if (node != null) {
      node.version = version;
    }
    if ((flags & HAS_ERROR) != 0) {
      throw error!;
    }
    return internalValue;
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
ReadonlySignal<T> computed<T>(
  /// The effect callback.
  T Function() fn,
) {
  return Computed<T>(fn);
}
