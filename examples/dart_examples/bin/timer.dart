import 'package:signals/signals.dart';

/// Trigger [TimerSignalEvent]
main() {
  SignalsObserver.instance = LoggingSignalsObserver();
  final timer = TimerSignal(every: Duration(seconds: 1));

  effect(() {
    // Receive a TimerSignalEvent
    final tick = timer();
    final dateTime = DateTime.fromMillisecondsSinceEpoch(tick.millis);
    print("$tick => ${dateTime.hour}:${dateTime.minute}:${dateTime.second}");
  });
}
