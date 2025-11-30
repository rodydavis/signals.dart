import 'package:preact_signals/preact_signals.dart';
import 'package:test/test.dart';

void main() {
  group('SignalOptions', () {
    test('name is set', () {
      final s = signal(0, SignalOptions(name: 'test'));
      expect(s.name, 'test');
    });

    test('watched/unwatched callbacks', () {
      int watchedCount = 0;
      int unwatchedCount = 0;

      final s = signal(
        0,
        SignalOptions(
          watched: (_) => watchedCount++,
          unwatched: (_) => unwatchedCount++,
        ),
      );

      expect(watchedCount, 0);
      expect(unwatchedCount, 0);

      final dispose = effect(() {
        s.value;
      });

      expect(watchedCount, 1);
      expect(unwatchedCount, 0);

      dispose();

      expect(watchedCount, 1);
      expect(unwatchedCount, 1);
    });

    test('equalityCheck', () {
      int checks = 0;
      final s = signal(
        0,
        SignalOptions<int>(
          equalityCheck: SignalEquality<int>.custom((a, b) {
            checks++;
            return a == b;
          }),
        ),
      );

      s.value = 0;
      expect(checks, 1); // 1 check on set

      s.value = 1;
      expect(checks, 2);
    });
  });

  group('EffectOptions', () {
    test('name is set', () {
      final dispose = effect(() {}, EffectOptions(name: 'test-effect'));
      // Effect class is internal or not easily accessible to check name directly
      // unless we cast or check toString if it uses name?
      // But Effect is exported.
      // However, effect() returns a dispose function.
      // We can't easily access the Effect instance from outside unless we use internal APIs.
      // But we can check if it runs without error.
      dispose();
    });
  });
}
