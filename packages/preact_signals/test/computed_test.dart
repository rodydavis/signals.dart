// ignore_for_file: unnecessary_type_check

import 'package:test/test.dart';
import 'package:preact_signals/preact_signals.dart';

import 'utils/spy.dart';

void main() {
  group('computed', () {
    test('should return value', () {
      final a = signal('a');
      final b = signal('b');

      final c = computed(() => a.value + b.value);
      expect(c.value, 'ab');
    });

    test('should inherit from Signal', () {
      final a = signal('a');
      final b = signal('b');

      final c = computed(() => a.value + b.value);
      expect(c is ReadonlySignal, true);
    });

    test('should return updated value', () {
      final a = signal('a');
      final b = signal('b');

      final c = computed(() => a.value + b.value);
      expect(c.value, 'ab');

      a.value = 'aa';
      expect(c.value, 'aab');
    });

    test('should be lazily computed on demand', () {
      final a = signal('a');
      final b = signal('b');
      final spy = Spy(() => a.value + b.value);
      final c = computed(spy.call);
      expect(spy.calls, 0);
      c.value;
      expect(spy.calls, 1);
      a.value = 'x';
      b.value = 'y';
      expect(spy.calls, 1);
      c.value;
      expect(spy.calls, 2);
    });

    test('should be computed only when a dependency has changed at some point',
        () {
      final a = signal('a');
      final spy = Spy(() {
        a.value;
      });
      final c = computed(spy.call);
      c.value;
      expect(spy.calls, 1);
      a.value = 'a';
      c.value;
      expect(spy.calls, 1);
    });

    test(
        'should recompute if a dependency changes during computation'
        'after becoming a dependency', () {
      final a = signal(0);
      final spy = Spy(() {
        a.value++;
      });
      final c = computed(spy.call);
      c.value;
      expect(spy.calls, 1);
      c.value;
      expect(spy.calls, 2);
    });

    test('should detect simple dependency cycles', () {
      late ReadonlySignal<int> a;
      a = computed(() => a.value);
      expect(() => a.value, throwsException);
    });

    test('should detect deep dependency cycles', () {
      late ReadonlySignal<int> a, b, c, d;
      a = computed(() => b.value);
      b = computed(() => c.value);
      c = computed(() => d.value);
      d = computed(() => a.value);
      expect(() => a.value, throwsException);
    });

    test(
        'should not allow a computed signal to become a direct dependency of itself',
        () {
      late ReadonlySignal a;
      final spy = Spy(() {
        try {
          a.value;
        } catch (e) {
          // pass
        }
      });
      a = computed(spy.call);
      a.value;
      expect(() => effect(() => a.value), returnsNormally);
    });

    test(
        'should store thrown errors and recompute only after a dependency changes',
        () {
      final a = signal(0);
      final spy = Spy(() {
        a.value;
        throw Exception();
      });
      final c = computed(spy.call);
      expect(() => c.value, throwsException);
      expect(() => c.value, throwsException);
      expect(spy.calls, 1);
      a.value = 1;
      expect(() => c.value, throwsException);
      expect(spy.calls, 2);
    });

    test('should conditionally unsubscribe from signals', () {
      final a = signal('a');
      final b = signal('b');
      final cond = signal(true);

      final spy = Spy(() => cond.value ? a.value : b.value);

      final c = computed(spy.call);
      expect(c.value, 'a');
      expect(spy.calls, 1);

      b.value = 'bb';
      expect(c.value, 'a');
      expect(spy.calls, 1);

      cond.value = false;
      expect(c.value, 'bb');
      expect(spy.calls, 2);

      spy.resetHistory();

      a.value = 'aaa';
      expect(c.value, 'bb');
      expect(spy.calls, 0);
    });

    test('should consider undefined value separate from uninitialized value',
        () {
      final a = signal(0);
      final spy = Spy(() => null);
      final c = computed(spy.call);

      expect(c.value, null);
      a.value = 1;
      expect(c.value, null);
      expect(spy.calls, 1);
    });

    test('should not leak errors raised by dependencies', () {
      final a = signal(0);
      final b = computed(() {
        a.value;
        throw Exception('error');
      });
      final c = computed(() {
        try {
          b.value;
        } catch (e) {
          return 'ok';
        }
      });
      expect(c.value, 'ok');
      a.value = 1;
      expect(c.value, 'ok');
    });

    test('should propagate notifications even right after first subscription',
        () {
      final a = signal(0);
      final b = computed(() => a.value);
      final c = computed(() => b.value);
      c.value;

      final spy = Spy(() {
        c.value;
      });

      effect(spy.call);
      expect(spy.calls, 1);
      spy.resetHistory();

      a.value = 1;
      expect(spy.calls, 1);
    });

    test('should get marked as outdated right after first subscription', () {
      final s = signal(0);
      final c = computed(() => s.value);
      c.value;

      s.value = 1;
      effect(() {
        c.value;
      });
      expect(c.value, 1);
    });

    test(
        'should propagate notification to other listeners after one listener is disposed',
        () {
      final s = signal(0);
      final c = computed(() => s.value);

      final spy1 = Spy(() {
        c.value;
      });
      final spy2 = Spy(() {
        c.value;
      });
      final spy3 = Spy(() {
        c.value;
      });

      effect(spy1.call);
      final dispose = effect(spy2.call);
      effect(spy3.call);

      expect(spy1.calls, 1);
      expect(spy2.calls, 1);
      expect(spy3.calls, 1);

      dispose();

      s.value = 1;
      expect(spy1.calls, 2);
      expect(spy2.calls, 1);
      expect(spy3.calls, 2);
    });

    test('should not recompute dependencies out of order', () {
      final a = signal(1);
      final b = signal(1);
      final c = signal(1);

      final spy = Spy(() => c.value);
      final d = computed(spy.call);

      final e = computed(() {
        if (a.value > 0) {
          b.value;
          d.value;
        } else {
          b.value;
        }
      });

      e.value;
      spy.resetHistory();

      a.value = 2;
      b.value = 2;
      c.value = 2;
      e.value;
      expect(spy.calls, 1);
      spy.resetHistory();

      a.value = -1;
      b.value = -1;
      c.value = -1;
      e.value;
      expect(spy.calls, 0);
      spy.resetHistory();
    });

    test('should not recompute dependencies unnecessarily', () {
      final spy = Spy(() {});
      final a = signal(0);
      final b = signal(0);
      final c = computed(() {
        b.value;
        spy();
      });
      final d = computed(() {
        if (a.value == 0) {
          c.value;
        }
      });
      d.value;
      expect(spy.calls, 1);

      batch(() {
        b.value = 1;
        a.value = 1;
      });
      d.value;
      expect(spy.calls, 1);
    });

    group('.peek()', () {
      test('should get value', () {
        final s = signal(1);
        final c = computed(() => s.value);
        expect(c.peek(), 1);
      });

      test('should throw when evaluation throws', () {
        final c = computed(() {
          throw Exception('test');
        });
        expect(() => c.peek(), throwsException);
      });

      test(
          "should throw when previous evaluation threw and dependencies haven't changed",
          () {
        final c = computed(() {
          throw Exception('test');
        });
        expect(() => c.value, throwsException);
        expect(() => c.peek(), throwsException);
      });

      test('should refresh value if stale', () {
        final a = signal(1);
        final b = computed(() => a.value);
        expect(b.peek(), 1);

        a.value = 2;
        expect(b.peek(), 2);
      });

      test('should detect simple dependency cycles', () {
        late ReadonlySignal<int> a;
        a = computed(() => a.peek());
        expect(() => a.peek(), throwsException);
      });

      test('should detect deep dependency cycles', () {
        late ReadonlySignal<int> a, b, c, d;
        a = computed(() => b.peek());
        b = computed(() => c.peek());
        c = computed(() => d.peek());
        d = computed(() => a.peek());
        expect(() => a.peek(), throwsException);
      });

      test('should not make surrounding effect depend on the computed', () {
        final s = signal(1);
        final c = computed(() => s.value);
        final spy = Spy(() {
          return c.peek();
        });

        effect(spy.call);
        expect(spy.calls, 1);

        s.value = 2;
        expect(spy.calls, 1);
      });

      test('should not make surrounding computed depend on the computed', () {
        final s = signal(1);
        final c = computed(() => s.value);

        final spy = Spy(() {
          return c.peek();
        });

        final d = computed(spy.call);
        d.value;
        expect(spy.calls, 1);

        s.value = 2;
        d.value;
        expect(spy.calls, 1);
      });

      test(
          "should not make surrounding effect depend on the peeked computed's dependencies",
          () {
        final a = signal(1);
        final b = computed(() => a.value);
        final spy = Spy(() {});
        effect(() {
          spy();
          b.peek();
        });
        expect(spy.calls, 1);
        spy.resetHistory();

        a.value = 1;
        expect(spy.calls, 0);
      });

      test(
          "should not make surrounding computed depend on peeked computed's dependencies",
          () {
        final a = signal(1);
        final b = computed(() => a.value);
        final spy = Spy(() {});
        final d = computed(() {
          spy();
          b.peek();
        });
        d.value;
        expect(spy.calls, 1);
        spy.resetHistory();

        a.value = 1;
        d.value;
        expect(spy.calls, 0);
      });
    });

    group('.(un)watched()', () {
      test('should call watched when first subscription occurs', () {
        var watched = 0;
        var unwatched = 0;
        final s = computed(() => 1, ComputedOptions(
          watched: () => watched++,
          unwatched: () => unwatched++,
        ));
        expect(watched, 0);
        final unsubscribe = s.subscribe((_) {});
        expect(watched, 1);
        final unsubscribe2 = s.subscribe((_) {});
        expect(watched, 1);
        unsubscribe();
        unsubscribe2();
        expect(unwatched, 1);
      });

      test('should call watched when first subscription occurs w/ nested signal', () {
        var watched = 0;
        var unwatched = 0;
        final s = signal(1, SignalOptions(
          watched: () => watched++,
          unwatched: () => unwatched++,
        ));
        final c = computed(() => s.value + 1, ComputedOptions(
          watched: () => watched++,
          unwatched: () => unwatched++,
        ));
        expect(watched, 0);
        final unsubscribe = c.subscribe((_) {});
        expect(watched, 2);
        final unsubscribe2 = s.subscribe((_) {});
        expect(watched, 2);
        unsubscribe2();
        unsubscribe();
        expect(unwatched, 2);
      });
    });

    group('graph updates', () {
      test('should run computeds once for multiple dep changes', () async {
        final a = signal('a');
        final b = signal('b');

        final compute = Spy(() => a.value + b.value);
        final c = computed(compute.call);

        expect(c.value, 'ab');
        expect(compute.calls, 1);
        compute.resetHistory();

        a.value = 'aa';
        b.value = 'bb';
        c.value;
        expect(compute.calls, 1);
      });

      test('should drop A->B->A updates', () async {
        //     A
        //   / |
        //  B  |
        //   \ |
        //     C
        //     |
        //     D
        final a = signal(2);

        final b = computed(() => a.value - 1);
        final c = computed(() => a.value + b.value);

        final compute = Spy(() => 'd: ${c.value}');
        final d = computed(compute.call);

        // Trigger read
        expect(d.value, 'd: 3');
        expect(compute.calls, 1);
        compute.resetHistory();

        a.value = 4;
        d.value;
        expect(compute.calls, 1);
      });

      test('should only update every signal once (diamond graph)', () {
        //     A
        //   /   \
        //  B     C
        //   \   /
        //     D
        final a = signal('a');
        final b = computed(() => a.value);
        final c = computed(() => a.value);

        final spy = Spy(() => '${b.value} ${c.value}');
        final d = computed(spy.call);

        expect(d.value, 'a a');
        expect(spy.calls, 1);

        a.value = 'aa';
        expect(d.value, 'aa aa');
        expect(spy.calls, 2);
      });

      test('should only update every signal once (diamond graph + tail)', () {
        //     A
        //   /   \
        //  B     C
        //   \   /
        //     D
        //     |
        //     E
        final a = signal('a');
        final b = computed(() => a.value);
        final c = computed(() => a.value);

        final d = computed(() => '${b.value} ${c.value}');

        final spy = Spy(() => d.value);
        final e = computed(spy.call);

        expect(e.value, 'a a');
        expect(spy.calls, 1);

        a.value = 'aa';
        expect(e.value, 'aa aa');
        expect(spy.calls, 2);
      });

      test('should bail out if result is the same', () {
        // A->B->C
        final a = signal('a');
        final b = computed(() {
          a.value;
          return 'foo';
        });

        final spy = Spy(() => b.value);
        final c = computed(spy.call);

        expect(c.value, 'foo');
        expect(spy.calls, 1);

        a.value = 'aa';
        expect(c.value, 'foo');
        expect(spy.calls, 1);
      });

      test('should only update every signal once (jagged diamond graph + tails)', () {
        //     A
        //   /   \
        //  B     C
        //  |     |
        //  |     D
        //   \   /
        //     E
        //   /   \
        //  F     G
        final a = signal('a');

        final b = computed(() => a.value);
        final c = computed(() => a.value);

        final d = computed(() => c.value);

        final eSpy = Spy(() => '${b.value} ${d.value}');
        final e = computed(eSpy.call);

        final fSpy = Spy(() => e.value);
        final f = computed(fSpy.call);
        final gSpy = Spy(() => e.value);
        final g = computed(gSpy.call);

        expect(f.value, 'a a');
        expect(fSpy.calls, 1);

        expect(g.value, 'a a');
        expect(gSpy.calls, 1);

        eSpy.resetHistory();
        fSpy.resetHistory();
        gSpy.resetHistory();

        a.value = 'b';

        expect(e.value, 'b b');
        expect(eSpy.calls, 1);

        expect(f.value, 'b b');
        expect(fSpy.calls, 1);

        expect(g.value, 'b b');
        expect(gSpy.calls, 1);

        eSpy.resetHistory();
        fSpy.resetHistory();
        gSpy.resetHistory();

        a.value = 'c';

        expect(e.value, 'c c');
        expect(eSpy.calls, 1);

        expect(f.value, 'c c');
        expect(fSpy.calls, 1);

        expect(g.value, 'c c');
        expect(gSpy.calls, 1);
      });

      test('should only subscribe to signals listened to', () {
        //    *A
        //   /   \
        // *B     C
        final a = signal('a');

        final b = computed(() => a.value);
        final spy = Spy(() => a.value);
        computed(spy.call);

        expect(b.value, 'a');
        expect(spy.calls, 0);

        a.value = 'aa';
        expect(b.value, 'aa');
        expect(spy.calls, 0);
      });

      test('should only subscribe to signals listened to (2)', () {
        final a = signal('a');
        final spyB = Spy(() => a.value);
        final b = computed(spyB.call);

        final spyC = Spy(() => b.value);
        final c = computed(spyC.call);

        final d = computed(() => a.value);

        var result = '';
        final unsub = effect(() {
          result = c.value;
        });

        expect(result, 'a');
        expect(d.value, 'a');

        spyB.resetHistory();
        spyC.resetHistory();
        unsub();

        a.value = 'aa';

        expect(spyB.calls, 0);
        expect(spyC.calls, 0);
        expect(d.value, 'aa');
      });

      test('should ensure subs update even if one dep unmarks it', () {
        //     A
        //   /   \
        //  B     *C <- returns same value every time
        //   \   /
        //     D
        final a = signal('a');
        final b = computed(() => a.value);
        final c = computed(() {
          a.value;
          return 'c';
        });
        final spy = Spy(() => '${b.value} ${c.value}');
        final d = computed(spy.call);
        expect(d.value, 'a c');
        spy.resetHistory();

        a.value = 'aa';
        expect(d.value, 'aa c');
        expect(spy.calls, 1);
      });

      test('should ensure subs update even if two deps unmark it', () {
        //     A
        //   / | \
        //  B *C *D
        //   \ | /
        //     E
        final a = signal('a');
        final b = computed(() => a.value);
        final c = computed(() {
          a.value;
          return 'c';
        });
        final d = computed(() {
          a.value;
          return 'd';
        });
        final spy = Spy(() => '${b.value} ${c.value} ${d.value}');
        final e = computed(spy.call);
        expect(e.value, 'a c d');
        spy.resetHistory();

        a.value = 'aa';
        expect(e.value, 'aa c d');
        expect(spy.calls, 1);
      });
    });
  });
}
