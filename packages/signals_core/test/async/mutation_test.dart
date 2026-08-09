import 'dart:async';

import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
  group('MutationSignal', () {
    test('starts idle before being run', () {
      final m = mutationSignal<int, int>((arg) async => arg * 2);
      expect(m.peek(), isA<MutationIdle<int>>());
      expect(m.peek().isIdle, true);
      expect(m.variables, isNull);
    });

    test('mutateAsync resolves with the result and stores success', () async {
      final m = mutationSignal<int, int>((arg) async => arg * 2);
      final result = await m.mutateAsync(21);
      expect(result, 42);
      expect(m.peek(), isA<MutationSuccess<int>>());
      expect(m.peek().requireValue, 42);
      expect(m.variables, 21);
    });

    test('transitions to pending synchronously while running', () async {
      final completer = Completer<int>();
      final m = mutationSignal<int, int>((arg) => completer.future);
      final future = m.mutateAsync(1);
      expect(m.peek(), isA<MutationPending<int>>());
      expect(m.variables, 1);
      completer.complete(5);
      await future;
      expect(m.peek(), isA<MutationSuccess<int>>());
      expect(m.peek().requireValue, 5);
    });

    test('mutate is fire-and-forget and updates state', () async {
      final m = mutationSignal<int, int>((arg) async => arg + 1);
      m.mutate(10);
      expect(m.peek(), isA<MutationPending<int>>());
      await m.future;
      expect(m.peek().requireValue, 11);
    });

    test('errors transition to MutationError and mutateAsync throws', () async {
      final m =
          mutationSignal<int, int>((arg) async => throw StateError('nope'));
      await expectLater(m.mutateAsync(1), throwsA(isA<StateError>()));
      expect(m.peek(), isA<MutationError<int>>());
      expect(m.peek().hasError, true);
      expect(m.peek().error, isA<StateError>());
      expect(m.peek().stackTrace, isNotNull);
    });

    test('mutate swallows errors but still records MutationError', () async {
      final m =
          mutationSignal<int, int>((arg) async => throw StateError('nope'));
      m.mutate(1);
      // Should not throw an unhandled error.
      await Future<void>.delayed(Duration.zero);
      expect(m.peek(), isA<MutationError<int>>());
    });

    test('mutate calls onSuccess with the result', () async {
      final m = mutationSignal<int, int>((arg) async => arg * 2);
      int? success;
      Object? failure;
      m.mutate(
        21,
        onSuccess: (data) => success = data,
        onError: (error, _) => failure = error,
      );
      await m.future;
      // Let the .then callback microtask run.
      await Future<void>.delayed(Duration.zero);
      expect(success, 42);
      expect(failure, isNull);
    });

    test('mutate calls onError with the error and stack trace', () async {
      final err = StateError('nope');
      final m = mutationSignal<int, int>((arg) async => throw err);
      int? success;
      Object? failure;
      StackTrace? trace;
      m.mutate(
        1,
        onSuccess: (data) => success = data,
        onError: (error, stackTrace) {
          failure = error;
          trace = stackTrace;
        },
      );
      // Should not throw an unhandled error.
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);
      expect(success, isNull);
      expect(failure, same(err));
      expect(trace, isNotNull);
    });

    test('retry re-runs the last mutation with the same variables', () async {
      final args = <int>[];
      final m = mutationSignal<int, int>((arg) async {
        args.add(arg);
        return arg * 2;
      });
      await m.mutateAsync(21);
      expect(args, [21]);

      m.retry();
      expect(m.peek(), isA<MutationPending<int>>());
      await m.future;
      expect(args, [21, 21]);
      expect(m.peek().requireValue, 42);
      expect(m.variables, 21);
    });

    test('retry forwards onSuccess/onError callbacks', () async {
      final m = mutationSignal<int, int>((arg) async => arg * 2);
      await m.mutateAsync(21);
      int? success;
      m.retry(onSuccess: (data) => success = data);
      await m.future;
      await Future<void>.delayed(Duration.zero);
      expect(success, 42);
    });

    test('retry throws when the mutation has never been run', () {
      final m = mutationSignal<int, int>((arg) async => arg);
      expect(m.retry, throwsA(isA<StateError>()));
    });

    test('retry throws after reset', () async {
      final m = mutationSignal<int, int>((arg) async => arg);
      await m.mutateAsync(1);
      m.reset();
      expect(m.retry, throwsA(isA<StateError>()));
    });

    test('reset returns the signal to idle', () async {
      final m = mutationSignal<int, int>((arg) async => arg);
      await m.mutateAsync(3);
      expect(m.peek(), isA<MutationSuccess<int>>());
      m.reset();
      expect(m.peek(), isA<MutationIdle<int>>());
      expect(m.variables, isNull);
    });

    test('only the latest mutation updates the state (race protection)',
        () async {
      final c1 = Completer<int>();
      final c2 = Completer<int>();
      var calls = 0;
      final m = mutationSignal<int, int>((arg) {
        calls++;
        return calls == 1 ? c1.future : c2.future;
      });

      final f1 = m.mutateAsync(1);
      final f2 = m.mutateAsync(2);

      // The second (latest) call resolves first.
      c2.complete(20);
      expect(await f2, 20);
      expect(m.peek().requireValue, 20);

      // The stale first call resolves later and must NOT overwrite state.
      c1.complete(10);
      expect(await f1, 10);
      expect(m.peek().requireValue, 20);
    });

    test('reset cancels an in-flight mutation from affecting state', () async {
      final completer = Completer<int>();
      final m = mutationSignal<int, int>((arg) => completer.future);
      final future = m.mutateAsync(1);
      m.reset();
      expect(m.peek(), isA<MutationIdle<int>>());
      completer.complete(99);
      await future;
      expect(m.peek(), isA<MutationIdle<int>>());
    });

    test('reset detaches a future captured before it so it never hangs',
        () async {
      final completer = Completer<int>();
      final m = mutationSignal<int, int>((arg) => completer.future);
      m.mutate(1);
      final pending = m.future; // captured while in-flight
      m.reset();
      // Must settle (with an error) rather than hang forever.
      await expectLater(pending, throwsA(isA<StateError>()));
      completer.complete(5); // stale completion, ignored
      expect(m.peek(), isA<MutationIdle<int>>());
    });

    test('a fresh future is created after reset', () async {
      final m = mutationSignal<int, int>((arg) async => arg);
      await m.mutateAsync(1);
      m.reset();
      final result = await m.mutateAsync(2);
      expect(result, 2);
      expect(await m.future, 2);
    });

    test('can be configured with options', () {
      final m = mutationSignal<int, int>(
        (arg) async => arg,
        options: SignalOptions<MutationState<int>>(name: 'saver'),
      );
      expect(m.name, 'saver');
    });

    test('is reactive inside an effect', () async {
      final m = mutationSignal<int, int>((arg) async => arg);
      final seen = <MutationState<int>>[];
      final dispose = effect(() => seen.add(m.value));
      await m.mutateAsync(7);
      dispose();
      expect(seen.first, isA<MutationIdle<int>>());
      expect(seen.any((s) => s is MutationPending<int>), isTrue);
      expect(seen.last, isA<MutationSuccess<int>>());
      expect(seen.last.requireValue, 7);
    });

    test('supports record arguments for multiple variables', () async {
      final m = mutationSignal<(int, int), int>((args) async {
        final (a, b) = args;
        return a + b;
      });
      final result = await m.mutateAsync((2, 3));
      expect(result, 5);
      expect(m.variables, (2, 3));
    });
  });
}
