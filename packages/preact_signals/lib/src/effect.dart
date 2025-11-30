import 'dart:async';

import 'package:meta/meta.dart';

import 'batch.dart';
import 'globals.dart';
import 'listenable.dart';

/// Create an effect to run arbitrary code in response to signal changes.
///
/// An effect tracks which signals are accessed within the given callback
/// function `fn`, and re-runs the callback when those signals change.
///
/// The callback may return a cleanup function. The cleanup function gets
/// run once, either when the callback is next called or when the effect
/// gets disposed, whichever happens first.
class Effect with Listenable {
  /// The callback function
  @internal
  Function()? fn;

  @override
  final int globalId;

  /// The cleanup function
  @internal
  Function? cleanup;

  /// The next effect in the batch
  @internal
  Effect? nextBatchedEffect;

  @override
  int flags;

  /// The zone where the effect was created
  @internal
  final Zone creationZone;

  /// Create a new effect
  Effect(this.fn)
      : flags = TRACKING,
        cleanup = null,
        creationZone = Zone.current,
        globalId = ++lastGlobalId;

  /// Run the effect callback
  @internal
  @pragma('vm:prefer-inline')
  @pragma('dart2js:tryInline')
  @pragma('wasm:prefer-inline')
  void callback() {
    final finish = start();
    bool isAsync = false;
    try {
      if ((flags & DISPOSED) != 0) return;
      if (fn == null) return;

      creationZone.run(() {
        if (fn is Future Function()) {
          runZoned(
            () {
              final prevEval = globalEvalContext;
              final prevEffect = globalCurrentEffect;
              globalEvalContext = null;
              globalCurrentEffect = null;
              try {
                final result = fn!();
                if (result is Future) {
                  isAsync = true;
                  result.whenComplete(() {
                    endTracking();
                  });
                }
                if (result is Function) {
                  cleanup = result;
                }
              } finally {
                globalEvalContext = prevEval;
                globalCurrentEffect = prevEffect;
              }
            },
            zoneValues: {
              evalContextKey: this,
              currentEffectKey: this,
            },
          );
        } else {
          final prevEval = globalEvalContext;
          final prevEffect = globalCurrentEffect;
          globalEvalContext = this;
          globalCurrentEffect = this;
          try {
            final cleanup = fn!();
            if (cleanup is Function) {
              this.cleanup = cleanup;
            }
          } finally {
            globalEvalContext = prevEval;
            globalCurrentEffect = prevEffect;
          }
        }
      });
    } finally {
      if (isAsync) {
        endBatch();
      } else {
        finish();
      }
    }
  }

  /// Start the effect
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
    return endEffect;
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
    } else {}
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

  /// Cleanup the effect
  @internal
  void cleanupEffect() {
    final effect = this;
    final cleanup = effect.cleanup;
    effect.cleanup = null;

    if (cleanup != null) {
      startBatch();

      // Run cleanup functions always outside of any context.
      try {
        if (Zone.current[evalContextKey] != null) {
          runZoned(
            () {
              final prev = globalEvalContext;
              globalEvalContext = null;
              try {
                cleanup();
              } finally {
                globalEvalContext = prev;
              }
            },
            zoneValues: {evalContextKey: null},
          );
        } else {
          final prev = globalEvalContext;
          globalEvalContext = null;
          try {
            cleanup();
          } finally {
            globalEvalContext = prev;
          }
        }
      } catch (e) {
        effect.flags &= ~RUNNING;
        effect.flags |= DISPOSED;
        effect.disposeEffect();
        rethrow;
      } finally {
        endBatch();
      }
    }
  }

  /// Dispose the effect
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

  /// End tracking
  @internal
  void endTracking() {
    final effect = this;
    // if (evalContext != effect) {
    //   throwOutOfOrderEffect();
    // }
    effect.cleanupSources();

    effect.flags &= ~RUNNING;
    if ((effect.flags & DISPOSED) != 0) {
      effect.disposeEffect();
    }
  }

  /// End the effect
  @internal
  void endEffect() {
    endTracking();
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
  Function() fn,
) {
  return Effect(fn)();
}
