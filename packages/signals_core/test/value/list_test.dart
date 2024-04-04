import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  group('List signal', () {
    for (final instance
        in <(String, ListSignal<String> Function(List<String>))>[
      ('Extension', (list) => list._extension()),
      ('Extension (autoDispose)', (list) => list._extension(autoDispose: true)),
      ('Extension (equality)', (list) => list._extension()),
      (
        'Extension (debugLabel)',
        (list) => list._extension(debugLabel: 'List: $list')
      ),
      ('Method', (list) => list._method()),
      ('Method (autoDispose)', (list) => list._method(autoDispose: true)),
      ('Method (equality)', (list) => list._method()),
      (
        'Method (debugLabel)',
        (list) => list._method(debugLabel: 'List: $list')
      ),
      ('Class', (list) => list._class()),
      ('Class (autoDispose)', (list) => list._class(autoDispose: true)),
      ('Class (equality)', (list) => list._class()),
      ('Class (debugLabel)', (list) => list._class(debugLabel: 'List: $list')),
    ]) {
      group('${instance.$1} ${instance.$2.runtimeType}', () {
        test('make sure is the same object', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = instance.$2(list);
          expect(list, s);
        });

        test('check add', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = instance.$2(list);
          s.add('d');
          expect(s.length, 4);
          expect(s.last, 'd');
        });

        test('check remove', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = instance.$2(list);
          s.remove('c');
          expect(s.length, 2);
          expect(s.contains('c'), false);
        });

        test('check clear', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = instance.$2(list);
          s.clear();
          expect(s.length, 0);
        });

        test('check sort', () {
          final List<String> list = <String>['c', 'b', 'a'];
          final s = instance.$2(list);
          s.sort();
          expect(s, ['a', 'b', 'c']);
        });

        test('check sublist', () {
          final List<String> list = <String>['a', 'b', 'c'];
          final s = instance.$2(list);
          final sublist = s.sublist(1);
          expect(sublist, ['b', 'c']);
        });
      });
    }
    group('autoDispose', () {
      test('check last subscriber disposes', () {
        final List<String> list = <String>['a', 'b', 'c'];
        final s = list.toSignal(autoDispose: true);
        final dispose = s.subscribe((_) => {});
        expect(s.disposed, false);
        dispose();
        expect(s.disposed, true);
      });
      test('check last subscriber does not disposes', () {
        final List<String> list = <String>['a', 'b', 'c'];
        final s = list.toSignal(autoDispose: false);
        final dispose = s.subscribe((_) => {});
        expect(s.disposed, false);
        dispose();
        expect(s.disposed, false);
      });
    });

    test('listSignal keeps initial value', () {
      final a = listSignal<int>([]);
      expect(a.initialValue, equals(List.of([])));

      a.value = [0];
      a.value = [0, 1];

      expect(a.initialValue, equals(List.of([])));
    });

    test('listSignal keeps previous value', () {
      final a = listSignal<int>([]);
      expect(a.previousValue, equals(null));

      a.value = [0];
      expect(a.previousValue, equals(List.of([])));

      a.value = [0, 1];
      expect(a.previousValue, equals(List.of({0})));
    });
  });
}

extension on List<String> {
  ListSignal<String> _class({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return ListSignal<String>(
      this,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }

  ListSignal<String> _extension({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return toSignal(
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }

  ListSignal<String> _method({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return listSignal<String>(
      this,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }
}
