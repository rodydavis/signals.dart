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

    test('should accept options parameter', () {
      final a = signal('a');
      final myAction = action((String val) {
        a.value = val;
      }, options: const ActionOptions(name: 'my-action'));
      myAction('opt');
      expect(a.value, 'opt');
    });

    test('should support up to 6 positional arguments without Function.apply', () {
      final a = signal(0);
      final myAction = action((int a1, int a2, int a3, int a4, int a5, int a6) {
        a.value = a1 + a2 + a3 + a4 + a5 + a6;
      });

      myAction(1, 2, 3, 4, 5, 6);
      expect(a.value, 21);
    });

    test('toAction extensions should be type-safe and run in batch/untracked', () {
      final a = signal('a');
      final b = signal('b');
      final spy = Spy(() => '${a.value} ${b.value}');
      effect(spy.call);
      spy.resetHistory();

      // 0-argument extension
      final myAction0 = (() {
        a.value = 'aa';
        b.value = 'bb';
      }).toAction();

      myAction0();
      expect(spy.calls, 1);
      expect(a.value, 'aa');
      expect(b.value, 'bb');

      // 1-argument extension
      final myAction1 = ((String val) {
        a.value = val;
        b.value = val;
      }).toAction();

      myAction1('xx');
      expect(spy.calls, 2);
      expect(a.value, 'xx');
      expect(b.value, 'xx');

      // 2-argument extension
      final myAction2 = ((String nextA, String nextB) {
        a.value = nextA;
        b.value = nextB;
      }).toAction();

      myAction2('yy', 'zz');
      expect(spy.calls, 3);
      expect(a.value, 'yy');
      expect(b.value, 'zz');

      // 3-argument extension
      final myAction3 = ((String aVal, String bVal, String cVal) {
        a.value = '$aVal $bVal $cVal';
      }).toAction();

      myAction3('1', '2', '3');
      expect(a.value, '1 2 3');

      // 4-argument extension
      final myAction4 = ((String aVal, String bVal, String cVal, String dVal) {
        a.value = '$aVal $bVal $cVal $dVal';
      }).toAction();

      myAction4('1', '2', '3', '4');
      expect(a.value, '1 2 3 4');

      // 5-argument extension
      final myAction5 = ((String aVal, String bVal, String cVal, String dVal, String eVal) {
        a.value = '$aVal $bVal $cVal $dVal $eVal';
      }).toAction();

      myAction5('1', '2', '3', '4', '5');
      expect(a.value, '1 2 3 4 5');

      // 6-argument extension
      final myAction6 = ((String aVal, String bVal, String cVal, String dVal, String eVal, String fVal) {
        a.value = '$aVal $bVal $cVal $dVal $eVal $fVal';
      }).toAction();

      myAction6('1', '2', '3', '4', '5', '6');
      expect(a.value, '1 2 3 4 5 6');
    });
  });
}
