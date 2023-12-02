import '../stream_signal.dart';

/// Time event to react to
typedef TimerEvent = ({int iteration, int millis});

/// Emit recurring [TimerEvent] aka [StreamSignal]
class Timer extends StreamSignal<TimerEvent> {
  // Trigger an [TimerEvent] every duration
  final Duration every;

  Timer({
    required this.every,
    super.cancelOnError,
    super.fireImmediately = false,
    super.debugLabel = 'Timer',
  }) : super(() => Stream<TimerEvent>.periodic(every, (c) => _emit(c + 1)),
            initial: _emit(0));

  static TimerEvent _emit(int count) =>
      (iteration: count, millis: DateTime.now().millisecondsSinceEpoch);
}

/// Expose Duration as a [Timer]
extension TimerExtension on Duration {
  Timer toSignal(
          {String? debugLabel,
          bool fireImmediately = false,
          bool? cancelOnError}) =>
      Timer(
        every: this,
        debugLabel: debugLabel,
        fireImmediately: fireImmediately,
        cancelOnError: cancelOnError,
      );
}
