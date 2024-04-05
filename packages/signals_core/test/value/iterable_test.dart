import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  void testSignal(
    String message,
    IterableSignal<T> Function<T>(
      Iterable<T>, {
      bool autoDispose,
      String? debugLabel,
    }) create,
  ) {
    group('$message test', () {
      test('iterableSignal keeps initial value', () {
        final a = create<int>([]);
        expect(a.initialValue, equals(Iterable.castFrom({})));

        a.value = {0};
        a.value = {0, 1};

        expect(a.initialValue, equals(Iterable.castFrom({})));
      });

      test('iterableSignal keeps previous value', () {
        final a = create<int>([]);
        expect(a.previousValue, equals(null));

        a.value = {0};
        expect(a.previousValue, equals(Iterable.castFrom({})));

        a.value = {0, 1};
        expect(a.previousValue, equals(Iterable.castFrom({0})));
      });

      group('autoDispose', () {
        test('check last subscriber disposes', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable, autoDispose: true);
          final dispose = s.subscribe((_) => {});
          expect(s.disposed, false);
          dispose();
          expect(s.disposed, true);
        });
        test('check last subscriber does not disposes', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable, autoDispose: false);
          final dispose = s.subscribe((_) => {});
          expect(s.disposed, false);
          dispose();
          expect(s.disposed, false);
        });
      });

      test('make sure is the same object', () {
        final Iterable<String> iterable = <String>['a', 'b', 'c'];
        final s = create(iterable);
        expect(iterable, s);
      });

      group('actions', () {
        test('any', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.any((e) => e == 'a');
          expect(value, true);
        });

        test('cast', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.cast<Object>();
          // ignore: unnecessary_type_check
          expect(value is Iterable<Object>, true);
        });

        test('contains', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.contains('c');
          expect(value, true);
        });

        test('elementAt', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.elementAt(0);
          expect(value, 'a');
        });

        test('every', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.every((e) => e.isNotEmpty);
          expect(value, true);
        });

        test('expand', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.expand((e) => {e});
          expect(value, iterable);
        });

        test('first', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.first;
          expect(value, 'a');
        });

        test('firstWhere', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.firstWhere((e) => e == 'a');
          expect(value, 'a');
        });

        test('fold', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.fold('', (a, b) => a + b);
          expect(value, 'abc');
        });

        test('followedBy', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.followedBy({'d'});
          expect(value, {'a', 'b', 'c', 'd'});
        });

        test('forEach', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          String out = '';
          s.forEach((e) {
            out += '_${e}_';
          });
          expect(out, '_a__b__c_');
        });

        test('isEmpty', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.isEmpty;
          expect(value, false);
        });

        test('isNotEmpty', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.isNotEmpty;
          expect(value, true);
        });

        test('iterator', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          String out = '';
          final itr = s.iterator;
          while (itr.moveNext()) {
            out += itr.current;
          }
          expect(out, 'abc');
        });

        test('join', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.join(',');
          expect(value, 'a,b,c');
        });

        test('last', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.last;
          expect(value, 'c');
        });

        test('lastWhere', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.lastWhere((e) => e == 'a');
          expect(value, 'a');
        });

        test('length', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.length;
          expect(value, 3);
        });

        test('map', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.map((e) => '_${e}_');
          expect(value, {'_a_', '_b_', '_c_'});
        });

        test('reduce', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.reduce((a, b) => '$a$b');
          expect(value, 'abc');
        });

        test('single', () {
          final Iterable<String> iterable = <String>['a'];
          final s = create(iterable);
          final value = s.single;
          expect(s.length, 1);
          expect(value, 'a');
        });

        test('singleWhere', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.singleWhere((e) => e == 'a');
          expect(value, 'a');
        });

        test('skip', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.skip(1);
          expect(value, {'b', 'c'});
        });

        test('skipWhile', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.skipWhile((e) => e == 'a');
          expect(value.toSet(), {'b', 'c'});
        });

        test('take', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.take(1);
          expect(value, {'a'});
        });

        test('takeWhile', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.takeWhile((e) => e == 'a');
          expect(value.toSet(), {'a'});
        });

        test('toIterable', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.toSet();
          expect(value, ['a', 'b', 'c']);
        });

        test('toIterable', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.toSet();
          expect(value, ['a', 'b', 'c']);
        });

        test('where', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.where((e) => e == 'a');
          expect(value, {'a'});
        });

        test('whereType', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.whereType<String>();
          expect(value, {'a', 'b', 'c'});
        });

        test('==', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s == create(iterable);
          expect(value, true);
        });

        test('hashCode', () {
          final Iterable<String> iterable = <String>['a', 'b', 'c'];
          final s = create(iterable);
          final value = s.hashCode != create(iterable).hashCode;
          expect(value, true);
        });
      });
    });
  }

  testSignal(
    'IterableSignal',
    <T>(val, {autoDispose = false, debugLabel}) => IterableSignal(
      val,
      autoDispose: autoDispose,
      debugLabel: debugLabel,
    ),
  );
  testSignal(
    'iterableSignal',
    <T>(val, {autoDispose = false, debugLabel}) => iterableSignal(
      val,
      autoDispose: autoDispose,
      debugLabel: debugLabel,
    ),
  );
  testSignal(
    'toSignal',
    <T>(val, {autoDispose = false, debugLabel}) {
      return val.toSignal(
        autoDispose: autoDispose,
        debugLabel: debugLabel,
      );
    },
  );
}
