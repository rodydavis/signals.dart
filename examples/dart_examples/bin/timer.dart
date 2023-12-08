import 'package:signals/signals.dart';

main() {
  final timer = Duration(milliseconds: 2000).toSignal(cancelOnError: true);

  effect(() {
    final tick = timer();
    final dateTime = DateTime.fromMillisecondsSinceEpoch(tick.millis);
    print("$tick => ${dateTime.hour}:${dateTime.minute}:${dateTime.second}");
  });
}
