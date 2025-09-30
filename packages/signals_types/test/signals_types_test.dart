import 'package:flutter_test/flutter_test.dart';
import 'package:signals_types/signals_types.dart';

import 'impl/signal.dart';

void main() {
  group('signal', () {
    test('debugLabel test', () {
      final s = SimpleSignal(
        0,
        SignalOptions(debugLabel: 'Test'),
      );

      expect(s.value, 0);
      expect(s.options.debugLabel, 'Test');
    });

    test('get/set test', () {
      final s = SimpleSignal(0);

      expect(s.value, 0);

      s.value++;

      expect(s.value, 1);
    });

    test('equality test', () {
      final s = SimpleSignal<Map<String, dynamic>>(
        {'value': 0},
        SignalOptions(
          equalityCheck: (a, b) => a['value'] == b['value'],
        ),
      );

      expect(s.value, {'value': 0});

      final c = s.value;
      c['value'] = c['value'] + 1;
      s.value = c;

      expect(s.value, {'value': 1});
    });
  });
}
