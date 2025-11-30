import 'package:meta/meta.dart';

import 'batch.dart';
import 'globals.dart';
import 'listenable.dart';
import 'node.dart';
import 'options.dart';

/// Create an effect to run arbitrary code in response to signal changes.
///
/// An effect tracks which signals are accessed within the given callback
/// function `fn`, and re-runs the callback when those signals change.
///
/// The callback may return a cleanup function. The cleanup function gets
/// run once, either when the callback is next called or when the effect
/// gets disposed, whichever happens first.
class Effect with Listenable {
  @internal
  Function()? fn;

  @override
  final int globalId;

  @internal
  Function? cleanup;

  @override
  Node? sources;

  @internal
  Effect? nextBatchedEffect;

  @override
  int flags;

  /// The name of the effect, used for debugging
  String? name;

  /// Create a new effect
  Effect(this.fn, [EffectOptions? options])
      : flags = TRACKING,
        cleanup = null,
        globalId = ++lastGlobalId,
        name = options?.name;

  @internal
  void callback() {
    final finish = start();
    try {
      if ((flags & DISPOSED) != 0) return;
      if (fn == null) return;
      currentEffect = this;
      final cleanup = fn!();
      currentEffect = null;
      if (cleanup is Function) {
        this.cleanup = cleanup;
      }
    } finally {
      finish();
    }
  }

  @internal
  void Function() start() {
    if ((flags & RUNNING) != 0) {
      throw Exception('Cycle detected');
    }
    flags |= RUNNING;
    flags &= ~DISPOSED;
    cleanupEffect();
    prepareSources();

    startBatch();
    final prevContext = evalContext;
    evalContext = this;
    return () => endEffect(prevContext);
  }

  @override
  void notify() {
    if (!((flags & NOTIFIED) != 0)) {
      flags |= NOTIFIED;
      nextBatchedEffect = batchedEffect;
      batchedEffect = this;
    }
  }

  /// Dispose of the effect and stop future callbacks
  void dispose() {
    flags |= DISPOSED;
    if (!((flags & RUNNING) != 0)) {
      disposeEffect();
    }
  }

  /// Activate the effect starting with the callback
  void Function() call() {
    try {
      callback();
    } catch (e) {
      dispose();
      rethrow;
    }
    // Return a bound function instead of a wrapper like `() => effect._dispose()`,
    // because bound functions seem to be just as fast and take up a lot less memory.
    return dispose;
  }

  @internal
  void cleanupEffect() {
    final effect = this;
    final cleanup = effect.cleanup;
    effect.cleanup = null;

    if (cleanup != null) {
      startBatch();

      // Run cleanup functions always outside of any context.
      final prevContext = evalContext;
      evalContext = null;
      try {
        cleanup();
      } catch (e) {
        effect.flags &= ~RUNNING;
        effect.flags |= DISPOSED;
        effect.disposeEffect();
        rethrow;
      } finally {
        evalContext = prevContext;
        endBatch();
      }
    }
  }

  @internal
  void disposeEffect() {
    final effect = this;
    for (var node = effect.sources; node != null; node = node.nextSource) {
      node.source.unsubscribeFromNode(node);
    }
    effect.fn = null;
    effect.sources = null;

    effect.cleanupEffect();
  }

  @internal
  void endEffect(Listenable? prevContext) {
    final effect = this;
    if (evalContext != effect) {
      throw Exception('Out-of-order effect');
    }
    effect.cleanupSources();
    evalContext = prevContext;

    effect.flags &= ~RUNNING;
    if ((effect.flags & DISPOSED) != 0) {
      effect.disposeEffect();
    }
    endBatch();
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
void Function() effect(
  /// The effect callback
  Function() fn, [
  EffectOptions? options,
]) {
  return Effect(fn, options)();
}
