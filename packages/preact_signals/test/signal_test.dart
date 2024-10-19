// ignore_for_file: unnecessary_type_check

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:preact_signals/preact_signals.dart';

import 'utils/spy.dart';

void main() {
  group('signal', () {
    test("should return value", () {
      final v = [1, 2];
      final s = signal(v);
      expect(s.value, v);
    });

    test('should inherit from Signal', () {
      final s = signal(0);
      expect(s is Signal, true);
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
      expect(jsonEncode(s), '123');
    });

    test(
        'should notify other listeners of'
        'changes after one listener is disposed', () {
      final s = signal(0);
      final spy1 = Spy(() => s.value);
      final spy2 = Spy(() => s.value);
      final spy3 = Spy(() => s.value);

      effect(spy1.call);
      final dispose = effect(spy2.call);
      effect(spy3.call);

      expect(spy1.calls, 1);
      expect(spy2.calls, 1);
      expect(spy3.calls, 1);

      dispose();

      s.value = 1;
      expect(spy1.calls, 2);
      expect(spy2.calls, 1);
      expect(spy3.calls, 2);
    });

    group('.peek()', () {
      test('should get value', () {
        final s = signal(1);
        expect(s.peek(), 1);
      });

      test('should get the updated value after a value change', () {
        final s = signal(1);
        s.value = 2;
        expect(s.peek(), 2);
      });

      test('should not make surrounding effect depend on the signal', () {
        final s = signal(1);
        final spy = Spy(() => s.peek());

        effect(spy.call);
        expect(spy.calls, 1);

        s.value = 2;
        expect(spy.calls, 1);
      });

      test('should not make surrounding computed depend on the signal', () {
        final s = signal(1);
        final spy = Spy(() => s.peek());

        final d = computed(spy.call);

        d.value;
        expect(spy.calls, 1);

        s.value = 2;
        d.value;
        expect(spy.calls, 1);
      });
    });

    group('.subscribe()', () {
      test('should subscribe to a signal', () {
        final spy = SpyWithArgs((int val) {});
        final a = signal(1);

        a.subscribe(spy.call);
        expect(spy.lastCalledWith, 1);
      });

      test('should run the callback when the signal value changes', () {
        final spy = SpyWithArgs((int val) {});
        final a = signal(1);

        a.subscribe(spy.call);

        a.value = 2;
        expect(spy.lastCalledWith, 2);
      });

      test('should unsubscribe from a signal', () {
        final spy = SpyWithArgs((int val) {});
        final a = signal(1);

        final dispose = a.subscribe(spy.call);
        dispose();
        spy.resetHistory();

        a.value = 2;
        expect(spy.calls.length, 0);
      });

      test(
          'should not start triggering on when a signal'
          'accessed in the callback changes', () {
        final spy = SpyWithArgs((int val) {});
        final a = signal(1);
        final b = signal(2);

        a.subscribe((val) {
          b.value;
          spy(val);
        });
        expect(spy.calls.length, 1);
        spy.resetHistory();

        b.value++;
        expect(spy.calls.length, 0);
      });

      test(
          'should not cause surrounding effect to'
          'subscribe to changes to a signal accessed in the callback', () {
        final spy = Spy(() {});
        final a = signal(1);
        final b = signal(2);

        effect(() {
          a.subscribe((val) {
            b.value;
          });
          spy();
        });
        expect(spy.calls, 1);
        spy.resetHistory();

        b.value++;
        expect(spy.calls, 0);
      });
    });

    test('signals should be identified with a symbol', () {
      final a = signal(0);
      expect(a.brand, const Symbol('preact-signals'));
    });

    test('should be identified with a symbol', () {
      final a = computed(() {});
      expect(a.brand, const Symbol('preact-signals'));
    });
  });
}
