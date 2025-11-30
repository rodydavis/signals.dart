import 'package:meta/meta.dart';

import 'batch.dart';
import 'globals.dart';
import 'listenable.dart';
import 'node.dart';
import 'options.dart';
import 'readonly.dart';

/// Create a new signal that is computed based on the values of other signals.
///
/// The returned computed signal is read-only, and its value is automatically
/// updated when any signals accessed from within the callback function change.
class Computed<T> with Listenable, ReadonlySignal<T> {
  @internal

  /// The function to compute the value
  T Function() fn;

  @override
  final int globalId;

  @internal

  /// Global version when the value was last computed
  int internalGlobalVersion;

  @override
  int flags;

  @internal

  /// Error if the computation failed
  SignalEffectException? error;

  bool _isInitialized = false;

  /// Check if the value has been computed
  bool get isInitialized => _isInitialized;

  late T _internalValue;

  @override
  T get internalValue => _internalValue;

  @internal
  set internalValue(T value) {
    _internalValue = value;
    _isInitialized = true;
  }

  /// Computed signal name
  final String? name;
  final void Function()? _watched;
  final void Function()? _unwatched;

  @override

  /// Callback when the signal is watched
  void Function()? get watched => _watched;

  @override

  /// Callback when the signal is unwatched
  void Function()? get unwatched => _unwatched;

  /// Create a new computed signal
  Computed(
    this.fn, {
    SignalOptions<T>? options,
  })  : internalGlobalVersion = globalVersion - 1,
        flags = OUTDATED,
        version = 0,
        globalId = ++lastGlobalId,
        _watched = options?.watched,
        _unwatched = options?.unwatched,
        name = options?.name;

  @override
  bool internalRefresh() {
    flags &= ~NOTIFIED;

    if ((flags & RUNNING) != 0) {
      return false;
    }

    // If this computed signal has subscribed to updates from its dependencies
    // (TRACKING flag set) and none of them have notified about changes (OUTDATED
    // flag not set), then the computed value can't have changed.
    if ((flags & (OUTDATED | TRACKING)) == TRACKING) {
      return true;
    }
    flags &= ~OUTDATED;

    if (internalGlobalVersion == globalVersion) {
      return true;
    }
    internalGlobalVersion = globalVersion;

    // Mark this computed signal running before checking the dependencies for value
    // changes, so that the RUNNING flag can be used to notice cyclical dependencies.
    flags |= RUNNING;
    if (version > 0 && !needsToRecompute()) {
      flags &= ~RUNNING;
      return true;
    }

    final prevContext = evalContext;
    try {
      prepareSources();
      evalContext = this;
      final val = fn();
      if (!_isInitialized ||
          (flags & HAS_ERROR) != 0 ||
          _internalValue != val ||
          version == 0) {
        beforeUpdate(val);
        internalValue = val;
        flags &= ~HAS_ERROR;
        version++;
        update();
      }
    } catch (err, stack) {
      error = SignalEffectException(err, stack);
      flags |= HAS_ERROR;
      version++;
    }
    evalContext = prevContext;
    cleanupSources();
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
    internalSubscribe(node);
  }

  @override
  void unsubscribeFromNode(Node node) {
    // Only run the unsubscribe step if the computed signal has any subscribers.
    if (targets != null) {
      signalUnsubscribe(node);

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

    final node = addDependency();
    internalRefresh();
    if (node != null) {
      node.version = version;
    }
    if ((flags & HAS_ERROR) != 0) {
      throw error!;
    }
    return _internalValue;
  }

  @override
  int version;

  @override
  void Function() subscribe(void Function(T value) fn) {
    return signalSubscribe(fn);
  }

  @internal
  void update() {}
}

/// Create a new signal that is computed based on the values of other signals.
///
/// The returned computed signal is read-only, and its value is automatically
/// updated when any signals accessed from within the callback function change.
ReadonlySignal<T> computed<T>(
  /// The effect callback.
  T Function() fn, {
  SignalOptions<T>? options,
}) {
  return Computed<T>(
    fn,
    options: options,
  );
}
