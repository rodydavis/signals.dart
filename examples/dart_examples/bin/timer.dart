import 'package:signals/signals.dart';

main() {
  final timer = Duration(milliseconds: 2000).toSignal(cancelOnError: true);

  effect(() {
    final on = timer();

    if (on != null) {
      print(on);
      var dateTime = DateTime.fromMillisecondsSinceEpoch(on.millis);
      print("${dateTime.hour}:${dateTime.minute}:${dateTime.second}");
    }
  });
}
