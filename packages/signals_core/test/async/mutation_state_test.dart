import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
  group('MutationState', () {
    test('MutationIdle', () {
      final s = MutationState<int>.idle();
      expect(s, isA<MutationIdle<int>>());
      expect(s.isIdle, true);
      expect(s.isPending, false);
      expect(s.hasError, false);
      expect(s.hasValue, false);
      expect(s.value, null);
      expect(s.error, null);
      expect(s.stackTrace, null);
    });

    test('MutationPending', () {
      final s = MutationState<int>.pending();
      expect(s, isA<MutationPending<int>>());
      expect(s.isIdle, false);
      expect(s.isPending, true);
      expect(s.hasError, false);
      expect(s.hasValue, false);
      expect(s.value, null);
      expect(s.error, null);
      expect(s.stackTrace, null);
    });

    test('MutationSuccess', () {
      final s = MutationState<int>.data(0);
      expect(s, isA<MutationSuccess<int>>());
      expect(s.isIdle, false);
      expect(s.isPending, false);
      expect(s.hasError, false);
      expect(s.hasValue, true);
      expect(s.requireValue, 0);
      expect(s.value, 0);
      expect(s.error, null);
      expect(s.stackTrace, null);
    });

    test('MutationError', () {
      final s = MutationState<int>.error('error');
      expect(s, isA<MutationError<int>>());
      expect(s.isIdle, false);
      expect(s.isPending, false);
      expect(s.hasError, true);
      expect(s.hasValue, false);
      expect(s.value, null);
      expect(s.error, 'error');
      expect(s.stackTrace != null, true);
    });

    group('map', () {
      test('idle', () {
        final s = MutationState<int>.idle();
        final value = s.map(
          idle: () => 'idle',
          pending: () => 'pending',
          data: (v) => 'data $v',
          error: (e, st) => 'error $e',
        );
        expect(value, 'idle');
      });

      test('pending', () {
        final s = MutationState<int>.pending();
        final value = s.map(
          idle: () => 'idle',
          pending: () => 'pending',
          data: (v) => 'data $v',
          error: (e, st) => 'error $e',
        );
        expect(value, 'pending');
      });

      test('data', () {
        final s = MutationState<int>.data(7);
        final value = s.map(
          idle: () => 'idle',
          pending: () => 'pending',
          data: (v) => 'data $v',
          error: (e, st) => 'error $e',
        );
        expect(value, 'data 7');
      });

      test('error with all error arities', () {
        final s = MutationState<int>.error('boom');
        final value = s.map<String>(
          idle: () => 'idle',
          pending: () => 'pending',
          data: (v) => 'data $v',
          error: (e) => 'error $e',
        );
        final value2 = s.map<String>(
          idle: () => 'idle',
          pending: () => 'pending',
          data: (v) => 'data $v',
          error: (e, _) => 'error $e',
        );
        final value3 = s.map<String>(
          idle: () => 'idle',
          pending: () => 'pending',
          data: (v) => 'data $v',
          error: () => 'err',
        );
        expect(value, 'error boom');
        expect(value2, 'error boom');
        expect(value3, 'err');
      });
    });

    group('maybeMap', () {
      test('matches idle', () {
        final s = MutationState<int>.idle();
        final value = s.maybeMap(idle: () => 'idle', orElse: () => 'else');
        expect(value, 'idle');
      });

      test('falls through to orElse', () {
        final s = MutationState<int>.data(0);
        final value =
            s.maybeMap(pending: () => 'pending', orElse: () => 'else');
        expect(value, 'else');
      });

      test('matches data', () {
        final s = MutationState<int>.data(5);
        final value = s.maybeMap(data: (v) => 'data $v', orElse: () => 'else');
        expect(value, 'data 5');
      });
    });

    group('pattern matching', () {
      test('exhaustive switch over the sealed states', () {
        for (final entry in <MutationState<int>, int>{
          MutationState<int>.idle(): 1,
          MutationState<int>.pending(): 2,
          MutationState<int>.data(0): 3,
          MutationState<int>.error('e'): 4,
        }.entries) {
          final result = switch (entry.key) {
            MutationIdle<int>() => 1,
            MutationPending<int>() => 2,
            MutationSuccess<int>() => 3,
            MutationError<int>() => 4,
          };
          expect(result, entry.value);
        }
      });
    });

    test('requireValue throws on non-success states', () {
      expect(
        () => MutationState<int>.idle().requireValue,
        throwsA(isA<UnsupportedError>()),
      );
      expect(
        () => MutationState<int>.pending().requireValue,
        throwsA(isA<UnsupportedError>()),
      );
      expect(
        () => MutationState<int>.error('e').requireValue,
        throwsA(isA<UnsupportedError>()),
      );
    });

    test('equality and hashCode', () {
      expect(MutationState<int>.idle() == MutationState<int>.idle(), isTrue);
      expect(
        MutationState<int>.pending() == MutationState<int>.pending(),
        isTrue,
      );
      expect(MutationState<int>.data(0) == MutationState<int>.data(0), isTrue);
      expect(MutationState<int>.data(0) == MutationState<int>.data(1), isFalse);
      expect(
        MutationState<int>.idle() == MutationState<int>.pending(),
        isFalse,
      );
      expect(MutationState<int>.data(0) == MutationState<int>.idle(), isFalse);

      final st = StackTrace.current;
      final e1 = MutationState<int>.error('e', st);
      final e2 = MutationState<int>.error('e', st);
      final e3 = MutationState<int>.error('x', st);
      expect(e1 == e2, isTrue);
      expect(e1 == e3, isFalse);

      expect(
        MutationState<int>.idle().hashCode,
        MutationState<int>.idle().hashCode,
      );
      expect(MutationState<int>.data(0).hashCode != 0, isTrue);
    });
  });
}
