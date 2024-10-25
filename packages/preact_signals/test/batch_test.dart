// ignore_for_file: unnecessary_type_check

import 'package:test/test.dart';
import 'package:preact_signals/preact_signals.dart';

import 'utils/spy.dart';

void main() {
  group('batch/transaction', () {
    test('should return the value from the callback', () {
      expect(batch(() => 1), 1);
    });

    test('should throw errors thrown from the callback', () {
      expect(() {
        batch(() {
          throw Exception('hello');
        });
      }, throwsException);
    });

    test('should throw non-errors thrown from the callback', () {
      try {
        batch(() {
          throw 'error';
        });
      } catch (e) {
        expect(e, 'error');
      }
    });

    test('should delay writes', () {
      final a = signal('a');
      final b = signal('b');
      final spy = Spy(() => '${a.value} ${b.value}');
      effect(spy.call);
      spy.resetHistory();

      batch(() {
        a.value = 'aa';
        b.value = 'bb';
      });

      expect(spy.calls, 1);
    });

    test('should delay writes until outermost batch is complete', () {
      final a = signal('a');
      final b = signal('b');
      final spy = Spy(() => '${a.value}, ${b.value}');
      effect(spy.call);
      spy.resetHistory();

      batch(() {
        batch(() {
          a.value += ' inner';
          b.value += ' inner';
        });
        a.value += ' outer';
        b.value += ' outer';
      });

      expect(spy.calls, 1);
    });

    test('should read signals written to', () {
      final a = signal('a');

      var result = '';
      batch(() {
        a.value = 'aa';
        result = a.value;
      });

      expect(result, 'aa');
    });

    test('should read computed signals with updated source signals', () {
      final a = signal('a');
      final b = computed(() => a.value);

      final spyC = Spy(() => b.value);
      final c = computed(spyC.call);

      final spyD = Spy(() => c.value);
      final d = computed(spyD.call);

      final spyE = Spy(() => d.value);
      final e = computed(spyE.call);

      spyC.resetHistory();
      spyD.resetHistory();
      spyE.resetHistory();

      var result = '';
      batch(() {
        a.value = 'aa';
        result = c.value;

        expect(spyD.calls, 0);
      });

      expect(result, 'aa');
      expect(d.value, 'aa');
      expect(e.value, 'aa');
      expect(spyC.calls, 1);
      expect(spyD.calls, 1);
      expect(spyE.calls, 1);
    });

    test('should not block writes after batching completed', () {
      final a = signal('a');
      final b = signal('b');
      final c = signal('c');
      final d = computed(() => '$a $b $c');

      var result = '';
      effect(() {
        result = d.value;
      });

      batch(() {
        a.value = 'aa';
        b.value = 'bb';
      });
      c.value = 'cc';
      expect(result, 'aa bb cc');
    });

    test('should not lead to stale signals with .value in batch', () {
      final invokes = <List<int>>[];
      final counter = signal(0);
      final double = computed(() => counter.value * 2);
      final triple = computed(() => counter.value * 3);

      effect(() {
        invokes.add([double.value, triple.value]);
      });

      expect(invokes, [
        [0, 0],
      ]);

      batch(() {
        counter.value = 1;
        expect(double.value, 2);
      });

      expect(invokes[1], [2, 3]);
    });

    test('should not lead to stale signals with peek() in batch', () {
      final invokes = <List<int>>[];
      final counter = signal(0);
      final double = computed(() => counter.value * 2);
      final triple = computed(() => counter.value * 3);

      effect(() {
        invokes.add([double.value, triple.value]);
      });

      expect(invokes, [
        [0, 0],
      ]);

      batch(() {
        counter.value = 1;
        expect(double.peek(), 2);
      });

      expect(invokes[1], [2, 3]);
    });

    test('should run pending effects even if the callback throws', () {
      final a = signal(0);
      final b = signal(1);
      final spy1 = Spy(() {
        a.value;
      });
      final spy2 = Spy(() {
        b.value;
      });
      effect(spy1.call);
      effect(spy2.call);
      spy1.resetHistory();
      spy2.resetHistory();

      expect(() {
        batch(() {
          a.value++;
          b.value++;
          throw Exception('hello');
        });
      }, throwsException);

      expect(spy1.calls, 1);
      expect(spy2.calls, 1);
    });

    test('should run pending effects even if some effects throw', () {
      final a = signal(0);
      final spy1 = Spy(() {
        a.value;
      });
      final spy2 = Spy(() {
        a.value;
      });
      effect(spy1.call);
      effect(() {
        if (a.value == 1) {
          throw Exception('hello');
        }
      });
      effect(spy2.call);
      effect(() {
        if (a.value == 1) {
          throw Exception('hello');
        }
      });
      spy1.resetHistory();
      spy2.resetHistory();

      expect(() {
        batch(() {
          a.value++;
        });
      }, throwsException);

      expect(spy1.calls, 1);
      expect(spy2.calls, 1);
    });

    test("should run effect's first run immediately even inside a batch", () {
      var callCount = 0;
      final spy = Spy(() {});
      batch(() {
        effect(spy.call);
        callCount = spy.calls;
      });
      expect(callCount, 1);
    });
  });
}
