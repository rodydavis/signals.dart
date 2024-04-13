import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
  void testSignal(
    String message,
    ListSignal<T> Function<T>(
      List<T>, {
      bool autoDispose,
      String? debugLabel,
    }) create,
  ) {
    group('$message test', () {
      test('initialValue/previousValue throw an error', () {
        final List<String> list = <String>['a', 'b', 'c'];
        final s = create(list, autoDispose: true);

        expect(() => s.initialValue, throwsA(isA<Exception>()));
        expect(() => s.previousValue, throwsA(isA<Exception>()));
      });

      group('autoDispose', () {
        test('check last subscriber disposes', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list, autoDispose: true);
          final dispose = s.subscribe((_) => {});
          expect(s.disposed, false);
          dispose();
          expect(s.disposed, true);
        });
        test('check last subscriber does not disposes', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list, autoDispose: false);
          final dispose = s.subscribe((_) => {});
          expect(s.disposed, false);
          dispose();
          expect(s.disposed, false);
        });
      });

      test('make sure is the same object', () {
        final List<String> list = <String>['a', 'b', 'c'];
        final s = create(list);
        expect(list, s);
      });

      group('actions', () {
        test('add', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s.add('d');
          expect(s.length, 4);
          expect(s.last, 'd');
        });

        test('addAll', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s.addAll(['d']);
          expect(s.length, 4);
          expect(s.last, 'd');
        });

        test('any', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.any((e) => e == 'a');
          expect(value, true);
        });

        test('cast', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.cast<Object>();
          // ignore: unnecessary_type_check
          expect(value is List<Object>, true);
        });

        test('clear', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s.clear();
          expect(s.length, 0);
        });

        test('contains', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.contains('c');
          expect(value, true);
        });

        test('elementAt', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.elementAt(0);
          expect(value, 'a');
        });

        test('every', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.every((e) => e.isNotEmpty);
          expect(value, true);
        });

        test('expand', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.expand((e) => {e});
          expect(value, list);
        });

        test('first', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.first;
          expect(value, 'a');
        });

        test('firstWhere', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.firstWhere((e) => e == 'a');
          expect(value, 'a');
        });

        test('fold', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.fold('', (a, b) => a + b);
          expect(value, 'abc');
        });

        test('followedBy', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.followedBy({'d'});
          expect(value, {'a', 'b', 'c', 'd'});
        });

        test('forEach', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          String out = '';
          // ignore: avoid_function_literals_in_foreach_calls
          s.forEach((e) {
            out += '_${e}_';
          });
          expect(out, '_a__b__c_');
        });

        test('isEmpty', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.isEmpty;
          expect(value, false);
        });

        test('isNotEmpty', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.isNotEmpty;
          expect(value, true);
        });

        test('iterator', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          String out = '';
          final itr = s.iterator;
          while (itr.moveNext()) {
            out += itr.current;
          }
          expect(out, 'abc');
        });

        test('join', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.join(',');
          expect(value, 'a,b,c');
        });

        test('last', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.last;
          expect(value, 'c');
        });

        test('lastWhere', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.lastWhere((e) => e == 'a');
          expect(value, 'a');
        });

        test('length', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.length;
          expect(value, 3);
        });

        test('<<', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s << {'d'};
          expect(value(), {'a', 'b', 'c', 'd'});
        });

        test('&', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s & {'d'};
          expect(value(), {'a', 'b', 'c', 'd'});
        });

        test('|', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s | create(['d']);
          expect(value(), {'a', 'b', 'c', 'd'});
        });

        test('+', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s + ['d'];
          expect(value, ['a', 'b', 'c', 'd']);
        });

        test('[int]', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s[0];
          expect(value, 'a');
        });

        test('[int]=', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s[0] = '0';
          final value = s[0];
          expect(value, '0');
        });

        test('asMap', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.asMap();
          expect(value, {0: 'a', 1: 'b', 2: 'c'});
        });

        test('fillRange', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s.fillRange(0, 1, '0');
          final value = s.value;
          expect(value, {'0', 'b', 'c'});
        });

        test('getRange', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.getRange(0, 1);
          expect(value, {'a'});
        });

        test('indexOf', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.indexOf('a');
          expect(value, 0);
        });

        test('indexWhere', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.indexWhere((e) => e == 'a');
          expect(value, 0);
        });

        test('insert', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s.insert(0, '0');
          final value = s[0];
          expect(value, '0');
        });

        test('insertAll', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s.insertAll(0, {'0'});
          final value = s[0];
          expect(value, '0');
        });

        test('lastIndexOf', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.lastIndexOf('a');
          expect(value, 0);
        });

        test('lastIndexWhere', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.lastIndexWhere((e) => e == 'a');
          expect(value, 0);
        });

        test('removeAt', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.removeAt(0);
          expect(value, 'a');
        });

        test('removeLast', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.removeLast();
          expect(value, 'c');
        });

        test('removeRange', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s.removeRange(0, 1);
          final value = s.value;
          expect(value, ['b', 'c']);
        });

        test('replaceRange', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s.replaceRange(0, 1, {'0'});
          final value = s.value;
          expect(value, ['0', 'b', 'c']);
        });

        test('reversed', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.reversed.toSet();
          expect(value, {'c', 'b', 'a'});
        });

        test('setAll', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s.setAll(0, {'0'});
          final value = s.value;
          expect(value, {'0', 'b', 'c'});
        });

        test('setRange', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s.setRange(0, 1, {'0'});
          final value = s.value;
          expect(value, {'0', 'b', 'c'});
        });

        test('shuffle', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final copy = list.toList();
          final s = create(list);
          s.shuffle();
          final value = s.value;
          expect(value != copy, true);
        });

        test('sort', () {
          final List<String> list = <String>['c', 'b', 'a'];
          final s = create(list);
          s.sort();
          final value = s.value;
          expect(value, {'a', 'b', 'c'});
        });

        test('sorted', () {
          final List<String> list = <String>['c', 'b', 'a'];
          final s = create(list);
          final value = s.sorted();
          expect(value, {'a', 'b', 'c'});
        });

        test('sublist', () {
          final List<String> list = <String>['c', 'b', 'a'];
          final s = create(list);
          final value = s.sublist(0, 1);
          expect(value, {'c'});
        });

        test('map', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.map((e) => '_${e}_');
          expect(value, {'_a_', '_b_', '_c_'});
        });

        test('reduce', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.reduce((a, b) => '$a$b');
          expect(value, 'abc');
        });

        test('remove', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.remove('c');
          expect(s.length, 2);
          expect(s.contains('c'), false);
          expect(value, true);
        });

        test('removeWhere', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s.removeWhere((e) => e == 'c');
          expect(s.length, 2);
          expect(s.contains('c'), false);
        });

        test('retainWhere', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s.retainWhere((e) => e != 'c');
          expect(s.length, 2);
          expect(s.contains('c'), false);
        });

        test('single', () {
          final List<String> list = <String>['a'];
          final s = create(list);
          final value = s.single;
          expect(s.length, 1);
          expect(value, 'a');
        });

        test('singleWhere', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.singleWhere((e) => e == 'a');
          expect(value, 'a');
        });

        test('skip', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.skip(1);
          expect(value, {'b', 'c'});
        });

        test('skipWhile', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.skipWhile((e) => e == 'a');
          expect(value.toList(), {'b', 'c'});
        });

        test('take', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.take(1);
          expect(value, {'a'});
        });

        test('takeWhile', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.takeWhile((e) => e == 'a');
          expect(value.toList(), {'a'});
        });

        test('toList', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value1 = s.toList();
          final value2 = s.toList(growable: false);
          expect(value1, ['a', 'b', 'c']);
          expect(value2, ['a', 'b', 'c']);
        });

        test('toList', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.toList();
          expect(value, ['a', 'b', 'c']);
        });

        test('where', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.where((e) => e == 'a');
          expect(value, {'a'});
        });

        test('whereType', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.whereType<String>();
          expect(value, {'a', 'b', 'c'});
        });

        test('==', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s == create(list);
          expect(value, true);
        });

        test('hashCode', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          final value = s.hashCode != create(list).hashCode;
          expect(value, true);
        });

        test('set first', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s.first = '0';
          final value = s.first;
          expect(value, '0');
        });

        test('set last', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s.last = '0';
          final value = s.last;
          expect(value, '0');
        });

        test('set length', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = create(list);
          s.length = 0;
          final value = s.length;
          expect(value, 0);
        });
      });
    });
  }

  testSignal(
    'ListSignal',
    <T>(val, {autoDispose = false, debugLabel}) => ListSignal(
      val,
      autoDispose: autoDispose,
      debugLabel: debugLabel,
    ),
  );
  testSignal(
    'listSignal',
    <T>(val, {autoDispose = false, debugLabel}) => listSignal(
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
