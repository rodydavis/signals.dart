import 'package:signals_core/extended.dart';
import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
  group('Object to signal extensions', () {
    test('Object', () {
      final val = Object();
      final s = val.asSignal();

      expect(s.value, val);
    });

    test('Object', () {
      final val = Object();
      final s = val.$;

      expect(s.value, val);
    });

    test('Object?', () {
      final Object? val = null;
      final s = val.toSignal();

      expect(s.value, null);
    });
  });
}
