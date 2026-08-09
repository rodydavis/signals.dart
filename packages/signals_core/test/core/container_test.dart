import 'dart:async';
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
      expect(container.store.disposed, true);
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
      expect(container.store.disposed, true);
    });

    test('Map/Collection-like APIs', () {
      final container = signalContainer<int, int>(signal, cache: true);

      expect(container.isEmpty, true);
      expect(container.isNotEmpty, false);
      expect(container.length, 0);

      container(10);
      container(20);

      expect(container.isEmpty, false);
      expect(container.isNotEmpty, true);
      expect(container.length, 2);

      expect(container.keys, containsAll([10, 20]));
      expect(container.values.map((s) => s.value), containsAll([10, 20]));
      expect(container.entries.map((e) => e.key), containsAll([10, 20]));

      expect(container.lookup(10)?.value, 10);
      expect(container.lookup(30), null);

      container.removeWhere((key, signal) => key == 10);
      expect(container.length, 1);
      expect(container.containsKey(10), false);
      expect(container.containsKey(20), true);
    });

    test('onEvict callback', () {
      final evicted = <int, Signal<int>>{};
      final container = signalContainer<int, int>(
        signal,
        cache: true,
        onEvict: (key, sig) {
          evicted[key] = sig;
        },
      );

      final a = container(5);
      final b = container(10);

      container.remove(5);
      expect(evicted.length, 1);
      expect(evicted[5], a);

      container.clear();
      expect(evicted.length, 2);
      expect(evicted[10], b);
    });

    test('computedContainer', () {
      final source = signal(2);
      final container = computedContainer<int, int>(
        (multiplier) => computed(() => source.value * multiplier),
        cache: true,
      );

      final c = container(3);
      expect(c.value, 6);

      source.value = 5;
      expect(c.value, 15);
    });

    test('futureSignalContainer', () async {
      final container = futureSignalContainer<int, int>(
        (val) => futureSignal(() async => val * 2),
        cache: true,
      );

      final f = container(4);
      await f.future;
      expect(f.value.value, 8);
    });

    test('streamSignalContainer', () async {
      final controller = StreamController<int>();
      final container = streamSignalContainer<int, int>(
        (val) => streamSignal(() => controller.stream),
        cache: true,
      );

      final s = container(1);
      s.value; // Access value to trigger stream subscription
      controller.add(42);
      // Wait for stream event propagation
      await Future.delayed(Duration(milliseconds: 20));
      expect(s.value.value, 42);
      await controller.close();
    });

    test('mutationSignalContainer', () async {
      // Arg = String (cache key / mutation argument), result = int.
      final container = mutationSignalContainer<String, int, String>(
        (key) => mutationSignal<String, int>((name) async => name.length),
        cache: true,
      );

      final m = container('save-a');
      // Same key returns the cached instance.
      expect(identical(container('save-a'), m), isTrue);
      // Different key returns a different instance.
      expect(identical(container('save-b'), m), isFalse);

      expect(m.peek(), isA<MutationIdle<int>>());
      final result = await m.mutateAsync('hello');
      expect(result, 5);
      expect(m.peek(), isA<MutationSuccess<int>>());
      expect(m.peek().requireValue, 5);
    });

    test('mutationSignalContainer eviction and lookup', () {
      final evicted = <String>[];
      final container = mutationSignalContainer<void, int, String>(
        (key) => mutationSignal<void, int>((_) async => 1),
        cache: true,
        onEvict: (key, signal) => evicted.add(key),
      );

      final a = container('a');
      expect(container.containsKey('a'), isTrue);
      expect(container.lookup('a'), same(a));
      expect(container.lookup('missing'), isNull);

      container.remove('a');
      expect(container.containsKey('a'), isFalse);
      expect(evicted, ['a']);
    });
  });
}
