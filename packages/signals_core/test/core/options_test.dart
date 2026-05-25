import 'package:test/test.dart';
import 'package:signals_core/signals_core.dart';

void main() {
  group('Options Classes - copyWith, ==, hashCode', () {
    test('EffectOptions', () {
      const o1 = EffectOptions(name: 'a', autoDispose: true);
      const o2 = EffectOptions(name: 'a', autoDispose: true);
      const o3 = EffectOptions(name: 'b', autoDispose: false);

      expect(o1 == o2, isTrue);
      expect(o1 == o3, isFalse);
      expect(o1.hashCode == o2.hashCode, isTrue);
      expect(o1.hashCode == o3.hashCode, isFalse);

      final c1 = o1.copyWith(name: 'b', autoDispose: false);
      expect(c1, equals(o3));
    });

    test('ReadonlySignalOptions', () {
      void dummy1() {}
      void dummy2() {}

      final o1 = ReadonlySignalOptions<int>(
          name: 'a', autoDispose: true, watched: dummy1, unwatched: dummy2);
      final o2 = ReadonlySignalOptions<int>(
          name: 'a', autoDispose: true, watched: dummy1, unwatched: dummy2);
      final o3 = ReadonlySignalOptions<int>(
          name: 'b', autoDispose: false, watched: dummy2, unwatched: dummy1);

      expect(o1 == o2, isTrue);
      expect(o1 == o3, isFalse);
      expect(o1.hashCode == o2.hashCode, isTrue);

      final c1 = o1.copyWith(
          name: 'b', autoDispose: false, watched: dummy2, unwatched: dummy1);
      expect(c1, equals(o3));
    });

    test('SignalOptions', () {
      void dummy() {}

      final o1 = SignalOptions<int>(
          name: 'a', autoDispose: true, watched: dummy, unwatched: dummy);
      final o2 = SignalOptions<int>(
          name: 'a', autoDispose: true, watched: dummy, unwatched: dummy);
      final o3 = SignalOptions<int>(
          name: 'b', autoDispose: false, watched: dummy, unwatched: dummy);

      expect(o1 == o2, isTrue);
      expect(o1 == o3, isFalse);
      expect(o1.hashCode == o2.hashCode, isTrue);

      final c1 = o1.copyWith(name: 'b', autoDispose: false);
      expect(c1, equals(o3));
    });

    test('ComputedOptions', () {
      void dummy() {}

      final o1 = ComputedOptions<int>(
          name: 'a', autoDispose: true, watched: dummy, unwatched: dummy);
      final o2 = ComputedOptions<int>(
          name: 'a', autoDispose: true, watched: dummy, unwatched: dummy);
      final o3 = ComputedOptions<int>(
          name: 'b', autoDispose: false, watched: dummy, unwatched: dummy);

      expect(o1 == o2, isTrue);
      expect(o1 == o3, isFalse);
      expect(o1.hashCode == o2.hashCode, isTrue);

      final c1 = o1.copyWith(name: 'b', autoDispose: false);
      expect(c1, equals(o3));
    });

    test('AsyncSignalOptions', () {
      final s = signal(0);
      final o1 = AsyncSignalOptions<int>(
        initialValue: 1,
        dependencies: [s],
        lazy: true,
        cancelOnError: false,
        name: 'a',
        autoDispose: true,
      );
      final o2 = AsyncSignalOptions<int>(
        initialValue: 1,
        dependencies: [s],
        lazy: true,
        cancelOnError: false,
        name: 'a',
        autoDispose: true,
      );
      final o3 = AsyncSignalOptions<int>(
        initialValue: 2,
        dependencies: [],
        lazy: false,
        cancelOnError: true,
        name: 'b',
        autoDispose: false,
      );

      expect(o1 == o2, isTrue);
      expect(o1 == o3, isFalse);
      expect(o1.hashCode == o2.hashCode, isTrue);

      final c1 = o1.copyWith(
        initialValue: 2,
        dependencies: [],
        lazy: false,
        cancelOnError: true,
        name: 'b',
        autoDispose: false,
      );
      expect(c1, equals(o3));
    });

    test('LinkedSignalOptions', () {
      int comp1(int s, prev) => s;
      int comp2(int s, prev) => s * 2;
      bool eq1(int a, int b) => a == b;

      final o1 = LinkedSignalOptions<int, int>(
        computation: comp1,
        sourceEquality: eq1,
        name: 'a',
        autoDispose: true,
      );
      final o2 = LinkedSignalOptions<int, int>(
        computation: comp1,
        sourceEquality: eq1,
        name: 'a',
        autoDispose: true,
      );
      final o3 = LinkedSignalOptions<int, int>(
        computation: comp2,
        sourceEquality: eq1,
        name: 'b',
        autoDispose: false,
      );

      expect(o1 == o2, isTrue);
      expect(o1 == o3, isFalse);
      expect(o1.hashCode == o2.hashCode, isTrue);

      final c1 = o1.copyWith(
        computation: comp2,
        name: 'b',
        autoDispose: false,
      );
      expect(c1, equals(o3));
    });

    test('PersistedSignalOptions', () {
      const o1 = PersistedSignalOptions<int>(name: 'a', autoDispose: true);
      const o2 = PersistedSignalOptions<int>(name: 'a', autoDispose: true);
      const o3 = PersistedSignalOptions<int>(name: 'b', autoDispose: false);

      expect(o1 == o2, isTrue);
      expect(o1 == o3, isFalse);
      expect(o1.hashCode == o2.hashCode, isTrue);

      final c1 = o1.copyWith(name: 'b', autoDispose: false);
      expect(c1, equals(o3));
    });

    test('ChangeSignalOptions', () {
      const o1 =
          ChangeSignalOptions<int>(limit: 10, name: 'a', autoDispose: true);
      const o2 =
          ChangeSignalOptions<int>(limit: 10, name: 'a', autoDispose: true);
      const o3 =
          ChangeSignalOptions<int>(limit: 5, name: 'b', autoDispose: false);

      expect(o1 == o2, isTrue);
      expect(o1 == o3, isFalse);
      expect(o1.hashCode == o2.hashCode, isTrue);

      final c1 = o1.copyWith(limit: 5, name: 'b', autoDispose: false);
      expect(c1, equals(o3));
    });

    test('IterableSignalOptions', () {
      const o1 = IterableSignalOptions<int>(name: 'a', autoDispose: true);
      const o2 = IterableSignalOptions<int>(name: 'a', autoDispose: true);
      const o3 = IterableSignalOptions<int>(name: 'b', autoDispose: false);

      expect(o1 == o2, isTrue);
      expect(o1 == o3, isFalse);
      expect(o1.hashCode == o2.hashCode, isTrue);

      final c1 = o1.copyWith(name: 'b', autoDispose: false);
      expect(c1, equals(o3));
    });

    test('ListSignalOptions', () {
      const o1 = ListSignalOptions<int>(name: 'a', autoDispose: true);
      const o2 = ListSignalOptions<int>(name: 'a', autoDispose: true);
      const o3 = ListSignalOptions<int>(name: 'b', autoDispose: false);

      expect(o1 == o2, isTrue);
      expect(o1 == o3, isFalse);
      expect(o1.hashCode == o2.hashCode, isTrue);

      final c1 = o1.copyWith(name: 'b', autoDispose: false);
      expect(c1, equals(o3));
    });

    test('MapSignalOptions', () {
      const o1 = MapSignalOptions<int, String>(name: 'a', autoDispose: true);
      const o2 = MapSignalOptions<int, String>(name: 'a', autoDispose: true);
      const o3 = MapSignalOptions<int, String>(name: 'b', autoDispose: false);

      expect(o1 == o2, isTrue);
      expect(o1 == o3, isFalse);
      expect(o1.hashCode == o2.hashCode, isTrue);

      final c1 = o1.copyWith(name: 'b', autoDispose: false);
      expect(c1, equals(o3));
    });

    test('QueueSignalOptions', () {
      const o1 = QueueSignalOptions<int>(name: 'a', autoDispose: true);
      const o2 = QueueSignalOptions<int>(name: 'a', autoDispose: true);
      const o3 = QueueSignalOptions<int>(name: 'b', autoDispose: false);

      expect(o1 == o2, isTrue);
      expect(o1 == o3, isFalse);
      expect(o1.hashCode == o2.hashCode, isTrue);

      final c1 = o1.copyWith(name: 'b', autoDispose: false);
      expect(c1, equals(o3));
    });

    test('SetSignalOptions', () {
      const o1 = SetSignalOptions<int>(name: 'a', autoDispose: true);
      const o2 = SetSignalOptions<int>(name: 'a', autoDispose: true);
      const o3 = SetSignalOptions<int>(name: 'b', autoDispose: false);

      expect(o1 == o2, isTrue);
      expect(o1 == o3, isFalse);
      expect(o1.hashCode == o2.hashCode, isTrue);

      final c1 = o1.copyWith(name: 'b', autoDispose: false);
      expect(c1, equals(o3));
    });

    test('TrackedSignalOptions', () {
      const o1 = TrackedSignalOptions<int>(name: 'a', autoDispose: true);
      const o2 = TrackedSignalOptions<int>(name: 'a', autoDispose: true);
      const o3 = TrackedSignalOptions<int>(name: 'b', autoDispose: false);

      expect(o1 == o2, isTrue);
      expect(o1 == o3, isFalse);
      expect(o1.hashCode == o2.hashCode, isTrue);

      final c1 = o1.copyWith(name: 'b', autoDispose: false);
      expect(c1, equals(o3));
    });
  });
}
