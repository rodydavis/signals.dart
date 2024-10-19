part of 'signals.dart';

@internal
@pragma("vm:prefer-inline")
void startBatch() {
  batchDepth++;
}

@internal
void endBatch() {
  if (batchDepth > 1) {
    batchDepth--;
    return;
  }

  Object? error;
  bool hasError = false;

  while (batchedEffect != null) {
    Effect? effect = batchedEffect;
    batchedEffect = null;

    batchIteration++;

    while (effect != null) {
      final Effect? next = effect._nextBatchedEffect;
      effect._nextBatchedEffect = null;
      effect._flags &= ~NOTIFIED;

      if (!((effect._flags & DISPOSED) != 0) && needsToRecompute(effect)) {
        try {
          effect.callback();
        } catch (err) {
          if (!hasError) {
            error = err;
            hasError = true;
          }
        }
      }
      effect = next;
    }
  }
  batchIteration = 0;
  batchDepth--;

  if (hasError) {
    throw error!;
  }
}

/// Combine multiple value updates into one "commit" at the end of the provided callback.
///
/// Batches can be nested and changes are only flushed once the outermost batch callback
/// completes.
///
/// Accessing a signal that has been modified within a batch will reflect its updated
/// value.
///
/// @param fn The callback function.
/// @returns The value returned by the callback.
T batch<T>(T Function() fn) {
  if (batchDepth > 0) {
    return fn();
  }
  /*@__INLINE__**/ startBatch();
  try {
    return fn();
  } finally {
    endBatch();
  }
}
