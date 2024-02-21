import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  group('connect', () {
    test('from', () async {
      final counter = signal(0);
      final c = connect(counter);

      final s = Stream.value(1);

      c.from(s);

      await Future.delayed(const Duration(milliseconds: 100));

      expect(counter.value, 1);

      c.dispose();
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
