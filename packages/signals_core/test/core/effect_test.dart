import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
  group('effect', () {
    group('dispose', () {
      test('default', () {
        var calls = 0;
        final dispose = effect(() => calls++);
        expect(calls, 1);
        dispose();
        expect(calls, 1);
      });

      test('callback', () {
        {
          var calls = 0;
          var called = false;
          final dispose = effect(() => calls++, onDispose: () => called = true);

          expect(calls, 1);
          expect(called, false);

          dispose();

          expect(calls, 1);
          expect(called, true);
        }
        {
          var calls = 0;
          var called = false;

          final instance = Effect(() => calls++);
          instance.onDispose(() => called = true);
          instance();

          expect(calls, 1);
          expect(called, false);

          instance.dispose();

          expect(calls, 1);
          expect(called, true);
        }

        {
          var calls = 0;
          var called = false;
          final instance = Effect(() => calls++);
          final cancel = instance.onDispose(() => called = true);
          instance();

          expect(calls, 1);
          expect(called, false);

          cancel();
          instance.dispose();

          expect(calls, 1);
          expect(called, false);
        }
      });

      test('cleanup', () {
        var calls = 0;
        var called = false;
        final instance = Effect(
          () {
            calls++;
            return () => called = true;
          },
        );
        instance();
        expect(instance.disposed, false);
        instance.dispose();
        expect(calls, 1);
        expect(called, true);
        expect(instance.disposed, true);
      });

      test('error in callback', () {
        final a = signal(0);

        expect(
          () => effect(() {
            a.value;
            throw Exception();
          }),
          throwsException,
        );
      });
    });
  });
}
