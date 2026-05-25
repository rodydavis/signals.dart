import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;

  group('Iterable extensions test', () {
    test('SignalIterableExtensions (\$ getter)', () {
      final Iterable<int> iterable = [1, 2, 3];
      final s = iterable.$;
      expect(s.value, iterable);
      expect(s, isA<Signal<Iterable<int>>>());
    });

    test('ReadonlyIterableSignalExtension methods', () {
      final ReadonlySignal<Iterable<int>> s = <int>[1, 2, 3].$;

      expect(s.any((x) => x > 2), true);
      expect(s.cast<num>(), isA<Iterable<num>>());
      expect(s.contains(2), true);
      expect(s.elementAt(1), 2);
      expect(s.every((x) => x > 0), true);
      expect(s.expand((x) => [x, x]), [1, 1, 2, 2, 3, 3]);
      expect(s.first, 1);
      expect(s.firstWhere((x) => x > 1), 2);
      expect(s.fold<int>(0, (prev, element) => prev + element), 6);
      expect(s.followedBy([4, 5]), [1, 2, 3, 4, 5]);
      expect(s.isEmpty, false);
      expect(s.isNotEmpty, true);
      expect(s.iterator, isNotNull);
      expect(s.join(','), '1,2,3');
      expect(s.last, 3);
      expect(s.lastWhere((x) => x > 1), 3);
      expect(s.length, 3);
      expect(s.map((x) => x * 2), [2, 4, 6]);
      expect(s.reduce((a, b) => a + b), 6);

      final ReadonlySignal<Iterable<int>> singleSignal = <int>[4].$;
      expect(singleSignal.single, 4);
      expect(singleSignal.singleWhere((x) => x == 4), 4);

      expect(s.skip(1), [2, 3]);
      expect(s.skipWhile((x) => x < 2), [2, 3]);
      expect(s.take(2), [1, 2]);
      expect(s.takeWhile((x) => x < 3), [1, 2]);
      expect(s.toList(), [1, 2, 3]);
      expect(s.toSet(), {1, 2, 3});
      expect(s.where((x) => x > 1), [2, 3]);
      expect(s.whereType<int>(), [1, 2, 3]);

      var forEachResult = 0;
      s.forEach((element) => forEachResult += element);
      expect(forEachResult, 6);
    });
  });
}
