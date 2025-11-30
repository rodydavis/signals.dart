import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  
  group('connect', () {
    group('from', () {
      test('add', () async {
        final counter = signal(0);
        final c = connect(counter);

        final s = Stream.value(1);

        c.from(s);

        await Future.delayed(const Duration(milliseconds: 100));

        expect(counter.value, 1);

        c.dispose();
      });

      test('onDone', () async {
        final counter = signal(0);
        final c = connect(counter);
        bool done = false;

        final s = Stream.value(1);

        c.from(s, onDone: () => done = true);

        await Future.delayed(const Duration(milliseconds: 100));

        expect(counter.value, 1);
        expect(done, true);

        c.dispose();
      });

      test('onValue', () async {
        final counter = signal(0);
        final c = connect(counter);
        final items = <int>[];

        final s = Stream.value(1);

        c.from(s, onValue: items.add);

        await Future.delayed(const Duration(milliseconds: 100));

        expect(counter.value, 1);
        expect(items, [1]);

        c.dispose();
      });

      test('onError', () async {
        final counter = signal(0);
        final c = connect(counter);
        final items = <Object?>[];

        final s = Stream<int>.error(Exception('error'));

        try {
          c.from(s, onError: items.add);
          await Future.delayed(const Duration(milliseconds: 100));
        } catch (e) {
          print('error: $e');
        }

        expect(items.first, isA<Exception>());

        c.dispose();
      });

      test('dispose', () {
        final counter = signal(0);
        final c = connect(counter);

        final s = Stream.value(1);

        c.from(s);

        c.dispose();

        expect(c.signal.disposed, true);
      });
    });

    test('<<', () async {
      final counter = signal(0);
      final c = connect(counter);

      final s = Stream.value(1);

      c << s;

      await Future.delayed(const Duration(milliseconds: 100));

      expect(counter.value, 1);

      c.dispose();
    });

    test('stream', () async {
      final counter = signal(0);
      final s = Stream.value(1);
      final c = connect(counter, s);

      await Future.delayed(const Duration(milliseconds: 100));

      expect(counter.value, 1);

      c.dispose();
    });
  });

  group('Connect', () {
    test('from', () async {
      final counter = signal(0);
      final c = Connect(counter);

      final s = Stream.value(1);

      c.from(s);

      await Future.delayed(const Duration(milliseconds: 100));

      expect(counter.value, 1);

      c.dispose();
    });

    test('<<', () async {
      final counter = signal(0);
      final c = Connect(counter);

      final s = Stream.value(1);

      c << s;

      await Future.delayed(const Duration(milliseconds: 100));

      expect(counter.value, 1);

      c.dispose();
    });
  });
}
