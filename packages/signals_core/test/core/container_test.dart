import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
  group('signal container', () {
    test('create', () {
      final container = signalContainer<int, int>(signal);

      final a = container(0);
      final b = container(1);

      expect(a.value, 0);
      expect(b.value, 1);
      expect(container.store.length, 0);
    });

    test('cache', () {
      final container = signalContainer<int, int>(signal, cache: true);

      final a = container(0);
      final b = container(0);

      expect(a, b);
      expect(container.store.length, 1);
    });

    test('remove', () {
      final container = signalContainer<int, int>(signal, cache: true);

      container(0);
      container(1);

      expect(container.store.length, 2);

      container.remove(0);
      expect(container.store.length, 1);
    });

    test('containsKey', () {
      final container = signalContainer<int, int>(signal, cache: true);

      container(0);
      container(1);

      expect(container.store.length, 2);

      expect(container.containsKey(0), true);
      expect(container.containsKey(1), true);
      expect(container.containsKey(2), false);
    });

    test('clear', () {
      final container = signalContainer<int, int>(signal, cache: true);

      container(0);
      container(1);

      expect(container.store.length, 2);

      container.clear();
      expect(container.store.length, 0);
    });

    test('dispose', () {
      final container = signalContainer<int, int>(signal, cache: true);

      container(0);
      container(1);

      expect(container.store.length, 2);

      container.dispose();
      expect(container.store.length, 0);
    });

    test('effect loop', () {
      final counters = signalContainer<int, int>(
        (e) {
          return signal(e);
        },
        cache: true,
      );

      int count = 0;
      effect(() {
        print(counters(0).value);
        count++;
      });
      expect(count, 1);
    });
  });

  group('signal container (read-only)', () {
    test('create', () {
      final container = readonlySignalContainer<int, int>(signal);

      final a = container(0);
      final b = container(1);

      expect(a.value, 0);
      expect(b.value, 1);
      expect(container.store.length, 0);
    });

    test('cache', () {
      final container = readonlySignalContainer<int, int>(signal, cache: true);

      final a = container(0);
      final b = container(0);

      expect(a, b);
      expect(container.store.length, 1);
    });

    test('remove', () {
      final container = readonlySignalContainer<int, int>(signal, cache: true);

      container(0);
      container(1);

      expect(container.store.length, 2);

      container.remove(0);
      expect(container.store.length, 1);
    });

    test('containsKey', () {
      final container = readonlySignalContainer<int, int>(signal, cache: true);

      container(0);
      container(1);

      expect(container.store.length, 2);

      expect(container.containsKey(0), true);
      expect(container.containsKey(1), true);
      expect(container.containsKey(2), false);
    });

    test('clear', () {
      final container = readonlySignalContainer<int, int>(signal, cache: true);

      container(0);
      container(1);

      expect(container.store.length, 2);

      container.clear();
      expect(container.store.length, 0);
    });

    test('dispose', () {
      final container = readonlySignalContainer<int, int>(signal, cache: true);

      container(0);
      container(1);

      expect(container.store.length, 2);

      container.dispose();
      expect(container.store.length, 0);
    });
  });
}
