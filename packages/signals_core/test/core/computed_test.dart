import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
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

  group('computed', () {
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
  });
}
