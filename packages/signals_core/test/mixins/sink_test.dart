// ignore_for_file: unnecessary_type_check

import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

import '../utils/spy.dart';

class _Signal<T> extends Signal<T> with SinkSignalMixin<T> {
  _Signal(super.internalValue);
}

void main() {
  group('Sink', () {
    test('check if extends type', () {
      final s = _Signal(0);

      expect(s.value, 0);
      expect(s is Signal, true);
      expect(s is Sink, true);
    });

    test('add', () {
      final s = _Signal(0);
      final spy = Spy(() {});
      s.subscribe((_) => spy());

      expect(s.value, 0);
      expect(spy.calls, 1);

      s.add(1);

      expect(spy.calls, 2);
      expect(s.value, 1);

      s.value = 2;

      expect(spy.calls, 3);
      expect(s.value, 2);
    });

    test('close', () {
      final s = _Signal(0);

      s.close();

      expect(s.disposed, true);
    });
  });
}
