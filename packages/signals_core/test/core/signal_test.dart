import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;

  group('signal', () {
    test('should work', () {
      final a = signal(0);
      final b = signal(0);

      final c = computed(() => a.value + b.value);

      a.dispose();

      b.value = 1;

      expect(c.value, 1);
      expect(b.value, 1);
      expect(b.initialValue, 0);
      expect(b.previousValue, 0);
    });

    test('lazy init', () {
      final a = signal(0);
      final b = lazySignal<int>();

      expect(a.value, 0);
      expect(() => b.value, throwsA(isA<LazySignalInitializationError>()));

      b.value = 0;

      expect(a.value, 0);
      expect(b.value, 0);
    });

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

    test('check sources', () {
      final a = signal<int>(0);
      final b = signal<int>(0);

      final instance = Effect(() {
        a.value;
      });

      expect(instance.sources.contains(a), true);
      expect(instance.sources.contains(b), false);
      expect(a.targets.contains(instance), true);
      expect(b.targets.contains(instance), false);
      expect(a.version, 0);

      a.value++;
      instance.dispose();

      expect(instance.sources.contains(a), false);
      expect(instance.sources.contains(b), false);
      expect(a.targets.contains(instance), false);
      expect(b.targets.contains(instance), false);
      expect(a.version, 1);
    });

    test('should return value', () {
      final v = [1, 2];
      final s = signal(v);
      expect(s.value, v);
      expect(s.get(), v);
      expect(s.toString(), v.toString());
      expect(s(), v);
      expect(s.toJson(), v);
      expect(s.peek(), v);
    });

    group('wrap', () {
      test('should match', () {
        final v = 0;
        final a = signal(v);
        final b = WrappedSignal(a);

        expect(a.value, v);
        expect(a.get(), v);
        expect(a.toString(), v.toString());
        expect(a(), v);
        expect(a.toJson(), v);
        expect(a.peek(), v);

        expect(b.value, v);
        expect(b.get(), v);
        expect(b.toString(), v.toString());
        expect(b(), v);
        expect(b.toJson(), v);
        expect(b.peek(), v);

        expect(a.globalId, b.globalId);
        expect(a.version, b.version);
        expect(a.initialValue, b.initialValue);
        expect(a.previousValue, b.previousValue);
        expect(a.targets, b.targets);
        expect(a.disposed, b.disposed);
        expect(a.autoDispose, b.autoDispose);
        expect(a.debugLabel, b.debugLabel);
        expect(a.readonly()(), b.readonly()());
        expect(a.overrideWith(1)(), b.overrideWith(1)());
      });

      test('disposed set', () {
        final v = 0;
        final a = signal(v);
        final b = WrappedSignal(a);

        b.disposed = true;

        expect(a.disposed, b.disposed);
      });

      test('dispose()', () {
        final v = 0;
        final a = signal(v);
        final b = WrappedSignal(a);

        b.dispose();

        expect(a.disposed, b.disposed);
      });

      test('onDispose()', () {
        final v = 0;
        final a = signal(v);
        final b = WrappedSignal(a);
        var called = false;

        b.onDispose(() => called = true);

        expect(called, false);

        b.dispose();

        expect(called, true);
        expect(a.disposed, b.disposed);
      });

      test('subscribe()', () {
        final v = 0;
        final a = signal(v);
        final b = WrappedSignal(a);
        bool called = false;

        expect(called, false);

        b.subscribe((val) => called = true);

        expect(called, true);
        expect(a.targets, b.targets);
      });

      test('forceUpdate()', () {
        final v = 0;
        final a = signal(v);
        final b = WrappedSignal(a);
        bool called = false;

        expect(called, false);
        expect(b.value, 0);

        b.subscribe((val) => called = true);
        b.set(force: true, 1);

        expect(called, true);
        expect(a.targets, b.targets);
        expect(b.value, 1);
      });

      test('set()', () {
        final v = 0;
        final a = signal(v);
        final b = WrappedSignal(a);
        bool called = false;

        expect(called, false);
        expect(b.value, 0);

        b.subscribe((val) => called = true);
        b.set(1);

        expect(called, true);
        expect(a.targets, b.targets);
        expect(b.value, 1);
      });

      test('set value', () {
        final v = 0;
        final a = signal(v);
        final b = WrappedSignal(a);
        bool called = false;

        expect(called, false);
        expect(b.value, 0);

        b.subscribe((val) => called = true);
        b.value = 1;

        expect(called, true);
        expect(a.targets, b.targets);
        expect(b.value, 1);
      });

      test('custom equality', () {
        final a = signal('s_2');
        final b = signal('s_1');

        expect(a.equalityCheck(a.value, b.value), false);

        a.equalityCheck = (a, b) {
          final aP = a.split('_').first;
          final bP = b.split('_').first;
          return aP == bP;
        };

        expect(a.equalityCheck(a.value, b.value), true);

        a.value = 's_3';

        expect(a.value, 's_2');
      });
    });

    test('overrideWith', () {
      final a = signal(1);
      expect(a.value, 1);
      a.overrideWith(2);
      expect(a.value, 2);
    });

    test('readonly', () {
      final a = signal(1);
      final b = a.readonly();

      // ignore: unnecessary_type_check
      expect(b is ReadonlySignal, true);
    });

    test('valueSignal', () {
      // ignore: deprecated_member_use_from_same_package
      final a = valueSignal(1);

      expect(a.value, 1);
    });

    test('forceUpdate', () {
      final a = signal(0);

      // ignore: deprecated_member_use_from_same_package
      a.forceUpdate(1);

      expect(a.value, 1);
    });

    test('should run the callback when the signal value changes', () {
      int calls = 0;
      void trigger(int val) => calls++;

      final a = signal(1);

      a.subscribe(trigger);

      a.value = 2;

      expect(calls, 2);
    });

    group('dispose', () {
      group('autoDispose', () {
        test('check last subscriber disposes', () {
          final s = signal(1, autoDispose: true);
          final dispose = s.subscribe((_) => {});
          expect(s.disposed, false);
          dispose();
          expect(s.disposed, true);
        });
        test('check last subscriber does not disposes', () {
          final s = signal(1, autoDispose: false);
          final dispose = s.subscribe((_) => {});
          expect(s.disposed, false);
          dispose();
          expect(s.disposed, false);
        });
      });

      test('check onDispose callback', () {
        int calls = 0;
        final v = [1, 2];
        final s = signal(v);
        s.onDispose(() => calls++);
        expect(s.value, v);
        s.dispose();
        expect(s.disposed, true);
        expect(calls, 1);
      });

      test('should remove dispose callback', () {
        final a = signal(10);
        var calls = 0;
        final cancel = a.onDispose(() => calls++);
        cancel();
        a.dispose();
        expect(calls, 0);
      });

      test('read/write after dispose should throw', () {
        int calls = 0;
        final v = [1, 2];
        final s = signal(v, autoDispose: true);
        s.onDispose(() => calls++);
        expect(s.value, v);
        final dispose = s.subscribe((_) => {});
        dispose();
        expect(s.disposed, true);
        expect(() => s.value = [3], throwsA(isA<SignalsError>()));
        // expect(() => s.value, throwsA(isA<SignalsError>()));
      });

      test('should autoDispose signal when it has no listeners', () {
        var count = signal(2, autoDispose: true);
        var multiple = signal(2);
        var product = computed(() => count() * multiple());

        expect(count.value, 2);
        expect(multiple.value, 2);
        expect(product.value, 4);

        count.onDispose(() => print('disposed count'));
        product.onDispose(() => print('disposed doubled'));

        count.value = 3;
        multiple.value = 3;

        expect(count.value, 3);
        expect(multiple.value, 3);
        expect(product.value, 9);

        // simulate widget listeners
        var unmount = effect(() {
          print('count: ${count.value}');
          print('product: ${product.value}');
        });

        // simulate widget unmount
        unmount();

        expect(count.disposed, isTrue);
        expect(multiple.disposed, isFalse);
        expect(product.disposed, isFalse);

        multiple.value = 4; // update signal that's not autoDisposed

        print('count: ${product.value}');

        expect(product.value, 12);
      });
    });

    test('should inherit from Signal', () {
      // ignore: unnecessary_type_check
      expect(signal(0) is Signal, true);
    });

    test('test as stream', () {
      final s = signal(0);
      final stream = s.toStream();

      s.value = 1;
      s.value = 2;
      s.value = 3;

      expect(stream, emitsInOrder([0, 1, 2, 3]));
    });

    test('test override', () {
      final s = signal(0).overrideWith(-1);

      final stream = s.toStream();

      s.value = 1;
      s.value = 2;
      s.value = 2; // check if skipped
      s.value = 3;

      expect(stream, emitsInOrder([-1, 1, 2, 3]));
    });

    test('should support .toString()', () {
      final s = signal(123);
      expect(s.toString(), '123');
    });

    test('should support .toJson()', () {
      final s = signal(123);
      expect(s.toJson(), 123);
    });

    test('should support jsonEncode()', () {
      final s = signal(123);
      expect(jsonEncode({'s': s}), jsonEncode({'s': 123}));
    });

    test('should support call()', () {
      final s = signal(123);
      expect(s(), 123);

      final a = signal(1);
      final b = signal(2);
      expect(a() + b(), 3);
    });

    test(
        'should notify other listeners of changes after one listener is disposed',
        () {
      final s = signal(123);

      int effectCount1 = 0;
      int effectCount2 = 0;
      int effectCount3 = 0;

      effect(() {
        effectCount1++;
        return s.value;
      });
      final dispose = effect(() {
        effectCount2++;
        return s.value;
      });
      effect(() {
        effectCount3++;
        return s.value;
      });

      expect(effectCount1, 1);
      expect(effectCount2, 1);
      expect(effectCount3, 1);

      dispose();

      s.value = 1;
      expect(effectCount1, 2);
      expect(effectCount2, 1);
      expect(effectCount3, 2);
    });

    group('.peek', () {
      test('should get value', () {
        final s = signal(1);
        expect(s.peek(), 1);
      });

      test('should get the updated value after a value change', () {
        final s = signal(1);
        s.value = 2;
        expect(s.peek(), 2);
      });

      test('should not make surrounding effect depend on the signal', () {
        final s = signal(1);
        int effectCount = 0;

        effect(() {
          effectCount++;
          s.peek();
        });
        expect(effectCount, 1);

        s.value = 2;
        expect(effectCount, 1);
      });

      test('should not make surrounding computed depend on the signal', () {
        final s = signal(1);
        int effectCount = 0;
        final d = computed(() {
          effectCount++;
          return s.peek();
        });

        d.value;
        expect(effectCount, 1);

        s.value = 2;
        d.value;

        expect(effectCount, 1);
      });
    });

    group('.subscribe', () {
      test('should subscribe to a signal', () async {
        final a = signal(1);
        final completer = Completer<int>();

        a.subscribe(completer.complete);

        final result = await completer.future;

        expect(result, 1);
      });

      test('should unsubscribe to a signal', () async {
        final a = signal(1);
        final completer = Completer<int>();

        final dispose = a.subscribe(completer.complete);
        dispose();

        final result = await completer.future;

        expect(result, 1);
      });
    });
  });
}
