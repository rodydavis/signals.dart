part of 'value.dart';

/// A [Signal] that holds a [Queue].
class QueueSignal<T> extends Signal<Queue<T>>
    with QueueSignalMixin<T, Queue<T>>
    implements Queue<T> {
  /// Creates a [QueueSignal] with the given [value].
  /// Creates a [QueueSignal] with the given [value].
  QueueSignal(
    super.value, {
    super.options,
  });
}

/// Create an [QueueSignal] from [Queue]
QueueSignal<T> queueSignal<T>(
  Queue<T> list, {
  SignalOptions<Queue<T>>? options,
}) {
  return QueueSignal<T>(
    list,
    options: options,
  );
}

/// Extension on future to provide helpful methods for signals
extension SignalQueueUtils<T> on Queue<T> {
  /// Convert an existing list to [QueueSignal]
  QueueSignal<T> toSignal({
    SignalOptions<Queue<T>>? options,
  }) {
    return QueueSignal(
      this,
      options: options,
    );
  }
}
