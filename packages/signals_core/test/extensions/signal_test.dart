import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  
  group('signal extensions', () {
    test('select', () {
      final a = signal({'a': 1});
      final b = a.select((e) => e.value.keys);

      expect(a.value.keys, b.value);
    });

    test('hooks', () {
      final counter = signal(0);
      final (getCount, setCount) = counter.hooks;

      expect(getCount(), 0);

      setCount(1);

      expect(getCount(), 1);
    });
  });
}
