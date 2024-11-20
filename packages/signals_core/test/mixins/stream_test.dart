// ignore_for_file: unnecessary_type_check

import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

class _Signal<T> extends Signal<T> with StreamSignalMixin<T> {
  _Signal(super.internalValue);
}

void main() {
  group('Stream', () {
    test('check if extends type', () {
      final s = _Signal(0);

      expect(s.value, 0);
      expect(s is Signal, true);
      expect(s is Stream, true);
    });

    test('values', () async {
      final s = _Signal(0);

      final matcher = expectLater(
        s,
        emitsInOrder([0, 1, 2]),
      );

      s.value = 1;
      s.value = 2;

      await matcher;
      s.dispose();
    });
  });
}
