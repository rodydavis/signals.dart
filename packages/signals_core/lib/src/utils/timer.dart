import 'package:signals_core/signals_core.dart';

/// Time event to react to
typedef TimerSignalEvent = ({int iteration, int millis});

/// Emit recurring [TimerSignalEvent] aka [AsyncSignal]
class TimerSignal extends StreamSignal<TimerSignalEvent> {
  // Trigger an [TimerEvent] every duration
  final Duration every;

  TimerSignal({
    required this.every,
    String super.debugLabel = 'Timer',
    super.cancelOnError,
    super.autoDispose,
    super.equality,
  }) : super(
          () => Stream<TimerSignalEvent>.periodic(
            every,
            (c) => _emit(c + 1),
          ),
          initialValue: _emit(0),
        );

  static TimerSignalEvent _emit(int count) => (
        iteration: count,
        millis: DateTime.now().millisecondsSinceEpoch,
      );
}

/// Expose Duration as a [TimerSignal]
extension TimerSignalDurationUtils on Duration {
  TimerSignal toSignal({
    String debugLabel = 'Timer',
    bool? cancelOnError,
    bool autoDispose = false,
    SignalEquality<AsyncState<TimerSignalEvent>>? equality,
  }) {
    return TimerSignal(
      every: this,
      debugLabel: debugLabel,
      cancelOnError: cancelOnError,
      autoDispose: autoDispose,
      equality: equality,
    );
  }
}

/// Create a [TimerSignal]
TimerSignal timerSignal(
  Duration every, {
  String debugLabel = 'Timer',
  bool? cancelOnError,
  bool autoDispose = false,
  SignalEquality<AsyncState<TimerSignalEvent>>? equality,
}) {
  return TimerSignal(
    every: every,
    debugLabel: debugLabel,
    cancelOnError: cancelOnError,
    autoDispose: autoDispose,
    equality: equality,
  );
}
