import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  group('PatternSignalExtension', () {
    test('allMatches on Pattern ReadonlySignal', () {
      final s = signal<Pattern>(RegExp(r'(\w+)'));
      final matches = s.allMatches('Dash is a bird', 8);

      expect(matches.map((m) => m[0]!).toList(), ['a', 'bird']);
    });

    test('matchAsPrefix on Pattern ReadonlySignal', () {
      final s = signal<Pattern>(RegExp(r'bird'));
      final match = s.matchAsPrefix('Dash is a bird', 10);

      expect(match, isNotNull);
      expect(match![0], 'bird');

      final mismatch = s.matchAsPrefix('Dash is a bird');
      expect(mismatch, isNull);
    });

    test(r'$ extension on Pattern', () {
      final RegExp exp = RegExp(r'abc');
      final sig = exp.$;

      expect(sig, isA<Signal<Pattern>>());
      expect(sig.value, exp);
    });
  });
}
