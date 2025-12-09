import 'dart:async';

import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
  group('Future', () {
    test('futureSignal', () async {
      Future<int> future() async {
        await Future.delayed(const Duration(milliseconds: 5));
        return 10;
      }

      final signal = futureSignal(() => future());
      expect(signal.peek().isLoading, true);

      final completer = Completer<int>();
      effect(() {
        signal.value;
        if (signal.value.hasValue) {
          completer.complete(signal.peek().requireValue);
        }
      });
      final result = await completer.future;

      expect(result, 10);
    });

    test('extension on Future', () async {
      Future<int> future() async {
        await Future.delayed(const Duration(milliseconds: 5));
        return 10;
      }

      final signal = future().toFutureSignal();
      expect(signal.peek().isLoading, true);

      final completer = Completer<int>();
      effect(() {
        signal.value;
        if (signal.value.hasValue) {
          completer.complete(signal.peek().requireValue);
        }
      });
      final result = await completer.future;

      expect(result, 10);
    });

    test('check repeated calls', () async {
      int calls = 0;

      Future<int> future() async {
        calls++;
        await Future.delayed(const Duration(milliseconds: 5));
        return 10;
      }

      final signal = futureSignal(() => future());
      expect(signal.peek().isLoading, true);
      expect(calls, 1);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);
    });

    test('check reload calls', () async {
      int calls = 0;

      Future<int> future() async {
        calls++;
        await Future.delayed(const Duration(milliseconds: 5));
        return 10;
      }

      final signal = futureSignal(() => future());
      expect(signal.peek().isLoading, true);
      expect(calls, 1);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);

      await signal.reload();

      expect(calls, 2);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);
    });

    test('check refresh calls', () async {
      int calls = 0;

      Future<int> future() async {
        calls++;
        await Future.delayed(const Duration(milliseconds: 5));
        return 10;
      }

      final signal = futureSignal(() => future());
      expect(signal.peek().isLoading, true);
      expect(calls, 1);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);

      await signal.refresh();

      expect(calls, 2);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);
    });

    test('dependencies', () async {
      final prefix = signal('a');
      final val = signal(0);
      final f = futureSignal(() async {
        final p = prefix();
        final v = val();
        await Future.delayed(const Duration(seconds: 1));
        return '$p$v';
      });
      expect(f.peek().isLoading, true);

      var result = await f.future;

      expect(result, 'a0');

      prefix.value = 'b';
      await f.future;
      result = f.requireValue;

      expect(result, 'b0');
    });

    group('.future', () {
      test('notifies once when signal completes', () async {
        int calls = 0;
        int signalCalls = 0;
        int computedCalls = 0;
        int heavyComputationCalls = 0;

        final a = signal(10);

        Future<int> future(int value) async {
          calls++;
          await Future.delayed(const Duration(milliseconds: 5));
          return value;
        }

        final b = futureSignal(
          () async {
            signalCalls++;
            return await future(a.value);
          },
          dependencies: [a],
        );

        Future<int> heavyComputation(int value) async {
          heavyComputationCalls++;
          await Future.delayed(const Duration(milliseconds: 5));
          return value * 2;
        }

        final c = futureSignal(
          () async {
            computedCalls++;
            final value = await b.future;
            return await heavyComputation(value);
          },
          dependencies: [b.completion],
        );

        final result = await c.future;

        expect(result, 20, reason: 'unexpected result');
        expect(calls, 1);
        expect(signalCalls, 1);
        expect(heavyComputationCalls, 1);
        expect(computedCalls, 1);

        a.value = 20;

        final result2 = await c.future;

        expect(result2, 40);
        expect(calls, 2);
        expect(signalCalls, 2);
        expect(heavyComputationCalls, 2);
        expect(computedCalls, 2);
      });

      test('notifies once when signal completes (with initial data)', () async {
        var signalCalls = 0;
        var computedCalls = 0;

        final a = futureSignal(
          () async {
            signalCalls++;
            await Future.delayed(const Duration(milliseconds: 5));
            return 42;
          },
          initialValue: 21,
        );

        final b = futureSignal(
          () async {
            computedCalls++;
            return await a.future;
          },
        );

        final seenValuesOfA = <AsyncState<int>>[];
        effect(() {
          seenValuesOfA.add(a.value);
        });

        final seenValuesOfB = <AsyncState<int>>[];
        effect(() {
          seenValuesOfB.add(b.value);
        });

        final result = await b.future;
        expect(result, 42, reason: 'unexpected result');

        expect(seenValuesOfA, hasLength(2));
        expect(seenValuesOfA[0], AsyncData<int>(21));
        expect(seenValuesOfA[1], AsyncData<int>(42));

        expect(seenValuesOfB, hasLength(2));
        expect(seenValuesOfB[0], AsyncLoading<int>());
        expect(seenValuesOfB[1], AsyncData<int>(42));

        expect(signalCalls, 1);
        expect(computedCalls, 1);
      });

      test('error after accessing .future', () async {
        int invocations = 0;
        final trigger = signal(0);

        final s = futureSignal(
          () async {
            // Track dependency so changes trigger recomputation
            final t = trigger.value;
            await Future.delayed(const Duration(milliseconds: 5));
            invocations++;
            if (t == 0) {
              throw Exception('boom');
            }
            return 99;
          },
          dependencies: [trigger],
        );

        // First run should error because trigger == 0
        await expectLater(s.future, throwsA(isA<Exception>()));
        expect(invocations, 1);

        // Next run should succeed
        trigger.value = 1;
        final result = await s.future;
        expect(result, 99);
        expect(invocations, 2);
      });

      test('error before accessing .future', () async {
        int calls = 0;

        final expectedError = Exception('err-before-use');

        final s = futureSignal(() async {
          calls++;
          await Future.delayed(const Duration(milliseconds: 5));
          throw expectedError;
        });

        expect(s.peek(), AsyncLoading());

        // Wait for the first (failing) run to finish without ever touching s.future
        await Future.delayed(const Duration(milliseconds: 20));

        expect(s.peek().error, expectedError);

        // Now access future and trigger a successful recompute
        await expectLater(s.future, throwsA(expectedError));

        expect(calls, 1);
      });

      test('.reload notifies completion only once per cycle', () async {
        int calls = 0;
        final s = futureSignal(() async {
          calls++;
          await Future.delayed(const Duration(milliseconds: 5));
          return calls;
        });

        // A computed depending on completion should only recompute when s completes
        int computedCalls = 0;
        final c = futureSignal(
          () async {
            computedCalls++;
            final v = await s.future;
            return v * 10;
          },
          dependencies: [s.completion],
        );

        final first = await c.future;
        expect(first, 10);
        expect(calls, 1);
        expect(computedCalls, 1);

        // Trigger reload — should not notify on AsyncLoading, only once when completed
        await s.reload();
        final second = await c.future;
        expect(second, 20);
        expect(calls, 2);
        expect(computedCalls, 2);
      });

      test('.refresh notifies completion only once per cycle', () async {
        int calls = 0;
        final s = futureSignal(() async {
          calls++;
          await Future.delayed(const Duration(milliseconds: 5));
          return calls;
        });

        int computedCalls = 0;
        final c = futureSignal(
          () async {
            computedCalls++;
            final v = await s.future;
            return v * 100;
          },
          dependencies: [s.completion],
        );

        final first = await c.future;
        expect(first, 100);
        expect(calls, 1);
        expect(computedCalls, 1);

        await s.refresh();
        final second = await c.future;
        expect(second, 200);
        expect(calls, 2);
        expect(computedCalls, 2);
      });

      test('completes with error', () async {
        int run = 0;
        final s = futureSignal(
          () async {
            run++;
            await Future.delayed(const Duration(milliseconds: 5));
            if (run == 1) return 1; // initial success
            throw Exception('later failure');
          },
          initialValue: 0,
        );

        // Initial: goes from AsyncData(0) to AsyncData(1)
        expect(await s.future, 1);

        // Next run should error
        // Trigger recompute by reloading
        s.reload().catchError((err, stackTrace) {});
        await expectLater(s.future, throwsA(isA<Exception>()));
        expect(run, 2);
      });

      test('notifies once with latest value', () async {
        final completer1 = Completer<int>();
        final completer2 = Completer<int>();

        final source = signal(1);

        final s = futureSignal(() async {
          return switch (source.value) {
            1 => await completer1.future,
            2 => await completer2.future,
            _ => throw UnimplementedError(),
          };
        });

        int calls = 0;

        final c = futureSignal(() async {
          calls++;
          return await s.future;
        });

        final future1 = c.future;

        source.value = 2;

        final future2 = c.future;

        completer2.complete(42);

        await Future.delayed(Duration(milliseconds: 5));

        completer1.complete(21);

        await expectLater(future1, completion(42));
        await expectLater(future2, completion(42));
        expect(calls, 1);
      });

      test('latest-wins: success then newer error', () async {
        final completer1 = Completer<int>();
        final completer2 = Completer<int>();
        // final expectedError = Exception('latest error');

        final source = signal(1);

        final s = futureSignal(() async {
          return switch (source.value) {
            1 => await completer1.future, // A (success)
            2 => await completer2.future, // B (error)
            _ => throw UnimplementedError(),
          };
        });

        int calls = 0;
        final c = computedFrom([s.completion], (_) async {
          calls++;
          return await s.future;
        });

        final future1 = c.future; // starts A
        source.value = 2; // start B
        final future2 = c.future;

        final e1 = expectLater(future1, throwsA('error'));
        final e2 = expectLater(future2, throwsA('error'));

        // Complete newer B first with error, then complete older A (success) later.
        completer2.completeError('error');
        await Future.delayed(const Duration(milliseconds: 5));
        completer1.complete(21);

        await e1;
        await e2;
        expect(calls, 1);
        expect(s.peek().hasError, isTrue);
      });

      test('concurrent awaiters share one completion', () async {
        int calls = 0;
        final completer = Completer<int>();

        final s = futureSignal(() async {
          calls++;
          return await completer.future;
        });

        // Attach listeners BEFORE completing the underlying future
        final future1 = s.future;
        final future2 = s.future;
        final e1 = expectLater(future1, completion(123));
        final e2 = expectLater(future2, completion(123));

        completer.complete(123);

        await e1;
        await e2;
        expect(calls, 1);
        expect(s.peek().requireValue, 123);
      });

      test('latest-wins: success then newer success', () async {
        final completer1 = Completer<int>();
        final completer2 = Completer<int>();

        final source = signal(1);

        final s = futureSignal(() async {
          return switch (source.value) {
            1 => await completer1.future, // A (success, completes last)
            2 => await completer2.future, // B (success, completes first)
            _ => throw UnimplementedError(),
          };
        });

        int calls = 0;
        final c = futureSignal(() async {
          calls++;
          return await s.future;
        }, dependencies: [s.completion]);

        final future1 = c.future; // starts A
        source.value = 2; // start B
        final future2 = c.future;

        // Attach listeners BEFORE driving the outcomes
        final e1 = expectLater(future1, completion(42));
        final e2 = expectLater(future2, completion(42));

        // Complete newer B first, then older A
        completer2.complete(42);
        await Future.delayed(const Duration(milliseconds: 5));
        completer1.complete(21);

        await e1;
        await e2;
        expect(calls, 1);
        expect(s.peek().requireValue, 42);
      });

      test('latest-wins: error then newer error', () async {
        final completer1 = Completer<int>();
        final completer2 = Completer<int>();

        final source = signal(1);

        final s = futureSignal(() async {
          return switch (source.value) {
            1 => await completer1.future, // A (error, completes last)
            2 => await completer2.future, // B (error, completes first)
            _ => throw UnimplementedError(),
          };
        });

        int calls = 0;
        final c = futureSignal(() async {
          calls++;
          return await s.future;
        }, dependencies: [s.completion]);

        final future1 = c.future; // starts A
        source.value = 2; // start B
        final future2 = c.future;

        // Attach listeners BEFORE driving the outcomes to avoid uncaught errors
        final e1 = expectLater(future1, throwsA('newer error'));
        final e2 = expectLater(future2, throwsA('newer error'));

        // Complete newer B with error first, then older A with error
        completer2.completeError('newer error');
        await Future.delayed(const Duration(milliseconds: 5));
        completer1.completeError('older error');

        await e1;
        await e2;
        expect(calls, 1);
        expect(s.peek().hasError, isTrue);
      });

      test('latest-wins: error then newer success', () async {
        final completer1 = Completer<int>();
        final completer2 = Completer<int>();

        final source = signal(1);

        final s = futureSignal(() async {
          return switch (source.value) {
            1 => await completer1.future, // A (error, completes last)
            2 => await completer2.future, // B (success, completes first)
            _ => throw UnimplementedError(),
          };
        });

        int calls = 0;
        final c = futureSignal(() async {
          calls++;
          return await s.future;
        }, dependencies: [s.completion]);

        final future1 = c.future; // starts A
        source.value = 2; // start B
        final future2 = c.future;

        // Attach listeners BEFORE driving the outcomes to avoid uncaught errors
        final e1 = expectLater(future1, completion(42));
        final e2 = expectLater(future2, completion(42));

        // Complete newer B with success first, then older A with error
        completer2.complete(42);
        await Future.delayed(const Duration(milliseconds: 5));
        completer1.completeError('old error');

        await e1;
        await e2;
        expect(calls, 1);
        expect(s.peek().requireValue, 42);
      });
    });
  });
}
