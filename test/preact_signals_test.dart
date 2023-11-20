import 'dart:convert';

import 'package:preact_signals/src/signals.dart';
import 'package:test/test.dart';

import 'package:preact_signals/preact_signals.dart';

void main() {
  // test('init', () {
  //   // Create signals
  //   final count = signal(0);
  //   final multiplier = signal(2);

  //   // Creating a computed value
  //   final multipliedCount = computed(() {
  //     return count.value * multiplier.value;
  //   });

  //   effect((_) {
  //     print(
  //         'Effect called: Count is ${count.value} and multiplier is ${multiplier.value}');
  //   });

  //   expect(multipliedCount.value, 0);

  //   count.value = 1;
  //   expect(multipliedCount.value, 2);

  //   multiplier.value = 3;
  //   expect(multipliedCount.value, 3);
  // });

  group('signal', () {
    test('should return value', () {
      final v = [1, 2];
      final s = signal(v);
      expect(s.value, v);
    });

    test('should inherit from Signal', () {
      // ignore: unnecessary_type_check
      expect(signal(0) is Signal, true);
    });

    test('should support .toString()', () {
      final s = signal(123);
      expect(s.toString(), '123');
    });

    test('should support .toJson()', () {
      final s = signal(123);
      expect(s.toJson(), 123);
    });

    test('should support jsonEncode()', () {
      final s = signal(123);
      expect(jsonEncode({'s': s}), jsonEncode({'s': 123}));
    });

    test('should support call()', () {
      final s = signal(123);
      expect(s(), 123);

      final a = signal(1);
      final b = signal(2);
      expect(a() + b(), 3);
    });

    test(
        'should notify other listeners of changes after one listener is disposed',
        () {
      final s = signal(123);

      int spy1Count = 0;
      int spy1() {
        spy1Count++;
        return s.value;
      }

      int spy2Count = 0;
      int spy2() {
        spy2Count++;
        return s.value;
      }

      int spy3Count = 0;
      int spy3() {
        spy3Count++;
        return s.value;
      }

      effect(spy1);

      final dispose = effect(spy2);

      effect(spy3);

      expect(spy1Count, 1);
      expect(spy2Count, 1);
      expect(spy3Count, 1);

      dispose();

      s.value = 1;
      expect(spy1Count, 2);
      expect(spy2Count, 1);
      expect(spy3Count, 2);
    });
  });
}
