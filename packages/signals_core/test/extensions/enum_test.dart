import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

enum TestEnum {
  first,
  second,
}

void main() {
  SignalsObserver.instance = null;

  group('Enum Signal Extensions tests', () {
    test('EnumSignalExtension properties index and name', () {
      final s = signal(TestEnum.second);
      final r = s.readonly();
      expect(r.index, 1);
      expect(EnumSignalExtension(r).name, 'second');
    });

    test('SignalEnumExtensions property \$', () {
      final s = TestEnum.first.$;
      expect(s.value, TestEnum.first);
    });
  });
}
