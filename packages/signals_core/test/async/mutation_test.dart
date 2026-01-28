import 'dart:async';

import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;

  group('MutationSignal', () {
    test('initial value is idle', () {
      final mutation = mutationSignal<int>();
      expect(mutation.value, MutationIdle<int>());
    });

    test('debugLabel', () {
      final mutation = mutationSignal<int>(debugLabel: 'debugLabel');
      expect(mutation.debugLabel, 'debugLabel');
    });

    test('initial autoDispose is false', () {
      final mutation = mutationSignal<int>();
      expect(mutation.autoDispose, false);
      expect(mutation.canRun.autoDispose, false);
    });

    test('autoDispose is set to true', () {
      final mutation = mutationSignal<int>(autoDispose: true);
      expect(mutation.autoDispose, true);
      expect(mutation.canRun.autoDispose, true);
    });

    test('autoDispose is set to false', () {
      final mutation = mutationSignal<int>(autoDispose: false);
      expect(mutation.autoDispose, false);
      expect(mutation.canRun.autoDispose, false);
    });

    group('value setters', () {
      test('value', () {
        final mutation = mutationSignal<int>();

        expect(mutation.value, MutationIdle());
        mutation.value = MutationPending();
        expect(mutation.value, MutationPending());
        mutation.value = MutationSuccess(1);
        expect(mutation.value, MutationSuccess(1));
        mutation.value = MutationError('error', StackTrace.empty);
        expect(mutation.value, MutationError('error', StackTrace.empty));
      });

      test('setIdle', () {
        final mutation = mutationSignal<int>();
        mutation.setSuccess(1);
        expect(mutation.value, MutationSuccess(1));
        mutation.setIdle();
        expect(mutation.value, MutationIdle<int>());
      });

      test('setPending', () {
        final mutation = mutationSignal<int>();
        expect(mutation.value, MutationIdle<int>());
        mutation.setPending();
        expect(mutation.value, MutationPending<int>());
      });

      test('setSuccess', () {
        final mutation = mutationSignal<int>();
        expect(mutation.value, MutationIdle<int>());
        mutation.setSuccess(1);
        expect(mutation.value, MutationSuccess(1));
      });

      test('setError with error and stackTrace', () {
        final stackTrace = StackTrace.current;
        final mutation = mutationSignal<int>();
        expect(mutation.value, MutationIdle<int>());
        mutation.setError('error', stackTrace);
        expect(mutation.value, MutationError<int>('error', stackTrace));
      });

      test('reset sets value to idle', () {
        final mutation = mutationSignal<int>();
        mutation.setSuccess(1);
        expect(mutation.value, MutationSuccess(1));
        mutation.reset();
        expect(mutation.value, MutationIdle<int>());
      });

      test('reset cancels pending operation and sets value to idle', () async {
        final mutation = mutationSignal<int>();
        final completer = Completer<int>();

        mutation.run(() => completer.future);

        expect(mutation.value, MutationPending<int>());

        mutation.reset();

        expect(mutation.value, MutationIdle<int>());

        completer.complete(1);
        await Future<void>.delayed(Duration.zero);

        expect(mutation.value, MutationIdle<int>());
      });

      test('value setter cancels pending and updates value', () async {
        final mutation = mutationSignal<int>();
        final completer = Completer<void>();

        mutation.run(() async {
          await completer.future;
          return 0;
        });

        expect(mutation.value, MutationPending<int>());
        mutation.value = MutationState<int>.success(1);

        completer.complete();

        await Future<void>.delayed(Duration.zero);
        expect(mutation.value, MutationState<int>.success(1));
      });
    });

    group('value getter', () {
      test('value returns the current value', () {
        final mutation = mutationSignal<int>();
        expect(mutation.value, MutationIdle());
        mutation.value = MutationPending();
        expect(mutation.value, MutationPending());
        mutation.value = MutationIdle();
        expect(mutation.value, MutationIdle());
      });
    });
    group('run', () {
      test('emits correct states when fn completes successfully', () async {
        final mutation = mutationSignal<int>();
        final stream = mutation.toStream();

        mutation.run(() async {
          return 1;
        });

        expect(
          stream,
          emitsInOrder(<MutationState<int>>[
            MutationState<int>.idle(),
            MutationState<int>.pending(),
            MutationState<int>.success(1),
          ]),
        );
      });

      test('emits correct states when fn completes with error', () async {
        final mutation = mutationSignal<int>();
        final stream = mutation.toStream();

        mutation.run(() async {
          Error.throwWithStackTrace('error', StackTrace.empty);
        });

        expect(
          stream,
          emitsInOrder(<MutationState<int>>[
            MutationState<int>.idle(),
            MutationState<int>.pending(),
            MutationState<int>.error('error', StackTrace.empty),
          ]),
        );
      });

      test('return when fn completes successfully', () async {
        final mutation = mutationSignal<int>();

        await mutation.run(() async {
          return 1;
        });

        expect(mutation.value, MutationSuccess(1));
      });

      test('return when fn completes with error', () async {
        final mutation = mutationSignal<int>();

        await mutation.run(() async {
          Error.throwWithStackTrace('error', StackTrace.empty);
        });

        expect(
          mutation.value,
          MutationError<int>('error', StackTrace.empty),
        );
      });

      test('ignores calls when canRun is false', () async {
        int callCount = 0;

        final mutation = mutationSignal<void>();

        final completer1 = Completer<void>();

        expect(mutation.canRun.value, true);

        mutation.run(() async {
          callCount++;
          await completer1.future;
        });

        expect(mutation.value, MutationPending<void>());
        expect(callCount, 1);
        expect(mutation.canRun.value, false);

        mutation.run(() async => callCount++);
        await Future<void>.delayed(Duration.zero);

        expect(callCount, 1);
      });

      test('calls onPending', () async {
        List<()> onPendingCalls = [];
        List<int> onSuccessCalls = [];
        List<MutationError<int>> onErrorCalls = [];
        List<MutationSettled<int>> onSettledCalls = [];

        final mutation = mutationSignal<int>();

        await mutation.run(
          () async => 1,
          onPending: () => onPendingCalls.add(()),
          onSuccess: (value) => onSuccessCalls.add(value),
          onError: (error, stackTrace) =>
              onErrorCalls.add(MutationError<int>(error, stackTrace)),
          onSettled: (settled) => onSettledCalls.add(settled),
        );

        expect(onPendingCalls, [()]);
        expect(onSuccessCalls, [1]);
        expect(onErrorCalls, []);
        expect(onSettledCalls, [MutationSuccess<int>(1)]);
      });

      test('calls onSuccess', () async {
        List<()> onPendingCalls = [];
        List<int> onSuccessCalls = [];
        List<MutationError<int>> onErrorCalls = [];
        List<MutationSettled<int>> onSettledCalls = [];

        final mutation = mutationSignal<int>();

        await mutation.run(
          () async => 1,
          onPending: () => onPendingCalls.add(()),
          onSuccess: (value) => onSuccessCalls.add(value),
          onError: (error, stackTrace) =>
              onErrorCalls.add(MutationError<int>(error, stackTrace)),
          onSettled: (settled) => onSettledCalls.add(settled),
        );

        expect(onPendingCalls, [()]);
        expect(onSuccessCalls, [1]);
        expect(onErrorCalls, []);
        expect(onSettledCalls, [MutationSuccess<int>(1)]);
      });

      test('calls onError', () async {
        List<()> onPendingCalls = [];
        List<int> onSuccessCalls = [];
        List<MutationError<int>> onErrorCalls = [];
        List<MutationSettled<int>> onSettledCalls = [];

        final mutation = mutationSignal<int>();

        await mutation.run(
          () async => Error.throwWithStackTrace('error', StackTrace.empty),
          onPending: () => onPendingCalls.add(()),
          onSuccess: (value) => onSuccessCalls.add(value),
          onError: (error, stackTrace) =>
              onErrorCalls.add(MutationError<int>(error, stackTrace)),
          onSettled: (settled) => onSettledCalls.add(settled),
        );

        expect(onPendingCalls, [()]);
        expect(onSuccessCalls, []);
        expect(onErrorCalls, [MutationError<int>('error', StackTrace.empty)]);
        expect(onSettledCalls, [MutationError<int>('error', StackTrace.empty)]);
      });

      test('calls onSettled with MutationSuccess on success', () async {
        List<()> onPendingCalls = [];
        List<int> onSuccessCalls = [];
        List<MutationError<int>> onErrorCalls = [];
        List<MutationSettled<int>> onSettledCalls = [];

        final mutation = mutationSignal<int>();

        await mutation.run(
          () async => 42,
          onPending: () => onPendingCalls.add(()),
          onSuccess: (value) => onSuccessCalls.add(value),
          onError: (error, stackTrace) =>
              onErrorCalls.add(MutationError<int>(error, stackTrace)),
          onSettled: (settled) => onSettledCalls.add(settled),
        );

        expect(onPendingCalls, [()]);
        expect(onSuccessCalls, [42]);
        expect(onErrorCalls, []);
        expect(onSettledCalls, [MutationSuccess<int>(42)]);
      });

      test('calls onSettled with MutationError on error', () async {
        List<()> onPendingCalls = [];
        List<int> onSuccessCalls = [];
        List<MutationError<int>> onErrorCalls = [];
        List<MutationSettled<int>> onSettledCalls = [];

        final mutation = mutationSignal<int>();

        await mutation.run(
          () async => Error.throwWithStackTrace('error', StackTrace.empty),
          onPending: () => onPendingCalls.add(()),
          onSuccess: (value) => onSuccessCalls.add(value),
          onError: (error, stackTrace) =>
              onErrorCalls.add(MutationError<int>(error, stackTrace)),
          onSettled: (settled) => onSettledCalls.add(settled),
        );

        expect(onPendingCalls, [()]);
        expect(onSuccessCalls, []);
        expect(onErrorCalls, [MutationError<int>('error', StackTrace.empty)]);
        expect(onSettledCalls, [MutationError<int>('error', StackTrace.empty)]);
      });

      test('calls onSettled after onSuccess', () async {
        List<String> callOrder = [];

        final mutation = mutationSignal<int>();

        await mutation.run(
          () async => 1,
          onSuccess: (_) => callOrder.add('onSuccess'),
          onSettled: (_) => callOrder.add('onSettled'),
        );

        expect(callOrder, ['onSuccess', 'onSettled']);
      });

      test('calls onSettled after onError', () async {
        List<String> callOrder = [];

        final mutation = mutationSignal<int>();

        await mutation.run(
          () async => Error.throwWithStackTrace('error', StackTrace.empty),
          onError: (_, __) => callOrder.add('onError'),
          onSettled: (_) => callOrder.add('onSettled'),
        );

        expect(callOrder, ['onError', 'onSettled']);
      });
    });

    group('canRun', () {
      test('returns false when value is MutationPending', () {
        final mutation = mutationSignal<int>();
        final canRunStream = mutation.canRun.toStream();

        mutation.setPending();
        expect(mutation.canRun.value, false);
        mutation.setSuccess(1);
        expect(mutation.canRun.value, true);
        mutation.setError('error', StackTrace.empty);
        expect(mutation.canRun.value, true);
        mutation.setIdle();
        expect(mutation.canRun.value, true);
        mutation.setPending();
        expect(mutation.canRun.value, false);

        expect(
          canRunStream,
          emitsInOrder(<bool>[
            true,
            false,
            true,
            // true, ignore duplicate consecutive values
            false,
          ]),
        );
      });

      test(
          'returns false when value is MutationPending even when '
          'canRun is set via constructor', () {
        final mutation = mutationSignal<int>(
          canRun: (value) {
            return true;
          },
        );
        final canRunStream = mutation.canRun.toStream();
        expect(mutation.canRun.value, true);
        mutation.setPending();
        expect(mutation.canRun.value, false);
        mutation.setSuccess(1);
        expect(mutation.canRun.value, true);
        mutation.setError('error', StackTrace.empty);
        expect(mutation.canRun.value, true);
        mutation.setIdle();
        expect(mutation.canRun.value, true);
        mutation.setPending();
        expect(mutation.canRun.value, false);

        expect(
          canRunStream,
          emitsInOrder(<bool>[
            true,
            false,
            true,
            // true, ignore duplicate consecutive values
            false,
          ]),
        );
      });

      test("is updated when dependencies' value changes", () async {
        final signalA = signal(0);
        final signalB = signal(0);

        final mutation = mutationSignal<int>(
          canRun: (value) {
            // only can run when the sum of signalA and signalB is even
            final sum = signalA.value + signalB.value;
            return sum.isEven;
          },
        );

        final canRunStream = mutation.canRun.toStream();
        expect(mutation.canRun.value, true);
        signalA.value++;
        expect(mutation.canRun.value, false);
        signalB.value++;
        expect(mutation.canRun.value, true);

        expect(
          canRunStream,
          emitsInOrder(<bool>[
            true,
            false,
            true,
          ]),
        );
      });

      test('is updated when the mutation value changes', () async {
        final mutation = mutationSignal<int>(
          canRun: (value) {
            return value.isSuccess;
          },
        );

        final canRunStream = mutation.canRun.toStream();

        expect(mutation.canRun.value, false);
        mutation.setSuccess(1);
        expect(mutation.canRun.value, true);
        mutation.setIdle();
        expect(mutation.canRun.value, false);

        expect(
          canRunStream,
          emitsInOrder(<bool>[
            false,
            true,
            false,
          ]),
        );
      });

      test('is disposed when the mutation is disposed', () async {
        final mutation = mutationSignal<int>();

        expect(mutation.disposed, false);
        expect(mutation.canRun.disposed, false);

        mutation.dispose();

        expect(mutation.disposed, true);
        expect(mutation.canRun.disposed, true);
      });
    });
  });

  group('MutationState', () {
    group('MutationIdle', () {
      test('.new', () {
        final state = MutationState<int>.idle();
        expect(state.isIdle, true);
        expect(state.isPending, false);
        expect(state.isSuccess, false);
        expect(state.isError, false);
        expect(state.isSettled, false);
        expect(state.hasValue, false);
        expect(state.hasError, false);
        expect(state.value, null);
        expect(state.error, null);
        expect(state.stackTrace, null);
        expect(() => state.requireValue, throwsUnsupportedError);
      });

      group('equality', () {
        test('MutationIdle equals', () {
          expect(MutationState<int>.idle(), MutationState<int>.idle());
        });
      });

      test('toString returns correct string', () {
        final state = MutationState<int>.idle();
        expect(state.toString(), 'MutationIdle<int>()');
      });
    });

    group('MutationPending', () {
      test('.new', () {
        final state = MutationState<int>.pending();
        expect(state.isIdle, false);
        expect(state.isPending, true);
        expect(state.isSuccess, false);
        expect(state.isError, false);
        expect(state.isSettled, false);
        expect(state.hasValue, false);
        expect(state.hasError, false);
        expect(state.value, null);
        expect(state.error, null);
        expect(state.stackTrace, null);
        expect(() => state.requireValue, throwsUnsupportedError);
      });

      group('equality', () {
        test('MutationPending equals', () {
          expect(MutationState<int>.pending(), MutationState<int>.pending());
        });
      });

      test('toString returns correct string', () {
        final state = MutationState<int>.pending();
        expect(state.toString(), 'MutationPending<int>()');
      });
    });

    group('MutationSuccess', () {
      test('.new', () {
        final state = MutationState<int>.success(1);
        expect(state.isIdle, false);
        expect(state.isPending, false);
        expect(state.isSuccess, true);
        expect(state.isError, false);
        expect(state.isSettled, true);
        expect(state.hasValue, true);
        expect(state.hasError, false);
        expect(state.value, 1);
        expect(state.error, null);
        expect(state.stackTrace, null);
        expect(state.requireValue, 1);
      });

      group('equality', () {
        test('MutationSuccess equals with same value', () {
          expect(MutationState<int>.success(1), MutationState<int>.success(1));
        });

        test('MutationSuccess not equals with different value', () {
          expect(
            MutationState<int>.success(1) == MutationState<int>.success(0),
            false,
          );
        });
      });

      test('toString returns correct string', () {
        final state = MutationState<int>.success(1);
        expect(state.toString(), 'MutationSuccess<int>(1)');
      });
    });

    group('MutationError', () {
      test('.new', () {
        final stackTrace = StackTrace.current;
        final state = MutationState<int>.error('error', stackTrace);
        expect(state.isIdle, false);
        expect(state.isPending, false);
        expect(state.isSuccess, false);
        expect(state.isError, true);
        expect(state.isSettled, true);
        expect(state.hasValue, false);
        expect(state.hasError, true);
        expect(state.value, null);
        expect(state.error, 'error');
        expect(state.stackTrace, stackTrace);
        expect(() => state.requireValue, throwsUnsupportedError);
      });

      test('.new with default stackTrace', () {
        final s = MutationState<int>.error('error');
        expect(s.isError, true);
        expect(s.error, 'error');
        expect(s.stackTrace, isNotNull);
      });

      group('equality', () {
        test('MutationError equals with same error and stackTrace', () {
          final stackTrace = StackTrace.current;
          expect(
            MutationState<int>.error('error', stackTrace),
            MutationState<int>.error('error', stackTrace),
          );
        });

        test('MutationError not equals with different error', () {
          final stackTrace = StackTrace.current;
          expect(
            MutationState<int>.error('error1', stackTrace) ==
                MutationState<int>.error('error2', stackTrace),
            false,
          );
        });

        test('MutationError not equals with different stackTrace', () {
          expect(
            MutationState<int>.error('error', StackTrace.current) ==
                MutationState<int>.error('error', StackTrace.empty),
            false,
          );
        });
      });

      test('toString returns correct string', () {
        final stackTrace = StackTrace.empty;
        final state = MutationState<int>.error('error', stackTrace);
        expect(
          state.toString(),
          'MutationError<int>(error, $stackTrace)',
        );
      });
    });

    group('MutationSettled', () {
      test('MutationSuccess is MutationSettled', () {
        final state = MutationState<int>.success(1);
        expect(state, isA<MutationSettled<int>>());
      });

      test('MutationError is MutationSettled', () {
        final state = MutationState<int>.error('error', StackTrace.empty);
        expect(state, isA<MutationSettled<int>>());
      });

      test('MutationIdle is not MutationSettled', () {
        final state = MutationState<int>.idle();
        expect(state, isNot(isA<MutationSettled<int>>()));
      });

      test('MutationPending is not MutationSettled', () {
        final state = MutationState<int>.pending();
        expect(state, isNot(isA<MutationSettled<int>>()));
      });

      test('can pattern match on MutationSettled', () {
        MutationState<int> successState = MutationState<int>.success(1);
        MutationState<int> errorState =
            MutationState<int>.error('error', StackTrace.empty);

        String matchSettled(MutationState<int> state) {
          if (state is MutationSettled<int>) {
            return switch (state) {
              MutationSuccess(:final value) => 'success: $value',
              MutationError(:final error) => 'error: $error',
            };
          }
          return 'not settled';
        }

        expect(matchSettled(successState), 'success: 1');
        expect(matchSettled(errorState), 'error: error');
        expect(matchSettled(MutationState<int>.idle()), 'not settled');
        expect(matchSettled(MutationState<int>.pending()), 'not settled');
      });
    });
  });
}
