import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  final Iterable<String> list = <String>['a', 'b', 'c'];
  group('Iterable signal', () {
    for (final instance in [
      ('Extension', list._extension()),
      ('Extension (autoDispose)', list._extension(autoDispose: true)),
      ('Extension (equality)', list._extension(equality: identical)),
      (
        'Extension (debugLabel)',
        list._extension(debugLabel: 'Iterable: $list')
      ),
      ('Method', list._method()),
      ('Method (autoDispose)', list._method(autoDispose: true)),
      ('Method (equality)', list._method(equality: identical)),
      ('Method (debugLabel)', list._method(debugLabel: 'Iterable: $list')),
      ('Class', list._class()),
      ('Class (autoDispose)', list._class(autoDispose: true)),
      ('Class (equality)', list._class(equality: identical)),
      ('Class (debugLabel)', list._class(debugLabel: 'Iterable: $list')),
    ]) {
      group('${instance.$1} ${instance.$2.runtimeType}', () {
        test('make sure is the same object', () {
          final s = instance.$2;
          expect(list, s);
        });
      });
    }
    group('autoDispose', () {
      test('check last subscriber disposes', () {
        final Iterable<String> list = <String>['a', 'b', 'c'];
        final s = list.toSignal(autoDispose: true);
        final dispose = s.subscribe((_) => {});
        expect(s.disposed, false);
        dispose();
        expect(s.disposed, true);
      });
      test('check last subscriber does not disposes', () {
        final Iterable<String> list = <String>['a', 'b', 'c'];
        final s = list.toSignal(autoDispose: false);
        final dispose = s.subscribe((_) => {});
        expect(s.disposed, false);
        dispose();
        expect(s.disposed, false);
      });
    });
  });
}

extension on Iterable<String> {
  IterableSignal<String> _class({
    String? debugLabel,
    bool Function(Iterable<String>, Iterable<String>)? equality,
    bool autoDispose = false,
  }) {
    return IterableSignal<String>(
      this,
      debugLabel: debugLabel,
      equality: equality,
      autoDispose: autoDispose,
    );
  }

  IterableSignal<String> _extension({
    String? debugLabel,
    bool Function(Iterable<String>, Iterable<String>)? equality,
    bool autoDispose = false,
  }) {
    return toSignal(
      debugLabel: debugLabel,
      equality: equality,
      autoDispose: autoDispose,
    );
  }

  IterableSignal<String> _method({
    String? debugLabel,
    bool Function(Iterable<String>, Iterable<String>)? equality,
    bool autoDispose = false,
  }) {
    return iterableSignal<String>(
      this,
      debugLabel: debugLabel,
      equality: equality,
      autoDispose: autoDispose,
    );
  }
}
