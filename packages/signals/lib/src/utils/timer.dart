import '../../signals.dart';

/// Time event to react to
typedef TimerSignalEvent = ({int iteration, int millis});

/// Emit recurring [TimerSignalEvent] aka [AsyncSignal]
class TimerSignal extends AsyncSignal<TimerSignalEvent> {
  // Trigger an [TimerEvent] every duration
  final Duration every;

  TimerSignal({
    required this.every,
    String debugLabel = 'Timer',
    bool? cancelOnError,
  }) : super.fromStream(
          () => Stream<TimerSignalEvent>.periodic(every, (c) => _emit(c + 1)),
          initialValue: _emit(0),
          cancelOnError: cancelOnError,
          debugLabel: debugLabel,
        );

  static TimerSignalEvent _emit(int count) =>
      (iteration: count, millis: DateTime.now().millisecondsSinceEpoch);
}

/// Expose Duration as a [TimerSignal]
extension TimerSignalDurationUtils on Duration {
  TimerSignal toSignal({String debugLabel = 'Timer', bool? cancelOnError}) =>
      TimerSignal(
        every: this,
        debugLabel: debugLabel,
        cancelOnError: cancelOnError,
      );
}
