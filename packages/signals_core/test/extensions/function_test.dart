import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;

  group('Function Signal Extensions tests', () {
    test('SignalFunctionExtensions property \$', () {
      final a = signal(1);
      final b = signal(2);
      final c = (() => a.value + b.value).$;
      expect(c.value, 3);

      a.value = 10;
      expect(c.value, 12);
    });
  });
}
