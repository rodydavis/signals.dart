import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  group('map signal', () {
    test('make sure list is the same object', () {
      final map = <String, int>{'a': 1, 'b': 2, 'c': 3};
      final s = map.toSignal();
      expect(map, s);
    });

    test('check if hash code is the same', () {
      final a = <String, int>{'a': 1, 'b': 2, 'c': 3};
      final b = <String, int>{'a': 1, 'b': 2, 'c': 3};

      final s1 = a.toSignal();
      final s2 = b.toSignal();

      expect(a != b, true);
      expect(s1 != s2, true);
    });

    test('add new items', () {
      final set = <String, int>{'a': 1, 'b': 2, 'c': 3};
      final s = set.toSignal();

      expect(s.length, 3);

      s['d'] = 4;

      expect(s.length, 4);
      expect(s.keys.last, 'd');
    });

    test('remove items', () {
      final set = <String, int>{'a': 1, 'b': 2, 'c': 3};
      final s = set.toSignal();

      expect(s.length, 3);

      s.remove('c');

      expect(s.length, 2);
      expect(s.containsKey('c'), false);
    });
  });
}
