import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  group('Comparable extensions tests', () {
    test('ComparableSignalExtension.compareTo compares values correctly', () {
      final s = signal('b');
      expect(s.compareTo('a'), greaterThan(0));
      expect(s.compareTo('b'), 0);
      expect(s.compareTo('c'), lessThan(0));
    });

    test('SignalComparableExtensions.\$ converts Comparable to Signal', () {
      final Comparable<String> comp = 'hello';
      final s = comp.$;
      expect(s, isA<Signal<Comparable<String>>>());
      expect(s.value, 'hello');
    });
  });
}
