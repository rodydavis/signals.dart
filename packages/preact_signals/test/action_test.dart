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

    test('should support up to 10 positional arguments', () {
      final a = signal(0);
      final myAction = action((int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10) {
        a.value = a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8 + a9 + a10;
      });

      myAction(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
      expect(a.value, 55);
    });

    test('actionList should support unlimited arguments', () {
      final a = signal(0);
      final myAction = actionList((int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10, int a11) {
        a.value = a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8 + a9 + a10 + a11;
      });

      myAction([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]);
      expect(a.value, 66);
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
    });

    test('toActionList extension should support unlimited list-based arguments', () {
      final a = signal(0);
      final myAction = ((int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10, int a11) {
        a.value = a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8 + a9 + a10 + a11;
      }).toActionList();

      myAction([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]);
      expect(a.value, 66);
    });
  });
}
