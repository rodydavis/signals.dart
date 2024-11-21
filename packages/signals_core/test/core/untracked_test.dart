import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
  group('untracked', () {
    test('single', () {
      final s = signal(0);
      int calls = 0;
      final dis = effect(() {
        s.value;
        untracked(() => s.value + 1);
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
        untracked(() => untracked(() => s.value + 1));
        calls++;
      });
      dis();

      expect(calls, 1);
    });
  });
}
