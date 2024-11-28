part of 'value.dart';

/// A [Signal] that holds a [Queue].
class QueueSignal<T> extends Signal<Queue<T>>
    with QueueSignalMixin<T, Queue<T>>
    implements Queue<T> {
  /// Creates a [QueueSignal] with the given [value].
  QueueSignal(
    super.value, {
    super.debugLabel,
    super.autoDispose,
  });
}

/// Create an [QueueSignal] from [Queue]
QueueSignal<T> queueSignal<T>(
  Queue<T> list, {
  String? debugLabel,
  bool autoDispose = false,
}) {
  return QueueSignal<T>(
    list,
    debugLabel: debugLabel,
    autoDispose: autoDispose,
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
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }
}
