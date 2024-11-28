import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/extended.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  SignalsObserver.instance = null;
  group('untrackedValue', () {
    test('single', () {
      final s = signal(0);
      int calls = 0;
      final dis = effect(() {
        s.value;
        s.untrackedValue + 1;
        calls++;
      });
      dis();

      expect(calls, 1);
    });

    test('nested', () {
      final s = signal(0);
      int calls = 0;
      final dis = effect(() {
        s.value;
        untracked(() => s.untrackedValue + 1);
        calls++;
      });
      dis();

      expect(calls, 1);
    });
  });
}
