import 'package:meta/meta.dart';

import 'effect.dart';
import 'globals.dart';

@internal
@pragma('vm:prefer-inline')
@pragma('dart2js:tryInline')
@pragma('wasm:prefer-inline')
void startBatch() {
  batchDepth++;
}

@internal
@pragma('vm:prefer-inline')
@pragma('dart2js:tryInline')
@pragma('wasm:prefer-inline')
void endBatch() {
  if (batchDepth > 1) {
    batchDepth--;
    return;
  }

  SignalEffectException? error;
  bool hasError = false;

  while (batchedEffect != null) {
    Effect? effect = batchedEffect;
    batchedEffect = null;

    batchIteration++;

    while (effect != null) {
      final Effect? next = effect.nextBatchedEffect;
      effect.nextBatchedEffect = null;
      effect.flags &= ~NOTIFIED;

      if (!((effect.flags & DISPOSED) != 0) && effect.needsToRecompute()) {
        try {
          effect.callback();
        } catch (err, stack) {
          if (!hasError) {
            error = SignalEffectException(err, stack);
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
    throwSignalEffectException(error!);
  }
}

/// Error for when a effect fails to run the callback
class SignalEffectException implements Exception {
  /// Error during callback
  Object? error;

  /// StackTrace for where the error started
  StackTrace? stackTrace;

  /// Error for when a effect fails to run the callback
  SignalEffectException(this.error, [this.stackTrace]);

  @override
  String toString() {
    String message = 'SignalEffectException';
    if (error != null) {
      message += '\nCause: $error';
    }
    if (stackTrace != null) {
      message += '\n$stackTrace';
    }
    return message;
  }
}

/// Combine multiple value updates into one "commit" at the end of the provided callback.
///
/// Batches can be nested and changes are only flushed once the outermost batch callback
/// completes.
///
/// Accessing a signal that has been modified within a batch will reflect its updated
/// value.
T batch<T>(
  /// The callback function
  T Function() fn,
) {
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
