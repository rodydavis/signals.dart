import 'package:signals_core/signals_core.dart';
import 'package:signals_macro/signals_macro.dart';

void main() {
  final h = Handler();

  effect(() {
    print(h.valueSignal);
  });
}

class Handler {
  @Signalable()
  String value = '';

  Handler();
}
