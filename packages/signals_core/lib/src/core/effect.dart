part of 'signals.dart';

void _cleanupEffect(_Effect effect) {
  final cleanup = effect._cleanup;
  effect._cleanup = null;

  if (cleanup != null) {
    _startBatch();

    // Run cleanup functions always outside of any context.
    final prevContext = _evalContext;
    _evalContext = null;
    try {
      cleanup();
    } catch (e) {
      effect._flags &= ~RUNNING;
      effect._flags |= DISPOSED;
      _disposeEffect(effect);
      rethrow;
    } finally {
      _evalContext = prevContext;
      _endBatch();
    }
  }
}

void _disposeEffect(_Effect effect) {
  for (var node = effect._sources; node != null; node = node._nextSource) {
    node._source._unsubscribe(node);
  }
  effect._compute = null;
  effect._sources = null;

  _cleanupEffect(effect);
}

void _endEffect(_Effect effect, _Listenable? prevContext) {
  if (_evalContext != effect) {
    throw Exception('Out-of-order effect');
  }
  _cleanupSources(effect);
  _evalContext = prevContext;

  effect._flags &= ~RUNNING;
  if ((effect._flags & DISPOSED) != 0) {
    _disposeEffect(effect);
  }
  _endBatch();
}

/// Clean up function to stop subscriptions from updating the callback
typedef EffectCleanup = void Function();

/// Function called when signals in the callback change
typedef EffectCallback = Function();

_Effect? _currentEffect;

class _Effect implements _Listenable {
  EffectCallback? _compute;

  @override
  final String? debugLabel;

  @override
  final int globalId;

  Function? _cleanup;

  @override
  _Node? _sources;

  _Effect? _nextBatchedEffect;

  @override
  int _flags;

  @override
  bool operator ==(Object other) {
    return other is _Effect && globalId == other.globalId;
  }

  @override
  int get hashCode {
    return globalId.hashCode;
  }

  _Effect(
    EffectCallback compute, {
    this.debugLabel,
  })  : _flags = TRACKING,
        _compute = compute,
        _cleanup = null,
        globalId = ++_lastGlobalId {
    _onEffectCreated(this);
  }

  List<ReadonlySignal> get _allSources {
    final results = <ReadonlySignal>[];
    _Node? root = _sources;
    for (var node = root; node != null; node = node._nextSource) {
      results.add(node._source);
    }
    return results;
  }

  void _callback() {
    final finish = _start();
    try {
      if ((_flags & DISPOSED) != 0) return;
      if (_compute == null) return;
      _currentEffect = this;
      final cleanup = _compute!();
      _currentEffect = null;
      if (cleanup is Function) {
        _cleanup = cleanup;
      }
    } finally {
      finish();
    }
    _onEffectCalled(this);
  }

  EffectCleanup _start() {
    if ((_flags & RUNNING) != 0) {
      _cycleDetected();
    }
    _flags |= RUNNING;
    _flags &= ~DISPOSED;
    _cleanupEffect(this);
    _prepareSources(this);

    _startBatch();
    final prevContext = _evalContext;
    _evalContext = this;
    return () => _endEffect(this, prevContext);
  }

  @override
  void _notify() {
    if (!((_flags & NOTIFIED) != 0)) {
      _flags |= NOTIFIED;
      _nextBatchedEffect = _batchedEffect;
      _batchedEffect = this;
    }
  }

  final _disposeCallbacks = <EffectCallback>{};

  @override
  void onDispose(EffectCleanup cleanup) {
    _disposeCallbacks.add(cleanup);
  }

  void _dispose() {
    for (final cleanup in _disposeCallbacks) {
      cleanup();
    }
    _disposeCallbacks.clear();
    _flags |= DISPOSED;
    if (!((_flags & RUNNING) != 0)) {
      _disposeEffect(this);
    }
  }

  @override
  void dispose() {
    _dispose();
  }
}

/// The `effect` function is the last piece that makes everything reactive.
/// When you access a signal inside its callback function, that signal and
/// every dependency of said signal will be activated and subscribed to.
/// In that regard it is very similar to `computed`. By
/// default all updates are lazy, so nothing will update until you access
/// a signal inside `effect`.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final name = signal("Jane");
/// final surname = signal("Doe");
/// final fullName = computed(() => name.value + " " + surname.value);
///
/// // Logs: "Jane Doe"
/// effect(() => print(fullName.value));
///
/// // Updating one of its dependencies will automatically trigger
/// // the effect above, and will print "John Doe" to the console.
/// name.value = "John";
/// ```
///
/// You can destroy an effect and unsubscribe from all signals it was
/// subscribed to, by calling the returned function.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final name = signal("Jane");
/// final surname = signal("Doe");
/// final fullName = computed(() => name.value + " " + surname.value);
///
/// // Logs: "Jane Doe"
/// final dispose = effect(() => print(fullName.value));
///
/// // Destroy effect and subscriptions
/// dispose();
///
/// // Update does nothing, because no one is subscribed anymore.
/// // Even the computed `fullName` signal won't change, because it knows
/// // that no one listens to it.
/// surname.value = "Doe 2";
/// ```
EffectCleanup effect(EffectCallback compute, {String? debugLabel}) {
  final effect = _Effect(compute, debugLabel: debugLabel);
  try {
    effect._callback();
  } catch (e) {
    effect._dispose();
    _onEffectRemoved(effect);
    rethrow;
  }
  // Return a bound function instead of a wrapper like `() => effect._dispose()`,
  // because bound functions seem to be just as fast and take up a lot less memory.
  return () {
    effect._dispose();
    _onEffectRemoved(effect);
  };
}
