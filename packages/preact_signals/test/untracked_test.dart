// ignore_for_file: unnecessary_type_check

import 'package:test/test.dart';
import 'package:preact_signals/preact_signals.dart';

import 'utils/spy.dart';

void main() {
  group('untracked', () {
    test('should block tracking inside effects', () {
      final a = signal(1);
      final b = signal(2);
      final spy = Spy(() => a.value + b.value);
      effect(() => untracked(spy.call));
      expect(spy.calls, 1);

      a.value = 10;
      b.value = 20;
      expect(spy.calls, 1);
    });

    test(
        'should block tracking even when run inside effect run inside untracked',
        () {
      final a = signal(1);
      final spy = Spy(() => a.value);

      untracked(() {
        effect(() => untracked(spy.call));
      });
      expect(spy.calls, 1);

      a.value = 2;
      expect(spy.calls, 1);
    });

    test('should not cause signal assignments throw', () {
      final a = signal(1);
      final aChangedTime = signal(0);

      final dispose = effect(() {
        a.value;
        untracked(() {
          aChangedTime.value = aChangedTime.value + 1;
        });
      });

      expect(() => (a.value = 2), returnsNormally);
      expect(aChangedTime.value, 2);
      a.value = 3;
      expect(aChangedTime.value, 3);

      dispose();
    });

    test('should block tracking inside computed signals', () {
      final a = signal(1);
      final b = signal(2);
      final spy = Spy(() => a.value + b.value);
      final c = computed(() => untracked(spy.call));

      expect(spy.calls, 0);
      expect(c.value, 3);
      a.value = 10;
      c.value;
      b.value = 20;
      c.value;
      expect(spy.calls, 1);
      expect(c.value, 3);
    });
  });
}
