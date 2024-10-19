part of 'signals.dart';

void cleanupEffect(Effect effect) {
  final cleanup = effect._cleanup;
  effect._cleanup = null;

  if (cleanup != null) {
    startBatch();

    // Run cleanup functions always outside of any context.
    final prevContext = evalContext;
    evalContext = null;
    try {
      cleanup();
    } catch (e) {
      effect._flags &= ~RUNNING;
      effect._flags |= DISPOSED;
      disposeEffect(effect);
      rethrow;
    } finally {
      evalContext = prevContext;
      endBatch();
    }
  }
}

void disposeEffect(Effect effect) {
  for (var node = effect._sources; node != null; node = node.nextSource) {
    node.source.unsubscribeFromNode(node);
  }
  effect._fn = null;
  effect._sources = null;

  cleanupEffect(effect);
}

void endEffect(Effect effect, Listenable? prevContext) {
  if (evalContext != effect) {
    throw Exception('Out-of-order effect');
  }
  cleanupSources(effect);
  evalContext = prevContext;

  effect._flags &= ~RUNNING;
  if ((effect._flags & DISPOSED) != 0) {
    disposeEffect(effect);
  }
  endBatch();
}

class Effect implements Listenable {
  Function()? _fn;

  @override
  final int globalId;

  Function? _cleanup;

  @override
  Node? _sources;

  Effect? _nextBatchedEffect;

  @override
  int _flags;

  Effect(Function() fn)
      : _flags = TRACKING,
        _fn = fn,
        _cleanup = null,
        globalId = ++_lastGlobalId;

  @internal
  void callback() {
    final finish = start();
    try {
      if ((_flags & DISPOSED) != 0) return;
      if (_fn == null) return;
      currentEffect = this;
      final cleanup = _fn!();
      currentEffect = null;
      if (cleanup is Function) {
        _cleanup = cleanup;
      }
    } finally {
      finish();
    }
  }

  @internal
  void Function() start() {
    if ((_flags & RUNNING) != 0) {
      throw Exception('Cycle detected');
    }
    _flags |= RUNNING;
    _flags &= ~DISPOSED;
    cleanupEffect(this);
    prepareSources(this);

    startBatch();
    final prevContext = evalContext;
    evalContext = this;
    return () => endEffect(this, prevContext);
  }

  @override
  void _notify() {
    if (!((_flags & NOTIFIED) != 0)) {
      _flags |= NOTIFIED;
      _nextBatchedEffect = batchedEffect;
      batchedEffect = this;
    }
  }

  void dispose() {
    _flags |= DISPOSED;
    if (!((_flags & RUNNING) != 0)) {
      disposeEffect(this);
    }
  }
}

/// Create an effect to run arbitrary code in response to signal changes.
///
/// An effect tracks which signals are accessed within the given callback
/// function `fn`, and re-runs the callback when those signals change.
///
/// The callback may return a cleanup function. The cleanup function gets
/// run once, either when the callback is next called or when the effect
/// gets disposed, whichever happens first.
///
/// @param fn The effect callback.
/// @returns A function for disposing the effect.
void Function() effect(Function() fn) {
  final effect = Effect(fn);
  try {
    effect.callback();
  } catch (e) {
    effect.dispose();
    rethrow;
  }
  // Return a bound function instead of a wrapper like `() => effect._dispose()`,
  // because bound functions seem to be just as fast and take up a lot less memory.
  return effect.dispose;
}
