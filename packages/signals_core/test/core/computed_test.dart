import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
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

    test('readonly', () {
      final a = computed(() => 1);
      final b = a.readonly();

      // ignore: unnecessary_type_check
      expect(b is ReadonlySignal, true);
    });

    test('check sources', () {
      final c = signal<int>(0);
      final a = computed<int>(() => c.value);
      final b = computed<int>(() => c.value);

      final instance = Effect(() {
        a.value;
      });

      expect(instance.sources.contains(a), true);
      expect(instance.sources.contains(b), false);
      expect(a.targets.contains(instance), true);
      expect(b.targets.contains(instance), false);
      expect(a.sources.contains(c), true);

      instance.disposed = true;

      expect(instance.sources.contains(a), false);
      expect(instance.sources.contains(b), false);
      expect(a.targets.contains(instance), false);
      expect(b.targets.contains(instance), false);
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

    test('test as stream', () {
      final a = signal(0);
      final s = computed(() => a());
      final stream = s.toStream();

      a.value = 1;
      a.value = 2;
      a.value = 3;

      expect(stream, emitsInOrder([0, 1, 2, 3]));
    });

    test('test override', () {
      final a = signal(0);
      final s = computed(() => a()).overrideWith(-1);

      final stream = s.toStream();

      a.value = 1;
      a.value = 2;
      a.value = 2; // check if skipped
      a.value = 3;

      expect(stream, emitsInOrder([-1, 1, 2, 3]));
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

    test('error in callback', () {
      final s = computed(() => throw Exception('error'));

      expect(() => s.recompute(), throwsException);
    });

    test('previousValue', () {
      int i = 0;
      final s = computed(() => i++);
      s.recompute();
      s.recompute();
      expect(s.previousValue, 1);
      expect(s.value, 2);
    });

    test('initialValue', () {
      final s = computed(() => 1);
      expect(s.value, 1);
      expect(s.initialValue, 1);
    });

    test('toString()', () {
      final s = computed(() => 1);
      expect(s.toString(), '1');
    });

    test('toJson()', () {
      final s = computed(() => 1);
      expect(s.toJson(), 1);
    });

    test('call()', () {
      final s = computed(() => 1);
      expect(s(), 1);
    });

    test('get()', () {
      final s = computed(() => 1);
      expect(s.get(), 1);
    });

    test('peek()', () {
      final s = computed(() => 1);
      s.recompute();
      expect(s.peek(), 1);
    });

    group('cycle error', () {
      test('.value', () {
        final a = signal(1);
        final b = computed(() => a.value++);

        a.value = 2;

        expect(() => b.value, throwsA(isA<MutationDetectedError>()));
      });

      test('.peek()', () {
        final a = signal(1);
        final b = computed(() => a.value++);

        expect(() => b.peek(), throwsA(isA<Error>()));
      });

      test('should throw when evaluation throws', () {
        final s = computed(() => throw Error());

        expect(() => s.peek(), throwsA(isA<Error>()));
      });

      test(
          "should throw when previous evaluation threw and dependencies haven't changed",
          () {
        final s = computed(() => throw Error());

        expect(() => s.value, throwsA(isA<Error>()));
        expect(() => s.peek(), throwsA(isA<Error>()));
      });

      test('read after disposed', () {
        final b = computed(() => 1);
        b.value;
        b.dispose();
        expect(
          () => b.value,
          prints(contains('computed warning:')),
        );
      });

      test('cycle after first read', () {
        final cycle = signal(false);
        final a = signal(0);
        final b = computed(() => cycle.value ? a.value++ : 0);
        b.value;
        cycle.value = true;
        expect(() => b.value, throwsA(isA<MutationDetectedError>()));
      });
    });
  });
}
