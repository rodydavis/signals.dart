import 'package:signals/signals.dart';

/// Trigger [TimerSignalEvent]
main() {
  final timer = TimerSignal(every: Duration(seconds: 1));

  effect(() {
    // Receive a TimerSignalEvent
    final tick = timer().requireValue;
    final dateTime = DateTime.fromMillisecondsSinceEpoch(tick.millis);
    print("$tick => ${dateTime.hour}:${dateTime.minute}:${dateTime.second}");
  });
}
