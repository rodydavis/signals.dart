import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;

  group('Primitive extensions test', () {
    test('Bool extensions', () {
      final s = true.$;
      expect(s.value, true);
      expect(s & false, false);
      expect(s | false, true);
      expect(s ^ false, true);
    });

    test('Num extensions', () {
      final s = 5.0.$;
      expect(s.value, 5.0);
      expect(s + 3, 8.0);
      expect(s - 3, 2.0);
      expect(s * 3, 15.0);
      expect(s % 3, 2.0);
      expect(s / 2, 2.5);
      expect(s ~/ 2, 2);
      expect(-s, -5.0);
      expect(s.remainder(3), 2.0);
      expect(s < 6, true);
      expect(s <= 5, true);
      expect(s > 4, true);
      expect(s >= 5, true);
      expect(s.isNaN, false);
      expect(s.isNegative, false);
      expect(s.isInfinite, false);
      expect(s.isFinite, true);
      expect(s.abs(), 5.0);
      expect(s.sign, 1.0);
      expect(s.round(), 5);
      expect(s.floor(), 5);
      expect(s.ceil(), 5);
      expect(s.truncate(), 5);
      expect(s.roundToDouble(), 5.0);
      expect(s.floorToDouble(), 5.0);
      expect(s.ceilToDouble(), 5.0);
      expect(s.truncateToDouble(), 5.0);
      expect(s.clamp(1.0, 10.0), 5.0);
      expect(s.toInt(), 5);
      expect(s.toDouble(), 5.0);
      expect(s.toStringAsFixed(1), '5.0');
      expect(s.toStringAsExponential(1), '5.0e+0');
      expect(s.toStringAsPrecision(2), '5.0');
    });

    test('NumSignalExtension cast tests', () {
      final ReadonlySignal<num> s = 5.0.$;
      expect(s + 3, 8.0);
      expect(s - 3, 2.0);
      expect(s * 3, 15.0);
      expect(s % 3, 2.0);
      expect(s / 2, 2.5);
      expect(s ~/ 2, 2);
      expect(-s, -5.0);
      expect(s.remainder(3), 2.0);
      expect(s < 6, true);
      expect(s <= 5, true);
      expect(s > 4, true);
      expect(s >= 5, true);
      expect(s.isNaN, false);
      expect(s.isNegative, false);
      expect(s.isInfinite, false);
      expect(s.isFinite, true);
      expect(s.abs(), 5.0);
      expect(s.sign, 1.0);
      expect(s.round(), 5);
      expect(s.floor(), 5);
      expect(s.ceil(), 5);
      expect(s.truncate(), 5);
      expect(s.roundToDouble(), 5.0);
      expect(s.floorToDouble(), 5.0);
      expect(s.ceilToDouble(), 5.0);
      expect(s.truncateToDouble(), 5.0);
      expect(s.clamp(1.0, 10.0), 5.0);
      expect(s.toInt(), 5);
      expect(s.toDouble(), 5.0);
      expect(s.toStringAsFixed(1), '5.0');
      expect(s.toStringAsExponential(1), '5.0e+0');
      expect(s.toStringAsPrecision(2), '5.0');
    });

    test('Int extensions', () {
      final s = 10.$;
      expect(s.value, 10);
      expect(s & 2, 2);
      expect(s | 2, 10);
      expect(s ^ 2, 8);
      expect(~s, -11);
      expect(s << 1, 20);
      expect(s >> 1, 5);
      expect(s >>> 1, 5);
      expect(s.modPow(2, 3), 1);
      expect(s.modInverse(3), 1);
      expect(s.gcd(4), 2);
      expect(s.isEven, true);
      expect(s.isOdd, false);
      expect(s.bitLength, 4);
      expect(s.toUnsigned(4), 10);
      expect(s.toSigned(4), -6);
      expect(-s, -10);
      expect(s.abs(), 10);
      expect(s.sign, 1);
      expect(s.round(), 10);
      expect(s.floor(), 10);
      expect(s.ceil(), 10);
      expect(s.truncate(), 10);
      expect(s.roundToDouble(), 10.0);
      expect(s.floorToDouble(), 10.0);
      expect(s.ceilToDouble(), 10.0);
      expect(s.truncateToDouble(), 10.0);
      expect(s.toRadixString(16), 'a');
    });

    test('Double extensions', () {
      final s = 2.5.$;
      expect(s.value, 2.5);
      expect(s.remainder(1.5), 1.0);
      expect(s.abs(), 2.5);
      expect(s.sign, 1.0);
      expect(s.round(), 3);
      expect(s.floor(), 2);
      expect(s.ceil(), 3);
      expect(s.truncate(), 2);
      expect(s.roundToDouble(), 3.0);
      expect(s.floorToDouble(), 2.0);
      expect(s.ceilToDouble(), 3.0);
      expect(s.truncateToDouble(), 2.0);
    });

    test('String extensions', () {
      final s = '  Dart signals  '.$;
      expect(s.value, '  Dart signals  ');
      expect(s[2], 'D');
      expect(s.codeUnitAt(2), 68);
      expect(s.length, 16);
      expect(s.endsWith(' '), true);
      expect(s.startsWith(' '), true);
      expect(s.indexOf('s'), 7);
      expect(s.lastIndexOf('s'), 13);
      expect(s.isEmpty, false);
      expect(s.isNotEmpty, true);
      expect(s + '!', '  Dart signals  !');
      expect(s.substring(2, 6), 'Dart');
      expect(s.trim(), 'Dart signals');
      expect(s.trimLeft(), 'Dart signals  ');
      expect(s.trimRight(), '  Dart signals');
      expect('Hi'.$ * 3, 'HiHiHi');
      expect('x'.$.padLeft(4, 'y'), 'yyyx');
      expect('x'.$.padRight(4, 'y'), 'xyyy');
      expect(s.contains('Dart'), true);
      expect('Dart'.$.replaceFirst('a', 'o'), 'Dort');
      expect('Dart'.$.replaceFirstMapped('a', (m) => 'o'), 'Dort');
      expect('Dart'.$.replaceAll('a', 'o'), 'Dort');
      expect('Dart'.$.replaceAllMapped('a', (m) => 'o'), 'Dort');
      expect('Dart'.$.replaceRange(1, 3, 'o'), 'Dot');
      expect('a b'.$.split(' '), ['a', 'b']);
      expect(
        'a b'.$.splitMapJoin(' ', onMatch: (m) => '-', onNonMatch: (n) => n),
        'a-b',
      );
      expect('a'.$.codeUnits, [97]);
      expect('a'.$.runes.toList(), [97]);
      expect('DART'.$.toLowerCase(), 'dart');
      expect('dart'.$.toUpperCase(), 'DART');
    });
  });
}
