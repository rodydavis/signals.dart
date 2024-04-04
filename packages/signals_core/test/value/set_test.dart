import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  group('Set signal', () {
    for (final instance in <(String, SetSignal<String> Function(Set<String>))>[
      ('Extension', (list) => list._extension()),
      ('Extension (autoDispose)', (list) => list._extension(autoDispose: true)),
      ('Extension (equality)', (list) => list._extension()),
      (
        'Extension (debugLabel)',
        (list) => list._extension(debugLabel: 'Set: $list')
      ),
      ('Method', (list) => list._method()),
      ('Method (autoDispose)', (list) => list._method(autoDispose: true)),
      ('Method (equality)', (list) => list._method()),
      ('Method (debugLabel)', (list) => list._method(debugLabel: 'Set: $list')),
      ('Class', (list) => list._class()),
      ('Class (autoDispose)', (list) => list._class(autoDispose: true)),
      ('Class (equality)', (list) => list._class()),
      ('Class (debugLabel)', (list) => list._class(debugLabel: 'Set: $list')),
    ]) {
      group('${instance.$1} ${instance.$2.runtimeType}', () {
        test('make sure is the same object', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = instance.$2(list);
          expect(list, s);
        });

        test('check add', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = instance.$2(list);
          s.add('d');
          expect(s.length, 4);
          expect(s.last, 'd');
        });

        test('check remove', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = instance.$2(list);
          s.remove('c');
          expect(s.length, 2);
          expect(s.contains('c'), false);
        });

        test('check clear', () {
          final Set<String> list = <String>{'a', 'b', 'c'};
          final s = instance.$2(list);
          s.clear();
          expect(s.length, 0);
        });
      });
    }
    group('autoDispose', () {
      test('check last subscriber disposes', () {
        final Set<String> list = <String>{'a', 'b', 'c'};
        final s = list.toSignal(autoDispose: true);
        final dispose = s.subscribe((_) => {});
        expect(s.disposed, false);
        dispose();
        expect(s.disposed, true);
      });
      test('check last subscriber does not disposes', () {
        final Set<String> list = <String>{'a', 'b', 'c'};
        final s = list.toSignal(autoDispose: false);
        final dispose = s.subscribe((_) => {});
        expect(s.disposed, false);
        dispose();
        expect(s.disposed, false);
      });
    });

    test('setSignal keeps initial value', () {
      final a = setSignal<int>({});
      expect(a.initialValue, equals(Set.of({})));

      a.value = {0};
      a.value = {0, 1};

      expect(a.initialValue, equals(Set.of({})));
    });

    test('setSignal keeps previous value', () {
      final a = setSignal<int>({});
      expect(a.previousValue, equals(null));

      a.value = {0};
      expect(a.previousValue, equals(Set.of({})));

      a.value = {0, 1};
      expect(a.previousValue, equals(Set.of({0})));
    });
  });
}

extension on Set<String> {
  SetSignal<String> _class({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return SetSignal<String>(
      this,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }

  SetSignal<String> _extension({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return toSignal(
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }

  SetSignal<String> _method({
    String? debugLabel,
    bool autoDispose = false,
  }) {
    return setSignal<String>(
      this,
      debugLabel: debugLabel,
      autoDispose: autoDispose,
    );
  }
}
