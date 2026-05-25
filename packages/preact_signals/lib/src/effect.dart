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
  /// @internal
  /// The effect callback.
  @internal
  Function()? fn;

  @override
  final int globalId;

  /// @internal
  /// The cleanup callback.
  @internal
  Function? cleanup;

  /// @internal
  /// The next effect in the batched effects queue.
  @internal
  Effect? nextBatchedEffect;

  @override
  int flags;

  /// The name of the effect for debugging.
  final String? name;

  /// Creates a new [Effect] instance with the callback [fn].
  Effect(
    this.fn, {
    String? name,
    EffectOptions? options,
  })  : name = options?.name ?? name,
        flags = TRACKING,
        cleanup = null,
        globalId = ++lastGlobalId {
    if (capturedEffects != null) {
      capturedEffects!.add(this);
    }
  }

  /// @internal
  /// Executes the callback function and schedules cleanups.
  @internal
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
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

  /// @internal
  /// Starts tracking dependency subscriptions.
  @internal
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
  void Function() start() {
    if ((flags & RUNNING) != 0) {
      throwCycleDetected();
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
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
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

  /// @internal
  /// Runs the user-defined cleanup callback if registered.
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

  /// @internal
  /// Disposes resources held by the effect.
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

  /// @internal
  /// Concludes the current effect evaluation round and restores the evaluation context context.
  @internal
  void endEffect(Listenable? prevContext) {
    final effect = this;
    if (evalContext != effect) {
      throwOutOfOrderEffect();
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
  return Effect(fn, options: options)();
}
