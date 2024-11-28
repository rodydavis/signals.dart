import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
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

    test('<<', () {
      final a = mapSignal<int, int>({1: 1});
      final b = mapSignal<int, int>({2: 2});

      final value = a << b;

      expect(value.value, {1: 1, 2: 2});
    });

    test('&', () {
      final a = mapSignal<int, int>({1: 1});
      final b = mapSignal<int, int>({2: 2});

      final value = a & b;

      expect(value.value, {1: 1, 2: 2});
    });

    test('|', () {
      final a = mapSignal<int, int>({1: 1});
      final b = mapSignal<int, int>({2: 2});

      final value = a | b;

      expect(value.value, {1: 1, 2: 2});
    });

    test('addAll', () {
      final s = mapSignal<int, int>({1: 1});

      s.addAll({2: 2});

      expect(s.value, {1: 1, 2: 2});
    });

    test('addEntries', () {
      final s = mapSignal<int, int>({1: 1});

      s.addEntries([MapEntry(2, 2)]);

      expect(s.value, {1: 1, 2: 2});
    });

    test('containsValue', () {
      final s = mapSignal<int, int>({1: 1});

      final value = s.containsValue(1);

      expect(value, true);
    });

    test('containsKey', () {
      final s = mapSignal<int, int>({1: 1});

      final value = s.containsKey(1);

      expect(value, true);
    });

    test('entries', () {
      final s = mapSignal<int, int>({1: 1});

      final value = s.entries.toList();

      expect(value.length, 1);
    });

    test('forEach', () {
      final s = mapSignal<int, int>({1: 1});

      var out = '';

      s.forEach((key, value) {
        out += key.toString();
      });

      expect(out, '1');
    });

    test('isEmpty', () {
      final s = mapSignal<int, int>({1: 1});

      final value = s.isEmpty;

      expect(value, false);
    });

    test('isNotEmpty', () {
      final s = mapSignal<int, int>({1: 1});

      final value = s.isNotEmpty;

      expect(value, true);
    });

    test('removeWhere', () {
      final s = mapSignal<int, int>({1: 1});

      s.removeWhere((k, v) => k == 1);
      final value = s.isEmpty;

      expect(value, true);
    });

    test('update', () {
      final s = mapSignal<int, int>({1: 1});

      s.update(1, (v) => 2);
      final value = s[1];

      expect(value, 2);
    });
    test('cast', () {
      final s = mapSignal<int, int>({1: 1});

      final value = s.cast<int, int>();

      // ignore: unnecessary_type_check
      expect(value is Map<int, int>, true);
    });

    test('map', () {
      final s = mapSignal<int, int>({1: 1});

      final value = s.map((k, v) => MapEntry(k, v));

      expect(value.keys.first, 1);
    });

    test('updateAll', () {
      final s = mapSignal<int, int>({1: 1});

      s.updateAll((k, v) => v + 1);
      final value = s[1];

      expect(value, 2);
    });

    test('==', () {
      final s = {1: 1};
      final a = mapSignal(s);
      final b = mapSignal(s);
      final value = a == b;
      expect(value, true);
    });

    test('hashCode', () {
      final s = mapSignal({1: 1});
      final value = s.hashCode != mapSignal({1: 1}).hashCode;
      expect(value, true);
    });
  });
}
