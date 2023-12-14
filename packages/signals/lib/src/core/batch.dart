part of 'signals.dart';

void _startBatch() {
  _batchDepth++;
}

void _endBatch() {
  if (_batchDepth > 1) {
    _batchDepth--;
    return;
  }

  dynamic error;
  bool hasError = false;

  while (_batchedEffect != null) {
    _Effect? effect = _batchedEffect;
    _batchedEffect = null;

    _callDepth++;

    while (effect != null) {
      final _Effect? next = effect._nextBatchedEffect;
      effect._nextBatchedEffect = null;
      effect._flags &= ~NOTIFIED;

      if (!((effect._flags & DISPOSED) != 0) && _needsToRecompute(effect)) {
        try {
          effect._callback();
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
  _callDepth = 0;
  _batchDepth--;

  if (hasError) {
    throw error;
  }
}

typedef BatchCallback<T> = T Function();

/// The `batch` function allows you to combine multiple signal writes into one
/// single update that is triggered at the end when the callback completes.
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
/// // Combines both signal writes into one update. Once the callback
/// // returns the `effect` will trigger and we'll log "Foo Bar"
/// batch(() {
/// 	name.value = "Foo";
/// 	surname.value = "Bar";
/// });
/// ```
///
/// When you access a signal that you wrote to earlier inside the callback,
/// or access a computed signal that was invalidated by another signal, we'll
/// only update the necessary dependencies to get the current value for the
/// signal you read from. All other invalidated signals will update at the
/// end of the callback function.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final counter = signal(0);
/// final _double = computed(() => counter.value * 2);
/// final _triple = computed(() => counter.value * 3);
///
/// effect(() => print(_double.value, _triple.value));
///
/// batch(() {
/// 	counter.value = 1;
/// 	// Logs: 2, despite being inside batch, but `triple`
/// 	// will only update once the callback is complete
/// 	print(_double.value);
/// });
/// // Now we reached the end of the batch and call the effect
/// ```
///
/// Batches can be nested and updates will be flushed when the outermost
/// batch call completes.
///
/// ```dart
/// import 'package:signals/signals.dart';
///
/// final counter = signal(0);
/// effect(() => print(counter.value));
///
/// batch(() {
/// 	batch(() {
/// 		// Signal is invalidated, but update is not flushed because
/// 		// we're still inside another batch
/// 		counter.value = 1;
/// 	});
///
/// 	// Still not updated...
/// });
/// // Now the callback completed and we'll trigger the effect.
/// ```
T batch<T>(BatchCallback<T> callback) {
  if (_batchDepth > 0) {
    return callback();
  }
  _startBatch();
  try {
    return callback();
  } finally {
    _endBatch();
  }
}
