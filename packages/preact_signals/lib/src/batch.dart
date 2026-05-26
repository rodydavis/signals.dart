import 'package:meta/meta.dart';

import 'effect.dart';
import 'globals.dart';
import 'signal.dart';

@internal
void recordBatchSnapshot(Signal source) {
  // Only capture writes during the user-visible batch callback, not during effect flush.
  if (batchDepth == 0 || batchIteration != 0) {
    return;
  }

  if (source.batchSnapshotVersion != currentBatchSnapshotVersion) {
    source.batchSnapshotVersion = currentBatchSnapshotVersion;
    batchSnapshots = BatchSnapshot(
      source: source,
      value: source.internalValue,
      version: source.version,
      next: batchSnapshots,
    );
  }
}

@internal
void reconcileBatchSnapshots() {
  var snapshots = batchSnapshots;
  batchSnapshots = null;

  while (snapshots != null) {
    if (snapshots.source.equalityCheck
        .equals(snapshots.source.internalValue, snapshots.value)) {
      snapshots.source.version = snapshots.version;
    }
    snapshots = snapshots.next;
  }
}

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
  reconcileBatchSnapshots();

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
}

/// Combines multiple signal writes into a single update that is flushed only after the callback completes.
///
/// Under normal circumstances, writing to a signal immediately notifies all of its active subscribers
/// (effects and computed signals), which can cause multiple redundant computations if you are updating
/// several signals sequentially.
///
/// By wrapping your mutations in [batch], notifications are deferred. Subscribed [effect]s and [computed]
/// signals will only run once at the very end of the batch callback block.
///
/// ### Nested Batches
///
/// Batches can be nested. Updates are only flushed when the *outermost* batch callback completes.
///
/// ### Mid-Batch Reads
///
/// If you read a mutated signal *inside* the batch callback, or access a computed signal that depends on a
/// mutated signal, that signal is immediately computed and updated inline to ensure your code always operates
/// on consistent, up-to-date data. However, other independent signals and effects are still deferred until
/// the batch finishes.
///
/// Parameters:
/// - [fn]: The callback function containing the signal write operations to be batched.
///
/// Returns:
/// - The value returned by the callback function [fn].
///
/// ### Example Usage
///
/// ````dart
/// import 'package:preact_signals/preact_signals.dart';
///
/// void main() {
///   final name = signal("Jane");
///   final surname = signal("Doe");
///   final fullName = computed(() => "${name.value} ${surname.value}");
///
///   // Set up an effect that reacts to changes
///   effect(() => print("Name changed to: ${fullName.value}"));
///
///   // Batching mutations ensures the effect runs only once
///   batch(() {
///     name.value = "John";
///     surname.value = "Smith";
///   });
///   // Prints: "Name changed to: John Smith" (Only once, not twice!)
/// }
/// ````
///
/// :::tip
/// Always use [batch] when performing multiple state transitions together. This avoids flickering UI, unnecessary
/// rebuilds, and transient states where some dependencies are updated but others are not.
/// :::
T batch<T>(
  /// The callback function.
  T Function() fn,
) {
  if (batchDepth > 0) {
    return fn();
  }
  currentBatchSnapshotVersion = ++batchSnapshotVersion;
  startBatch();
  try {
    return fn();
  } finally {
    endBatch();
  }
}
