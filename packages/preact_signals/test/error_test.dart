// ignore_for_file: unnecessary_type_check, prefer_function_declarations_over_variables

import 'package:test/test.dart';
import 'package:preact_signals/preact_signals.dart';

import 'utils/spy.dart';

void main() {
  group('errors', () {
    test('should throw when writing to computeds', () {
      final a = signal('a');
      final b = computed(() => a.value);
      final fn = () => ((b as Signal).value = 'aa');
      // ignore: deprecated_member_use
      expect(fn, throws);
    });

    test('should keep graph consistent on errors during activation', () {
      final a = signal(0);
      final b = computed(() {
        throw Exception('fail');
      });
      final c = computed(() => a.value);
      expect(() => b.value, throwsException);

      a.value = 1;
      expect(c.value, 1);
    });

    test('should keep graph consistent on errors in computeds', () {
      final a = signal(0);
      final b = computed(() {
        if (a.value == 1) {
          throw Exception('fail');
        }
        return a.value;
      });
      final c = computed(() => b.value);
      expect(b.value, 0);

      a.value = 1;
      expect(() => c.value, throwsException);

      a.value = 2;
      expect(c.value, 2);
    });

    test('should support lazy branches', () {
      final a = signal(0);
      final b = computed(() => a.value);
      final c = computed(() => (a.value > 0) ? a.value : b.value);

      expect(c.value, 0);
      a.value = 1;
      expect(c.value, 1);

      a.value = 0;
      expect(c.value, 0);
    });

    test('should not update a sub if all deps unmark it', () {
      final a = signal('a');
      final b = computed(() {
        a.value;
        return 'b';
      });
      final c = computed(() {
        a.value;
        return 'c';
      });
      final spy = Spy(() => '${b.value} ${c.value}');
      final d = computed(spy.call);
      expect(d.value, 'b c');
      spy.resetHistory();

      a.value = 'aa';
      expect(spy.calls, 0);
    });
  });
}
