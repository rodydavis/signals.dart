import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;

  group('List extensions test', () {
    test('SignalListExtensions (\$ getter)', () {
      final list = [1, 2, 3];
      final s = list.$;
      expect(s.value, list);
      expect(s, isA<Signal<List<int>>>());
    });

    test('ReadonlyListSignalExtension', () {
      final ReadonlySignal<List<int>> s = [1, 2, 3].$;

      expect(s.cast<num>(), isA<List<num>>());
      expect(s.last, 3);
      expect(s + [4, 5], [1, 2, 3, 4, 5]);
      expect(s[1], 2);
      expect(s.asMap(), {0: 1, 1: 2, 2: 3});
      expect(s.expand((x) => [x, x]), [1, 1, 2, 2, 3, 3]);
      expect(s.firstWhere((x) => x > 1), 2);
      expect(s.fold<int>(0, (prev, element) => prev + element), 6);
      expect(s.followedBy([4, 5]), [1, 2, 3, 4, 5]);
      expect(s.getRange(1, 3), [2, 3]);
      expect(s.indexOf(2), 1);
      expect(s.indexWhere((x) => x == 3), 2);
      expect(s.lastIndexOf(2), 1);
      expect(s.lastIndexWhere((x) => x == 2), 1);
      expect(s.reversed, [3, 2, 1]);
      expect(s.sorted((a, b) => b.compareTo(a)), [3, 2, 1]);
      expect(s.sublist(1, 3), [2, 3]);
    });

    test('ListSignalExtension mutators notify listeners', () {
      final s = [1, 2, 3].$;
      var count = 0;
      s.subscribe((_) => count++);

      // Initial subscription
      expect(count, 1);

      s.first = 10;
      expect(s.value.first, 10);
      expect(count, 2);

      s.last = 30;
      expect(s.value.last, 30);
      expect(count, 3);

      s.length = 2;
      expect(s.value.length, 2);
      expect(count, 4);

      s[1] = 20;
      expect(s.value[1], 20);
      expect(count, 5);

      s.add(40);
      expect(s.value.last, 40);
      expect(count, 6);

      s.addAll([50, 60]);
      expect(s.value.sublist(3), [50, 60]);
      expect(count, 7);

      s.fillRange(1, 3, 99);
      expect(s.value.sublist(1, 3), [99, 99]);
      expect(count, 8);

      s.insert(1, 15);
      expect(s.value[1], 15);
      expect(count, 9);

      s.insertAll(1, [16, 17]);
      expect(s.value.sublist(1, 3), [16, 17]);
      expect(count, 10);

      final removed = s.remove(17);
      expect(removed, true);
      expect(count, 11);

      final removedAt = s.removeAt(1);
      expect(removedAt, 16);
      expect(count, 12);

      final removedLast = s.removeLast();
      expect(removedLast, 60);
      expect(count, 13);

      s.removeRange(1, 3);
      expect(count, 14);

      s.removeWhere((x) => x == 99);
      expect(count, 15);

      s.replaceRange(0, 1, [100, 200]);
      expect(count, 16);

      s.retainWhere((x) => x > 100);
      expect(s.value, [200]);
      expect(count, 17);

      s.setAll(0, [300]);
      expect(s.value, [300]);
      expect(count, 18);

      s.addAll([400, 500]);
      expect(count, 19);

      s.setRange(1, 3, [600, 700]);
      expect(s.value, [300, 600, 700]);
      expect(count, 20);

      s.shuffle();
      expect(count, 21);

      s.sort();
      expect(s.value, [300, 600, 700]);
      expect(count, 22);

      s.clear();
      expect(s.value.isEmpty, true);
      expect(count, 23);
    });
  });
}
