// ignore_for_file: unnecessary_type_check, prefer_function_declarations_over_variables

import 'package:test/test.dart';
import 'package:preact_signals/preact_signals.dart';

import 'utils/spy.dart';

void main() {
  group('effect', () {
    test('should run the callback immediately', () {
      final s = signal(123);
      final spy = Spy(() => s.value);
      effect(spy.call);
      expect(spy.calls, 1);
    });

    test('should subscribe to signals', () {
      final s = signal(123);
      final spy = Spy(() => s.value);
      effect(spy.call);
      spy.resetHistory();

      s.value = 42;
      expect(spy.calls, 1);
    });

    test('should subscribe to multiple signals', () {
      final a = signal('a');
      final b = signal('b');
      final spy = Spy(() {
        a.value;
        b.value;
      });
      effect(spy.call);
      spy.resetHistory();

      a.value = 'aa';
      b.value = 'bb';
      expect(spy.calls, 2);
    });

    test('should dispose of subscriptions', () {
      final a = signal('a');
      final b = signal('b');
      final spy = Spy(() => '${a.value} ${b.value}');
      final dispose = effect(spy.call);
      spy.resetHistory();

      dispose();
      expect(spy.calls, 0);

      a.value = 'aa';
      b.value = 'bb';
      expect(spy.calls, 0);
    });

    test('should unsubscribe from signal', () {
      final s = signal(123);
      final spy = Spy(() => s.value);
      final dispose = effect(spy.call);
      spy.resetHistory();

      dispose();
      s.value = 42;
      expect(spy.calls, 0);
    });

    test('should conditionally unsubscribe from signals', () {
      final a = signal('a');
      final b = signal('b');
      final cond = signal(true);
      final spy = Spy(() => cond.value ? a.value : b.value);

      effect(spy.call);
      expect(spy.calls, 1);

      b.value = 'bb';
      expect(spy.calls, 1);

      cond.value = false;
      expect(spy.calls, 2);

      spy.resetHistory();

      a.value = 'aa';
      expect(spy.calls, 0);
    });

    test('should batch writes', () {
      final a = signal('a');
      final spy = Spy(() => a.value);
      effect(spy.call);
      spy.resetHistory();

      effect(() {
        a.value = 'aa';
        a.value = 'aaa';
      });

      expect(spy.calls, 1);
    });

    test('should call the cleanup callback before the next run', () {
      final a = signal(0);
      final spy = Spy(() => a.value);

      effect(() {
        a.value;
        return spy.call;
      });
      expect(spy.calls, 0);
      a.value = 1;
      expect(spy.calls, 1);
      a.value = 2;
      expect(spy.calls, 2);
    });

    test('should call only the callback from the previous run', () {
      final spy1 = Spy(() {});
      final spy2 = Spy(() {});
      final spy3 = Spy(() {});
      final a = signal(spy1.call);

      effect(() {
        return a.value;
      });

      expect(spy1.calls, 0);
      expect(spy2.calls, 0);
      expect(spy3.calls, 0);

      a.value = spy2.call;
      expect(spy1.calls, 1);
      expect(spy2.calls, 0);
      expect(spy3.calls, 0);

      a.value = spy3.call;
      expect(spy1.calls, 1);
      expect(spy2.calls, 1);
      expect(spy3.calls, 0);
    });

    test('should call the cleanup callback function when disposed', () {
      final spy = Spy(() {});

      final dispose = effect(() {
        return spy.call;
      });
      expect(spy.calls, 0);
      dispose();
      expect(spy.calls, 1);
    });

    test(
        'should not recompute if the effect has been notified about'
        'changes, but no direct dependency has actually changed', () {
      final s = signal(0);
      final c = computed(() {
        s.value;
        return 0;
      });
      final spy = Spy(() {
        c.value;
      });
      effect(spy.call);
      expect(spy.calls, 1);
      spy.resetHistory();

      s.value = 1;
      expect(spy.calls, 0);
    });

    test('should not recompute dependencies unnecessarily', () {
      final spy = Spy(() {});
      final a = signal(0);
      final b = signal(0);
      final c = computed(() {
        b.value;
        spy();
      });
      effect(() {
        if (a.value == 0) {
          c.value;
        }
      });
      expect(spy.calls, 1);

      batch(() {
        b.value = 1;
        a.value = 1;
      });
      expect(spy.calls, 1);
    });

    test('should not recompute dependencies out of order', () {
      final a = signal(1);
      final b = signal(1);
      final c = signal(1);

      final spy = Spy(() => c.value);
      final d = computed(spy.call);

      effect(() {
        if (a.value > 0) {
          b.value;
          d.value;
        } else {
          b.value;
        }
      });
      spy.resetHistory();

      batch(() {
        a.value = 2;
        b.value = 2;
        c.value = 2;
      });
      expect(spy.calls, 1);
      spy.resetHistory();

      batch(() {
        a.value = -1;
        b.value = -1;
        c.value = -1;
      });
      expect(spy.calls, 0);
      spy.resetHistory();
    });

    test(
        'should recompute if a dependency changes during'
        'computation after becoming a dependency', () {
      final a = signal(0);
      final spy = Spy(() {
        if (a.value == 0) {
          a.value++;
        }
      });
      effect(spy.call);
      expect(spy.calls, 2);
    });

    test('should run the cleanup in an implicit batch', () {
      final a = signal(0);
      final b = signal('a');
      final c = signal('b');
      final spy = SpyWithArgs((String val) {});

      effect(() {
        b.value;
        c.value;
        spy(b.value + c.value);
      });

      effect(() {
        a.value;
        return () {
          b.value = 'x';
          c.value = 'y';
        };
      });

      expect(spy.calls.length, 1);
      spy.resetHistory();

      a.value = 1;
      expect(spy.calls.length, 1);
      expect(spy.lastCalledWith, 'xy');
    });

    test(
        'should not retrigger the effect if the cleanup modifies'
        'one of the dependencies', () {
      final a = signal(0);
      final spy = SpyWithArgs((int val) {});

      effect(() {
        spy(a.value);
        return () {
          a.value = 2;
        };
      });
      expect(spy.calls.length, 1);
      spy.resetHistory();

      a.value = 1;
      expect(spy.calls.length, 1);
      expect(spy.lastCalledWith, 2);
    });

    test('should run the cleanup if the effect disposes itself', () {
      final a = signal(0);
      final spy = Spy(() {});

      void Function()? dispose;
      dispose = effect(() {
        if (a.value > 0) {
          dispose!();
          return spy.call;
        }
      });

      expect(spy.calls, 0);
      a.value = 1;
      expect(spy.calls, 1);
      a.value = 2;
      expect(spy.calls, 1);
    });

    test('should not run the effect if the cleanup function disposes it', () {
      final a = signal(0);
      final spy = Spy(() {});

      void Function()? dispose;
      dispose = effect(() {
        a.value;
        spy();
        return () {
          dispose!();
        };
      });
      expect(spy.calls, 1);
      a.value = 1;
      expect(spy.calls, 1);
    });

    test('should not subscribe to anything if first run throws', () {
      final s = signal(0);
      final spy = Spy(() {
        s.value;
        throw Exception('test');
      });
      expect(() => effect(spy.call), throwsException);
      expect(spy.calls, 1);

      s.value++;
      expect(spy.calls, 1);
    });

    test('should reset the cleanup if the effect throws', () {
      final a = signal(0);
      final spy = Spy(() {});

      effect(() {
        if (a.value == 0) {
          return spy.call;
        } else {
          throw Exception('hello');
        }
      });
      expect(spy.calls, 0);
      expect(() => (a.value = 1), throwsException);
      expect(spy.calls, 1);
      a.value = 0;
      expect(spy.calls, 1);
    });

    test('should dispose the effect if the cleanup callback throws', () {
      final a = signal(0);
      final spy = Spy(() {});

      effect(() {
        if (a.value == 0) {
          return () {
            throw Exception('hello');
          };
        } else {
          spy();
        }
      });
      expect(spy.calls, 0);
      expect(() => (a.value++), throwsException);
      expect(spy.calls, 0);
      a.value++;
      expect(spy.calls, 0);
    });

    test('should run cleanups outside any evaluation context', () {
      final spy = Spy(() {});
      final a = signal(0);
      final b = signal(0);
      final c = computed(() {
        if (a.value == 0) {
          effect(() {
            return () {
              b.value;
            };
          });
        }
        return a.value;
      });

      effect(() {
        spy();
        c.value;
      });
      expect(spy.calls, 1);
      spy.resetHistory();

      a.value = 1;
      expect(spy.calls, 1);
      spy.resetHistory();

      b.value = 1;
      expect(spy.calls, 0);
    });

    test('should throw on cycles', () {
      final a = signal(0.0);
      var i = 0;

      final fn = () => effect(() {
            // Prevent test suite from spinning if limit is not hit
            if (i++ > 200) {
              throw Exception("test failed");
            }
            a.value;
            a.value = double.nan;
          });

      expect(fn, throwsException);
    });

    test('should throw on indirect cycles', () {
      final a = signal(0.0);
      var i = 0;

      final c = computed(() {
        a.value;
        a.value = double.nan;
        return double.nan;
      });

      final fn = () => effect(() {
            // Prevent test suite from spinning if limit is not hit
            if (i++ > 200) {
              throw Exception("test failed");
            }
            c.value;
          });

      expect(fn, throwsException);
    });

    test('should allow disposing the effect multiple times', () {
      final dispose = effect(() {});
      dispose();
      expect(() => dispose(), returnsNormally);
    });

    test('should allow disposing a running effect', () {
      final a = signal(0);
      final spy = Spy(() {});
      void Function()? dispose;
      dispose = effect(() {
        if (a.value == 1) {
          dispose!();
          spy();
        }
      });
      expect(spy.calls, 0);
      a.value = 1;
      expect(spy.calls, 1);
      a.value = 2;
      expect(spy.calls, 1);
    });

    test(
        "should not run if it's first been triggered and then disposed in a batch",
        () {
      final a = signal(0);
      final spy = Spy(() {
        a.value;
      });
      final dispose = effect(spy.call);
      spy.resetHistory();

      batch(() {
        a.value = 1;
        dispose();
      });

      expect(spy.calls, 0);
    });

    test(
        "should not run if it's been triggered, disposed and then triggered again in a batch",
        () {
      final a = signal(0);
      final spy = Spy(() {
        a.value;
      });
      final dispose = effect(spy.call);
      spy.resetHistory();

      batch(() {
        a.value = 1;
        dispose();
        a.value = 2;
      });

      expect(spy.calls, 0);
    });

    test(
        "should not rerun parent effect if a nested child effect's signal's value changes",
        () {
      final parentSignal = signal(0);
      final childSignal = signal(0);

      final parentEffect = Spy(() {
        parentSignal.value;
      });

      final childEffect = Spy(() {
        childSignal.value;
      });

      effect(() {
        parentEffect();
        effect(childEffect.call);
      });

      expect(parentEffect.calls, 1);
      expect(childEffect.calls, 1);

      childSignal.value = 1;

      expect(parentEffect.calls, 1);
      expect(childEffect.calls, 2);

      parentSignal.value = 1;

      expect(parentEffect.calls, 2);
      expect(childEffect.calls, 3);
    });
  });
}
