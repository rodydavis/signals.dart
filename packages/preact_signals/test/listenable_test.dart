import 'package:preact_signals/preact_signals.dart';
import 'package:preact_signals/src/listenable.dart';
import 'package:test/test.dart';

class MockListenable with Listenable {}

void main() {
  group('Listenable mixin class default throwers', () {
    test('flags throws UnimplementedError', () {
      final listenable = MockListenable();
      expect(() => listenable.flags, throwsUnimplementedError);
    });

    test('globalId throws UnimplementedError', () {
      final listenable = MockListenable();
      expect(() => listenable.globalId, throwsUnimplementedError);
    });

    test('notify throws UnimplementedError', () {
      final listenable = MockListenable();
      expect(() => listenable.notify(), throwsUnimplementedError);
    });
  });

  group('Listenable sources and cleanup', () {
    test('listenableSources lists current sources', () {
      final a = signal(1);
      final c = computed(() => a.value);
      expect(c.value, 1);

      final sources = (c as Listenable).listenableSources().toList();
      expect(sources, isNotEmpty);
      expect(sources.first, a);
    });

    test('cleanupSources handles dropped dependencies correctly', () {
      final a = signal(1);
      final b = signal(2);
      final cond = signal(true);

      // computed depends on cond, then a and b if cond is true
      final c = computed(() {
        if (cond.value) {
          return a.value + b.value;
        } else {
          return 0;
        }
      });

      expect(c.value, 3);

      // Now toggle cond to false, so c recomputes and drops dependencies on a and b.
      cond.value = false;
      expect(c.value, 0);

      // Verify sources are updated
      final sources = (c as Listenable).listenableSources().toList();
      expect(sources, [cond]);
    });
  });
}
