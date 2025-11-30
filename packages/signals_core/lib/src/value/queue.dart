part of 'value.dart';

/// A [Signal] that holds a [Queue].
class QueueSignal<T> extends Signal<Queue<T>>
    with QueueSignalMixin<T, Queue<T>>
    implements Queue<T> {
  /// Creates a [QueueSignal] with the given [value].
  QueueSignal(
    super.value, {
    super.options,
  });
}

/// Create an [QueueSignal] from [Queue]
QueueSignal<T> queueSignal<T>(
  Queue<T> queue, {
  String? debugLabel,
  bool autoDispose = false,
  SignalOptions<Queue<T>>? options,
}) {
  return QueueSignal<T>(
    queue,
    options: options ??
        SignalOptions<Queue<T>>(
          name: debugLabel,
          autoDispose: autoDispose,
        ),
  );
}

/// Extension on future to provide helpful methods for signals
extension SignalQueueUtils<T> on Queue<T> {
  /// Convert an existing list to [QueueSignal]
  QueueSignal<T> toSignal({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return QueueSignal(
      this,
      options: SignalOptions<Queue<T>>(
        name: debugLabel,
        autoDispose: autoDispose,
      ),
    );
  }
}
