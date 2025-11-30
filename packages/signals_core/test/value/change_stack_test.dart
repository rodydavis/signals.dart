import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  

  group('ChangeStack signal tests', () {
    test(
      'should do undo N times',
      () {
        final s = changeStack(0, limit: 2);
        s.value = 1;
        s.value = 2;
        s.value = 3;
        expect(s.value, 3);
        s.undo();
        s.undo();
        expect(s.value, 1);
        expect(s.canUndo, false);
        s.redo();
        expect(s.value, 2);
        s.redo();
        expect(s.canUndo, true);
        s.undo();
        s.value = -1;
        expect(s.canRedo, false);
        expect(s.value, -1);
      },
    );
  });

  void testSignal(
    String message,
    ChangeStackSignal<T> Function<T>(
      T, {
      bool autoDispose,
      String? debugLabel,
      int? limit,
    }) create,
  ) {
    group('$message test', () {
      test('history', () {
        final s = create(0);

        expect(s.history, []);

        s.value = 1;

        expect(s.history, [(previousValue: 0, value: 1)]);
      });

      test('redos', () {
        final s = create(0);

        expect(s.redos, []);

        s.value = 1;
        s.undo();

        expect(s.redos, [(previousValue: 0, value: 1)]);
      });

      test('check', () {
        final s = create(0);

        expect(s.canRedo, false);
        expect(s.canUndo, false);

        s.value = 1;
        s.value = 2;
        s.undo();

        expect(s.canRedo, true);
        expect(s.canUndo, true);
      });

      test('undo', () {
        final s = create(0);

        s.value = 1;
        s.undo();

        expect(s.value, 0);
      });

      test('redo', () {
        final s = create(0);

        s.value = 1;
        s.undo();
        s.redo();

        expect(s.value, 1);
      });

      test('clear', () {
        final s = create(0);

        s.value = 1;
        s.value = 2;
        s.value = 3;
        s.undo();
        s.undo();
        s.redo();

        s.clear();

        expect(s.canUndo, false);
        expect(s.canRedo, false);
      });

      test('limit', () {
        final s = create(0, limit: 1);

        s.value = 1;
        s.value = 2;

        expect(s.history.length, 1);
      });
    });
  }

  testSignal(
    'ChangeStackSignal',
    <T>(val, {autoDispose = false, debugLabel, limit}) => ChangeStackSignal(
      val,
      options: SignalOptions(
        autoDispose: autoDispose,
        name: debugLabel,
      ),
      limit: limit,
    ),
  );
  testSignal(
    'changeStack',
    <T>(val, {autoDispose = false, debugLabel, limit}) => changeStack(
      val,
      options: SignalOptions(
        autoDispose: autoDispose,
        name: debugLabel,
      ),
      limit: limit,
    ),
  );
}
