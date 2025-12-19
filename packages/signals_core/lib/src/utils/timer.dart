import '../../signals_core.dart';

/// Time event to react to
typedef TimerSignalEvent = ({int iteration, int millis});

/// Emit recurring [TimerSignalEvent] aka [AsyncSignal]
/// Emit recurring [TimerSignalEvent] aka [AsyncSignal]
class TimerSignal extends StreamSignal<TimerSignalEvent> {
  /// Trigger an [TimerSignalEvent] every duration
  final Duration every;

  /// Emit recurring [TimerSignalEvent] aka [AsyncSignal]
  TimerSignal(
    this.every, {
    StreamSignalOptions<TimerSignalEvent>? options,
  }) : super(
          () => Stream<TimerSignalEvent>.periodic(
            every,
            (c) => (iteration: c + 1, millis: (c + 1) * every.inMilliseconds),
          ),
          options: (options ?? StreamSignalOptions<TimerSignalEvent>())
              .copyWith(initialValue: (iteration: 0, millis: 0)),
        );
}

/// Create a timer signal
TimerSignal timerSignal(
  Duration duration, {
  StreamSignalOptions<TimerSignalEvent>? options,
}) {
  return TimerSignal(
    duration,
    options: options,
  );
}

/// Extension on duration to provide helpful methods for signals
extension SignalTimerUtils on Duration {
  /// Convert a duration to a timer signal
  TimerSignal toSignal({
    StreamSignalOptions<TimerSignalEvent>? options,
  }) {
    return TimerSignal(
      this,
      options: options,
    );
  }
}
