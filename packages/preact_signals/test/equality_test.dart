import 'package:preact_signals/preact_signals.dart';
import 'package:test/test.dart';

void main() {
  group('SignalEquality', () {
    test('standard equality', () {
      final eq = SignalEquality.standard<int>();
      expect(eq.equals(1, 1), isTrue);
      expect(eq.equals(1, 2), isFalse);
    });

    test('identity equality', () {
      final eq = SignalEquality.identity<List<int>>();
      final list1 = [1, 2];
      final list2 = [1, 2];
      expect(eq.equals(list1, list1), isTrue);
      expect(eq.equals(list1, list2), isFalse);
    });

    test('custom equality', () {
      final eq = SignalEquality.custom((int a, int b) => a.isEven == b.isEven);
      expect(eq.equals(2, 4), isTrue);
      expect(eq.equals(2, 3), isFalse);
      expect(eq.equals('not an int', 4), isFalse);
      expect(eq.equals(2, 'not an int'), isFalse);
    });

    group('deep equality', () {
      final eq = SignalEquality.deep();

      test('identical objects', () {
        final obj = Object();
        expect(eq.equals(obj, obj), isTrue);
      });

      test('non-collection objects', () {
        expect(eq.equals(1, 1), isTrue);
        expect(eq.equals(1, 2), isFalse);
        expect(eq.equals(null, null), isTrue);
        expect(eq.equals(1, null), isFalse);
      });

      test('lists recursive comparison', () {
        expect(eq.equals([1, 2], [1, 2]), isTrue);
        expect(eq.equals([1, 2], [1, 3]), isFalse);
        expect(eq.equals([1, 2], [1, 2, 3]), isFalse);
        expect(
            eq.equals([
              [1]
            ], [
              [1]
            ]),
            isTrue);
        expect(
            eq.equals([
              [1]
            ], [
              [2]
            ]),
            isFalse);
      });

      test('maps recursive comparison', () {
        expect(eq.equals({'a': 1}, {'a': 1}), isTrue);
        expect(eq.equals({'a': 1}, {'a': 2}), isFalse);
        expect(eq.equals({'a': 1}, {'b': 1}), isFalse);
        expect(eq.equals({'a': 1}, {'a': 1, 'b': 2}), isFalse);
        expect(
            eq.equals({
              'a': {'b': 1}
            }, {
              'a': {'b': 1}
            }),
            isTrue);
        expect(
            eq.equals({
              'a': {'b': 1}
            }, {
              'a': {'b': 2}
            }),
            isFalse);
      });

      test('sets comparison', () {
        expect(eq.equals({1, 2}, {1, 2}), isTrue);
        expect(eq.equals({1, 2}, {2, 1}), isTrue);
        expect(eq.equals({1, 2}, {1, 3}), isFalse);
        expect(eq.equals({1, 2}, {1, 2, 3}), isFalse);

        // Nested deep comparison in sets
        expect(
            eq.equals({
              {1, 2},
              [3, 4]
            }, {
              [3, 4],
              {2, 1}
            }),
            isTrue);
        expect(
            eq.equals({
              {1, 2},
              [3, 4]
            }, {
              [3, 5],
              {2, 1}
            }),
            isFalse);
      });

      test('mismatched collection types', () {
        expect(eq.equals([1, 2], {1, 2}), isFalse);
        expect(eq.equals({'a': 1}, [1]), isFalse);
      });
    });
  });
}
