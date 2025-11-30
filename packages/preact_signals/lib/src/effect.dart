import 'package:meta/meta.dart';

import 'batch.dart';
import 'globals.dart';
import 'listenable.dart';

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

  /// The effect callback
  Function()? fn;

  @override
  final int globalId;

  @internal

  /// Cleanup function
  Function? cleanup;

  @internal

  /// Next batched effect
  Effect? nextBatchedEffect;

  @override
  int flags;

  /// Effect name
  final String? name;

  /// Create a new effect
  Effect(
    this.fn, {
    EffectOptions? options,
  })  : flags = TRACKING,
        cleanup = null,
        name = options?.name,
        globalId = ++lastGlobalId;

  @internal

  /// Run the effect callback
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

  /// Start the effect
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

  /// Cleanup the effect
  void cleanupEffect() {
    final cleanup = this.cleanup;
    this.cleanup = null;

    if (cleanup != null) {
      startBatch();

      // Run cleanup functions always outside of any context.
      final prevContext = evalContext;
      evalContext = null;
      try {
        cleanup();
      } catch (e) {
        flags &= ~RUNNING;
        flags |= DISPOSED;
        disposeEffect();
        rethrow;
      } finally {
        evalContext = prevContext;
        endBatch();
      }
    }
  }

  @internal

  /// Dispose the effect
  void disposeEffect() {
    for (var node = sources; node != null; node = node.nextSource) {
      node.source.unsubscribeFromNode(node);
    }
    fn = null;
    sources = null;

    cleanupEffect();
  }

  @internal

  /// End the effect
  void endEffect(Listenable? prevContext) {
    if (evalContext != this) {
      throw Exception('Out-of-order effect');
    }
    cleanupSources();
    evalContext = prevContext;

    flags &= ~RUNNING;
    if ((flags & DISPOSED) != 0) {
      disposeEffect();
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
  Function() fn, {
  String? name,
}) {
  return Effect(
    fn,
    options: EffectOptions(name: name),
  )();
}
