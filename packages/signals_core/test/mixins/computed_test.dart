import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

class TrackedComputed<T> extends Computed<T> with TrackedSignalMixin<T> {
  TrackedComputed(super.fn);
}

void main() {
  group('TrackedComputed', () {
    test('previousValue', () {
      int i = 0;
      final s = TrackedComputed(() => i++);
      s.recompute();
      s.recompute();
      expect(s.previousValue, 1);
      expect(s.value, 2);
    });

    test('initialValue', () {
      final s = TrackedComputed(() => 1);
      expect(s.value, 1);
      expect(s.initialValue, 1);
    });
    test('new computed value from signal', () {
      final i = signal(0);
      final s = TrackedComputed(() => i.value);
      i.value = 1;
      expect(s.value, 1);
      i.value = 2;
      expect(s.value, 2);
      expect(s.previousValue, 1);
    });
  });
}
