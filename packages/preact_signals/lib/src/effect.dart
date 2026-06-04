import 'package:meta/meta.dart';

import 'batch.dart';
import 'globals.dart';
import 'listenable.dart';
import 'options.dart';

/// Represents a passive observer that runs arbitrary side-effect code in response to signal changes.
///
/// An [Effect] tracks which signals are accessed within its callback function,
/// and automatically schedules itself to re-run whenever those dependencies change.
///
/// Under the hood, the reactivity engine tracks reads on `.value` inside the active effect block.
/// Once the block completes, a subscription is registered for each accessed signal. When any of those signals
/// mutate, the effect is added to the microtask queue and executed synchronously during the next tick.
///
/// <Warning>
///   Do not modify a tracked signal *directly* inside an effect callback, as this will trigger another execution
///   of the same effect, causing an infinite loop (cycle) and throwing a cycle detection error.
///   To read a signal non-reactively, use `.peek()`.
/// </Warning>
///
/// ### Example Usage
///
/// #### 1. Standard Side-Effect
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final count = signal(0);
///
/// void main() {
///   // Creates and immediately starts the effect
///   final logger = Effect(() {
///     print('Active count is: ${count.value}');
///   });
///
///   count.value = 1; // Prints: "Active count is: 1"
///   logger.dispose();
/// }
/// ```
///
/// #### 2. Effect Cleanup Callback
/// If your effect returns a function, that function is registered as a **cleanup callback**.
/// The cleanup callback is executed right before the next effect run, or when the effect is disposed.
/// This is highly useful for cleaning up timers, controllers, or other subscriptions:
/// ```dart
/// final query = signal('search_term');
///
/// final searchEffect = Effect(() {
///   final currentQuery = query.value;
///   print('Initiating search for: $currentQuery');
///
///   final timer = Timer(Duration(milliseconds: 500), () {
///     print('Search completed for: $currentQuery');
///   });
///
///   // Return cleanup callback
///   return () {
///     print('Cancelling previous search timer');
///     timer.cancel();
///   };
/// });
/// ```
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

  /// Creates a new [Effect] instance with the passive side-effect callback [fn].
  ///
  /// You can optionally provide:
  /// - A [name] for debugging/observer tracing.
  ///
  /// ```dart
  /// final effectObj = Effect(() => print(count.value), name: 'count_logger');
  /// ```
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

  /// Disposes of the effect, stopping future callback executions,
  /// executing any registered cleanup routines, and unsubscribing from all dependency signals.
  void dispose() {
    flags |= DISPOSED;
    if (!((flags & RUNNING) != 0)) {
      disposeEffect();
    }
  }

  /// Activates/Runs the effect immediately.
  ///
  /// Returns a bound disposer function that can be called to stop the effect.
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

/// Creates and immediately executes a new reactive [Effect].
///
/// Returns a bound disposer function that can be called to stop the effect and unsubscribe
/// it from all tracked signals.
///
/// ### Example Usage
///
/// ```dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// final count = signal(0);
/// final dispose = effect(() {
///   print('Count is: ${count.value}');
///   return () => print('Cleaning up!');
/// });
///
/// void main() {
///   count.value = 10; // Prints: "Cleaning up!" then "Count is: 10"
///   dispose(); // Stops the effect and unsubscribes
/// }
/// ```
void Function() effect(
  Function() fn, [
  EffectOptions? options,
]) {
  return Effect(fn, options: options)();
}
