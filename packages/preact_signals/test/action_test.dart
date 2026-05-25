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

    test('action0 should wrap a 0-argument function in batch and untracked',
        () {
      final a = signal('a');
      final b = signal('b');
      final spy = Spy(() => '${a.value} ${b.value}');
      effect(spy.call);
      spy.resetHistory();

      final myAction = action0(() {
        a.value = 'aa';
        b.value = 'bb';
      });

      myAction();

      expect(spy.calls, 1);
      expect(a.value, 'aa');
      expect(b.value, 'bb');
    });

    test('action1 should wrap a 1-argument function in batch and untracked',
        () {
      final a = signal('a');
      final b = signal('b');
      final spy = Spy(() => '${a.value} ${b.value}');
      effect(spy.call);
      spy.resetHistory();

      final myAction = action1((String nextVal) {
        a.value = nextVal;
        b.value = nextVal;
      });

      myAction('xx');

      expect(spy.calls, 1);
      expect(a.value, 'xx');
      expect(b.value, 'xx');
    });

    test('action2 should wrap a 2-argument function in batch and untracked',
        () {
      final a = signal('a');
      final b = signal('b');
      final spy = Spy(() => '${a.value} ${b.value}');
      effect(spy.call);
      spy.resetHistory();

      final myAction = action2((String nextA, String nextB) {
        a.value = nextA;
        b.value = nextB;
      });

      myAction('yy', 'zz');

      expect(spy.calls, 1);
      expect(a.value, 'yy');
      expect(b.value, 'zz');
    });

    test('should accept options parameter', () {
      final a = signal('a');
      final myAction = action((String val) {
        a.value = val;
      }, options: const ActionOptions(name: 'my-action'));
      myAction('opt');
      expect(a.value, 'opt');

      final myAction0 = action0(() {
        a.value = 'opt0';
      }, options: const ActionOptions(name: 'my-action0'));
      myAction0();
      expect(a.value, 'opt0');

      final myAction1 = action1((String val) {
        a.value = val;
      }, options: const ActionOptions(name: 'my-action1'));
      myAction1('opt1');
      expect(a.value, 'opt1');

      final myAction2 = action2((String val1, String val2) {
        a.value = '$val1 $val2';
      }, options: const ActionOptions(name: 'my-action2'));
      myAction2('opt2', 'opt2b');
      expect(a.value, 'opt2 opt2b');
    });
  });
}
