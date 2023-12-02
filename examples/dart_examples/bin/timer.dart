import 'package:signals/signals.dart';

main() {
  final timer = Duration(milliseconds: 800).toSignal(cancelOnError: true);

  effect(() {
    final on = timer();

    print(on);
  });
}
