import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
  group('batch', () {
    test('single call', () {
      int calls = 0;

      final a = signal(0);
      final b = signal(0);
      final c = signal(0);

      effect(() {
        calls++;
        a();
        b();
        c();
      });

      batch(() {
        a.value = 1;
        b.value = 2;
        c.value = 3;
      });

      expect(calls, 2);
    });

    test('nested batch', () {
      int calls = 0;

      final a = signal(0);
      final b = signal(0);
      final c = signal(0);

      effect(() {
        calls++;
        a();
        b();
        c();
      });

      batch(() {
        a.value = 1;
        b.value = 2;
        batch(() {
          c.value = 3;
        });
      });

      expect(calls, 2);
    });
  });
}
