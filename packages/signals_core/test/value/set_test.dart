import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
  void testSignal(
    String message,
    SetSignal<T> Function<T>(
      Set<T>, {
      bool autoDispose,
      String? debugLabel,
    }) create,
  ) {
    group('$message test', () {
      group('autoDispose', () {
        test('check last subscriber disposes', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list, autoDispose: true);
          final dispose = s.subscribe((_) => {});
          expect(s.disposed, false);
          dispose();
          expect(s.disposed, true);
        });
        test('check last subscriber does not disposes', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list, autoDispose: false);
          final dispose = s.subscribe((_) => {});
          expect(s.disposed, false);
          dispose();
          expect(s.disposed, false);
        });
      });

      test('make sure is the same object', () {
        final Set<String> list = <String>{'a', 'b', 'c'};
        final s = create(list);
        expect(list, s);
      });

      group('actions', () {
        test('add', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.add('d');
          expect(s.length, 4);
          expect(s.last, 'd');
          expect(value, true);
        });

        test('addAll', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          s.addAll(['d']);
          expect(s.length, 4);
          expect(s.last, 'd');
        });

        test('any', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.any((e) => e == 'a');
          expect(value, true);
        });

        test('cast', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.cast<Object>();
          // ignore: unnecessary_type_check
          expect(value is Set<Object>, true);
        });

        test('clear', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          s.clear();
          expect(s.length, 0);
        });

        test('contains', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.contains('c');
          expect(value, true);
        });

        test('containsAll', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.containsAll({'a', 'b'});
          expect(value, true);
        });

        test('difference', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.difference({'b', 'c'});
          expect(value, {'a'});
        });

        test('elementAt', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.elementAt(0);
          expect(value, 'a');
        });

        test('every', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.every((e) => e.isNotEmpty);
          expect(value, true);
        });

        test('expand', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.expand((e) => {e});
          expect(value, list);
        });

        test('first', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.first;
          expect(value, 'a');
        });

        test('firstWhere', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.firstWhere((e) => e == 'a');
          expect(value, 'a');
        });

        test('fold', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.fold('', (a, b) => a + b);
          expect(value, 'abc');
        });

        test('followedBy', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.followedBy({'d'});
          expect(value, {'a', 'b', 'c', 'd'});
        });

        test('forEach', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          String out = '';
          // ignore: avoid_function_literals_in_foreach_calls
          s.forEach((e) {
            out += '_${e}_';
          });
          expect(out, '_a__b__c_');
        });

        test('intersection', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.intersection({'c'});
          expect(value, {'c'});
        });

        test('isEmpty', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.isEmpty;
          expect(value, false);
        });

        test('isNotEmpty', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.isNotEmpty;
          expect(value, true);
        });

        test('iterator', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          String out = '';
          final itr = s.iterator;
          while (itr.moveNext()) {
            out += itr.current;
          }
          expect(out, 'abc');
        });

        test('join', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.join(',');
          expect(value, 'a,b,c');
        });

        test('last', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.last;
          expect(value, 'c');
        });

        test('lastWhere', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.lastWhere((e) => e == 'a');
          expect(value, 'a');
        });

        test('length', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.length;
          expect(value, 3);
        });

        test('<<', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s << {'d'};
          expect(value(), {'a', 'b', 'c', 'd'});
        });

        test('&', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s & {'d'};
          expect(value(), {'a', 'b', 'c', 'd'});
        });

        test('|', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s | create({'d'});
          expect(value(), {'a', 'b', 'c', 'd'});
        });

        test('lookup', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.lookup('a');
          expect(value, 'a');
        });

        test('map', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.map((e) => '_${e}_');
          expect(value, {'_a_', '_b_', '_c_'});
        });

        test('reduce', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.reduce((a, b) => '$a$b');
          expect(value, 'abc');
        });

        test('remove', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.remove('c');
          expect(s.length, 2);
          expect(s.contains('c'), false);
          expect(value, true);
        });

        test('removeAll', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          s.removeAll({'c'});
          expect(s.length, 2);
          expect(s.contains('c'), false);
        });

        test('removeWhere', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          s.removeWhere((e) => e == 'c');
          expect(s.length, 2);
          expect(s.contains('c'), false);
        });

        test('retainAll', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          s.retainAll({'a', 'b'});
          expect(s.length, 2);
          expect(s.contains('c'), false);
        });

        test('retainWhere', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          s.retainWhere((e) => e != 'c');
          expect(s.length, 2);
          expect(s.contains('c'), false);
        });

        test('single', () {
          final Set<String> list = <String>{'a'};
          final s = create(list);
          final value = s.single;
          expect(s.length, 1);
          expect(value, 'a');
        });

        test('singleWhere', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.singleWhere((e) => e == 'a');
          expect(value, 'a');
        });

        test('skip', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.skip(1);
          expect(value, {'b', 'c'});
        });

        test('skipWhile', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.skipWhile((e) => e == 'a');
          expect(value.toSet(), {'b', 'c'});
        });

        test('take', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.take(1);
          expect(value, {'a'});
        });

        test('takeWhile', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.takeWhile((e) => e == 'a');
          expect(value.toSet(), {'a'});
        });

        test('toList', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value1 = s.toList();
          final value2 = s.toList(growable: false);
          expect(value1, ['a', 'b', 'c']);
          expect(value2, ['a', 'b', 'c']);
        });

        test('toSet', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.toSet();
          expect(value, ['a', 'b', 'c']);
        });

        test('union', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.union({'d'});
          expect(value, {'a', 'b', 'c', 'd'});
        });

        test('where', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.where((e) => e == 'a');
          expect(value, {'a'});
        });

        test('whereType', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.whereType<String>();
          expect(value, {'a', 'b', 'c'});
        });

        test('==', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s == create(list);
          expect(value, true);
        });

        test('hashCode', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = create(list);
          final value = s.hashCode != create(list).hashCode;
          expect(value, true);
        });
      });
    });
  }

  testSignal(
    'SetSignal',
    <T>(val, {autoDispose = false, debugLabel}) => SetSignal(
      val,
      autoDispose: autoDispose,
      debugLabel: debugLabel,
    ),
  );
  testSignal(
    'setSignal',
    <T>(val, {autoDispose = false, debugLabel}) => setSignal(
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
