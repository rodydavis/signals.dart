import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;

  group('Map extensions test', () {
    test('SignalMapExtensions (\$ getter)', () {
      final map = {'a': 1, 'b': 2};
      final s = map.$;
      expect(s.value, map);
      expect(s, isA<Signal<Map<String, int>>>());
    });

    test('ReadonlyMapSignalExtension methods', () {
      final ReadonlySignal<Map<String, int>> s = {'a': 1, 'b': 2}.$;

      expect(s['a'], 1);
      expect(s['c'], null);
      expect(s.cast<String, num>(), isA<Map<String, num>>());
      expect(s.containsKey('a'), true);
      expect(s.containsKey('c'), false);
      expect(s.containsValue(2), true);
      expect(s.containsValue(3), false);
      expect(s.entries.length, 2);
      expect(s.isEmpty, false);
      expect(s.isNotEmpty, true);
      expect(s.keys, ['a', 'b']);
      expect(s.length, 2);
      expect(s.map((k, v) => MapEntry(k.toUpperCase(), v * 2)), {'A': 2, 'B': 4});
      expect(s.values, [1, 2]);
    });

    test('MapSignalExtension mutators notify listeners', () {
      final s = {'a': 1, 'b': 2}.$;
      var count = 0;
      s.subscribe((_) => count++);

      // Initial subscription
      expect(count, 1);

      s['c'] = 3;
      expect(s.value['c'], 3);
      expect(count, 2);

      s.addAll({'d': 4, 'e': 5});
      expect(s.value.length, 5);
      expect(count, 3);

      s.addEntries([const MapEntry('f', 6)]);
      expect(s.value['f'], 6);
      expect(count, 4);

      s.forEach((k, v) {});
      expect(count, 5);

      final val = s.putIfAbsent('g', () => 7);
      expect(val, 7);
      expect(count, 6);

      final removed = s.remove('g');
      expect(removed, 7);
      expect(count, 7);

      s.removeWhere((k, v) => k == 'f');
      expect(s.value.containsKey('f'), false);
      expect(count, 8);

      final updated = s.update('a', (v) => v * 10);
      expect(updated, 10);
      expect(count, 9);

      s.updateAll((k, v) => v + 1);
      expect(s.value['a'], 11);
      expect(count, 10);

      s.clear();
      expect(s.value.isEmpty, true);
      expect(count, 11);
    });
  });
}
