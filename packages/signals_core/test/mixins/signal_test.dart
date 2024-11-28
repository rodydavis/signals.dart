import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

class TrackedSignal<T> extends Signal<T> with TrackedSignalMixin<T> {
  TrackedSignal(super.internalValue);
}

void main() {
  group('TrackedSignal', () {
    test('previousValue', () {
      int i = 0;
      final s = TrackedSignal(i++);
      s.value++;
      s.value++;
      expect(s.previousValue, 1);
      expect(s.value, 2);
    });

    test('initialValue', () {
      final s = TrackedSignal(1);
      expect(s.value, 1);
      expect(s.initialValue, 1);
    });
  });
}
