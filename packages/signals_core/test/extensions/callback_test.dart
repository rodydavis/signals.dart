import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  group('Callback to signal extensions', () {
    test('Object', () {
      final counter = Counter();
      final s = counter.call.toSignal(null);

      expect(s.value, null);

      counter.ref?.call(1);
      expect(s.value, 1);
    });
  });
}

class Counter {
  void Function(int?)? ref;
  void call(void Function(int?) cb) {
    ref = cb;
  }
}
