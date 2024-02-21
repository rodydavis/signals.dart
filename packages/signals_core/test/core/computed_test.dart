import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  group('computed', () {
    test('init', () {
      // Create signals
      final count = signal(0);
      final multiplier = signal(2);

      // Creating a computed value
      final multipliedCount = computed(() {
        return count.value * multiplier.value;
      });

      expect(multipliedCount.value, 0);

      count.value = 1;
      expect(multipliedCount.value, 2);

      multiplier.value = 3;
      expect(multipliedCount.value, 3);
    });

    group('dispose', () {
      test('check onDispose callback', () {
        int calls = 0;
        final v = [1, 2];
        final a = signal(v);
        final s = computed(() => a());
        s.onDispose(() => calls++);
        expect(s.value, v);
        s.dispose();
        expect(s.disposed, true);
        expect(calls, 1);
      });
    });
    group('autoDispose', () {
      test('check last subscriber disposes', () {
        final s = computed(() => 1, autoDispose: true);
        final dispose = s.subscribe((_) => {});
        expect(s.disposed, false);
        dispose();
        expect(s.disposed, true);
      });
      test('check last subscriber does not disposes', () {
        final s = computed(() => 1, autoDispose: false);
        final dispose = s.subscribe((_) => {});
        expect(s.disposed, false);
        dispose();
        expect(s.disposed, false);
      });
    });

    test('recompute', () {
      final now = computed(() => DateTime.now());
      final first = now.value;
      now.recompute();
      final second = now.value;
      expect(first != second, true);
    });

    test('overrideWith', () {
      final a = signal(1);
      final b = signal(2);
      final c = computed(() => a() + b());
      expect(c.value, 3);
      c.overrideWith(10);
      expect(c.value, 10);
    });

    test('should respect force set', () {
      final a = signal(1);
      final b = computed(() => a());
      var aCalled = 0;
      var bCalled = 0;

      a.subscribe((_) => aCalled++);
      b.subscribe((_) => bCalled++);

      expect(b.value, 1);
      expect(aCalled, 1);
      expect(bCalled, 1);

      a.value = 10;
      expect(b.value, 10);
      expect(aCalled, 2);
      expect(bCalled, 2);

      a.set(10, force: true);
      expect(b.value, 10);
      expect(aCalled, 3);
      expect(bCalled, 2); // 2 because the value is the same
    });

    test('check if value is the same and cached', () {
      final a = signal(1);
      final b = signal(0);
      final c = computed(() => a() * b());

      final values = <int>[];

      final dispose = effect(() {
        print('c: ${c.value}');
        values.add(c.value);
      });

      a.value = 2;
      b.value = 3;

      dispose();

      expect(values, [0, 6]);
    });
  });
}
