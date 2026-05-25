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

    test('should support up to 10 positional arguments without Function.apply', () {
      final a = signal(0);
      final myAction = action((
        int a1,
        int a2,
        int a3,
        int a4,
        int a5,
        int a6,
        int a7,
        int a8,
        int a9,
        int a10,
      ) {
        a.value = a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8 + a9 + a10;
      });

      myAction(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
      expect(a.value, 55);
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
      final myAction4 = action4((
        String val1,
        String val2,
        String val3,
        String val4,
      ) {
        a.value = '$val1 $val2 $val3 $val4';
      });

      myAction4('1', '2', '3', '4');
      expect(a.value, '1 2 3 4');
    });

    test('action5 should wrap a 5-argument function type-safely', () {
      final a = signal('a');
      final myAction5 = action5((
        String val1,
        String val2,
        String val3,
        String val4,
        String val5,
      ) {
        a.value = '$val1 $val2 $val3 $val4 $val5';
      });

      myAction5('1', '2', '3', '4', '5');
      expect(a.value, '1 2 3 4 5');
    });

    test('action6 should wrap a 6-argument function type-safely', () {
      final a = signal('a');
      final myAction6 = action6((
        String val1,
        String val2,
        String val3,
        String val4,
        String val5,
        String val6,
      ) {
        a.value = '$val1 $val2 $val3 $val4 $val5 $val6';
      });

      myAction6('1', '2', '3', '4', '5', '6');
      expect(a.value, '1 2 3 4 5 6');
    });

    test('action7 should wrap a 7-argument function type-safely', () {
      final a = signal('a');
      final myAction7 = action7((
        String val1,
        String val2,
        String val3,
        String val4,
        String val5,
        String val6,
        String val7,
      ) {
        a.value = '$val1 $val2 $val3 $val4 $val5 $val6 $val7';
      });

      myAction7('1', '2', '3', '4', '5', '6', '7');
      expect(a.value, '1 2 3 4 5 6 7');
    });

    test('action8 should wrap an 8-argument function type-safely', () {
      final a = signal('a');
      final myAction8 = action8((
        String val1,
        String val2,
        String val3,
        String val4,
        String val5,
        String val6,
        String val7,
        String val8,
      ) {
        a.value = '$val1 $val2 $val3 $val4 $val5 $val6 $val7 $val8';
      });

      myAction8('1', '2', '3', '4', '5', '6', '7', '8');
      expect(a.value, '1 2 3 4 5 6 7 8');
    });

    test('action9 should wrap a 9-argument function type-safely', () {
      final a = signal('a');
      final myAction9 = action9((
        String val1,
        String val2,
        String val3,
        String val4,
        String val5,
        String val6,
        String val7,
        String val8,
        String val9,
      ) {
        a.value = '$val1 $val2 $val3 $val4 $val5 $val6 $val7 $val8 $val9';
      });

      myAction9('1', '2', '3', '4', '5', '6', '7', '8', '9');
      expect(a.value, '1 2 3 4 5 6 7 8 9');
    });

    test('action10 should wrap a 10-argument function type-safely', () {
      final a = signal('a');
      final myAction10 = action10((
        String val1,
        String val2,
        String val3,
        String val4,
        String val5,
        String val6,
        String val7,
        String val8,
        String val9,
        String val10,
      ) {
        a.value =
            '$val1 $val2 $val3 $val4 $val5 $val6 $val7 $val8 $val9 $val10';
      });

      myAction10('1', '2', '3', '4', '5', '6', '7', '8', '9', '10');
      expect(a.value, '1 2 3 4 5 6 7 8 9 10');
    });

    test('extensions (ActionExt0 to ActionExt10) should wrap functions type-safely', () {
      final a = signal('a');

      final ext0 = (() {
        a.value = '0';
      }).action;
      ext0();
      expect(a.value, '0');

      final ext1 = ((String x) {
        a.value = x;
      }).action;
      ext1('1');
      expect(a.value, '1');

      final ext2 = ((String x, String y) {
        a.value = '$x $y';
      }).action;
      ext2('1', '2');
      expect(a.value, '1 2');

      final ext10 = ((
        String v1,
        String v2,
        String v3,
        String v4,
        String v5,
        String v6,
        String v7,
        String v8,
        String v9,
        String v10,
      ) {
        a.value = '$v1 $v2 $v3 $v4 $v5 $v6 $v7 $v8 $v9 $v10';
      }).action;
      ext10('1', '2', '3', '4', '5', '6', '7', '8', '9', '10');
      expect(a.value, '1 2 3 4 5 6 7 8 9 10');
    });
  });
}
