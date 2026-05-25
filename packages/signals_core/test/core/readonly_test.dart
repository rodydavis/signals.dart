import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;

  group('ReadonlySignal tests', () {
    test('readonly creator default options', () {
      final s = readonly(1);
      expect(s.value, 1);
    });

    test('readonly creator options', () {
      final s = readonly(2, options: ReadonlySignalOptions(name: 'test_name'));
      expect(s.value, 2);
      expect(s.name, 'test_name');
    });

    test('readonly creator deprecated parameters', () {
      // ignore: deprecated_member_use_from_same_package
      final s = readonly(3, autoDispose: true, debugLabel: 'dep_name');
      expect(s.value, 3);
      // ignore: deprecated_member_use_from_same_package
      expect(s.debugLabel, 'dep_name');
    });

    test('onSignalRead global callback hook', () {
      var readCount = 0;
      onSignalRead = (signal) {
        readCount++;
      };

      final s = readonly(100);
      expect(readCount, 0);

      // Accessing value should trigger callback
      final val = s.value;
      expect(val, 100);
      expect(readCount, 1);

      onSignalRead = null;
    });
  });
}
