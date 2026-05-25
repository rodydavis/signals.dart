import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;

  group('Set extensions test', () {
    test('SignalSetExtensions (\$ getter)', () {
      final set = {1, 2, 3};
      final s = set.$;
      expect(s.value, set);
      expect(s, isA<Signal<Set<int>>>());
    });

    test('ReadonlySetSignalExtension methods', () {
      final s = {1, 2, 3}.$;

      expect(s.cast<num>(), isA<Set<num>>());
      expect(s.containsAll([1, 2]), true);
      expect(s.containsAll([1, 4]), false);
      expect(s.difference({2, 3, 4}), {1});
      expect(s.intersection({2, 3, 4}), {2, 3});
      expect(s.lookup(2), 2);
      expect(s.lookup(4), null);
      expect(s.union({3, 4, 5}), {1, 2, 3, 4, 5});
    });

    test('SetSignalExtension mutators notify listeners', () {
      final s = {1, 2, 3}.$;
      var count = 0;
      s.subscribe((_) => count++);

      // Initial subscription
      expect(count, 1);

      final added = s.add(4);
      expect(added, true);
      expect(s.value, {1, 2, 3, 4});
      expect(count, 2);

      s.addAll([5, 6]);
      expect(s.value, {1, 2, 3, 4, 5, 6});
      expect(count, 3);

      final removed = s.remove(6);
      expect(removed, true);
      expect(count, 4);

      s.removeAll([4, 5]);
      expect(s.value, {1, 2, 3});
      expect(count, 5);

      s.removeWhere((x) => x == 3);
      expect(s.value, {1, 2});
      expect(count, 6);

      s.addAll([3, 4, 5]);
      expect(count, 7);

      s.retainAll([1, 2, 3]);
      expect(s.value, {1, 2, 3});
      expect(count, 8);

      s.retainWhere((x) => x < 3);
      expect(s.value, {1, 2});
      expect(count, 9);

      s.clear();
      expect(s.value.isEmpty, true);
      expect(count, 10);
    });
  });
}
