import '../../signals.dart';

/// Time event to react to
typedef TimerSignalEvent = ({int iteration, int millis});

/// Emit recurring [TimerSignalEvent] aka [StreamSignal]
class TimerSignal extends StreamSignal<TimerSignalEvent> {
  // Trigger an [TimerEvent] every duration
  final Duration every;

  TimerSignal({
    required this.every,
    super.cancelOnError,
    super.fireImmediately = false,
    super.debugLabel = 'Timer',
  }) : super(
            () => Stream<TimerSignalEvent>.periodic(every, (c) => _emit(c + 1)),
            initial: _emit(0));

  static TimerSignalEvent _emit(int count) =>
      (iteration: count, millis: DateTime.now().millisecondsSinceEpoch);
}

/// Expose Duration as a [TimerSignal]
extension TimerExtension on Duration {
  TimerSignal toSignal(
          {String? debugLabel,
          bool fireImmediately = false,
          bool? cancelOnError}) =>
      TimerSignal(
        every: this,
        debugLabel: debugLabel,
        fireImmediately: fireImmediately,
        cancelOnError: cancelOnError,
      );
}
