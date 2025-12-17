import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  testWidgets('ValueListenable.toSignal() disposes listener', (tester) async {
    final listenable = ValueNotifier(0);
    final signal = listenable.toSignal();

    var count = 0;
    effect(() {
      count = signal.value;
    });

    expect(count, 0);

    listenable.value = 1;
    await tester.pump();
    expect(count, 1);

    signal.dispose();

    listenable.value = 2;
    await tester.pump();
    expect(count, 1);
  });
}
