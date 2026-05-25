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
  });
}
