import 'package:test/test.dart';
import 'package:preact_signals/preact_signals.dart';

import 'utils/spy.dart';

void main() {
  group('action', () {
    test('should wrap a function in batch and untracked', () {
      final a = signal('a');
      final b = signal('b');
      final spy = Spy(() => '${a.value} ${b.value}');
      effect(spy.call);
      spy.resetHistory();

      final myAction = action((String nextA, String nextB) {
        a.value = nextA;
        b.value = nextB;
      });

      myAction('aa', 'bb');

      expect(spy.calls, 1);
      expect(a.value, 'aa');
      expect(b.value, 'bb');
    });

    test('should support up to 6 positional arguments without Function.apply', () {
      final a = signal(0);
      final myAction = action((int a1, int a2, int a3, int a4, int a5, int a6) {
        a.value = a1 + a2 + a3 + a4 + a5 + a6;
      });

      myAction(1, 2, 3, 4, 5, 6);
      expect(a.value, 21);
    });

    test('action0 should wrap a 0-argument function type-safely', () {
      final a = signal('a');
      final b = signal('b');
      final spy = Spy(() => '${a.value} ${b.value}');
      effect(spy.call);
      spy.resetHistory();

      final myAction0 = action0(() {
        a.value = 'aa';
        b.value = 'bb';
      });

      myAction0();
      expect(spy.calls, 1);
      expect(a.value, 'aa');
      expect(b.value, 'bb');
    });

    test('action1 should wrap a 1-argument function type-safely', () {
      final a = signal('a');
      final myAction1 = action1((String val) {
        a.value = val;
      });

      myAction1('xx');
      expect(a.value, 'xx');
    });

    test('action2 should wrap a 2-argument function type-safely', () {
      final a = signal('a');
      final b = signal('b');
      final myAction2 = action2((String nextA, String nextB) {
        a.value = nextA;
        b.value = nextB;
      });

      myAction2('yy', 'zz');
      expect(a.value, 'yy');
      expect(b.value, 'zz');
    });

    test('action3 should wrap a 3-argument function type-safely', () {
      final a = signal('a');
      final myAction3 = action3((String val1, String val2, String val3) {
        a.value = '$val1 $val2 $val3';
      });

      myAction3('1', '2', '3');
      expect(a.value, '1 2 3');
    });

    test('action4 should wrap a 4-argument function type-safely', () {
      final a = signal('a');
      final myAction4 = action4((String val1, String val2, String val3, String val4) {
        a.value = '$val1 $val2 $val3 $val4';
      });

      myAction4('1', '2', '3', '4');
      expect(a.value, '1 2 3 4');
    });

    test('action5 should wrap a 5-argument function type-safely', () {
      final a = signal('a');
      final myAction5 = action5((String val1, String val2, String val3, String val4, String val5) {
        a.value = '$val1 $val2 $val3 $val4 $val5';
      });

      myAction5('1', '2', '3', '4', '5');
      expect(a.value, '1 2 3 4 5');
    });

    test('action6 should wrap a 6-argument function type-safely', () {
      final a = signal('a');
      final myAction6 = action6((String val1, String val2, String val3, String val4, String val5, String val6) {
        a.value = '$val1 $val2 $val3 $val4 $val5 $val6';
      });

      myAction6('1', '2', '3', '4', '5', '6');
      expect(a.value, '1 2 3 4 5 6');
    });
  });
}
