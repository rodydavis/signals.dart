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
        var calls = 0;
        var called = false;
        final dispose = effect(() => calls++, onDispose: () => called = true);
        expect(calls, 1);
        expect(called, false);
        dispose();
        expect(calls, 1);
        expect(called, true);
      });

      test('cleanup', () {
        var calls = 0;
        var called = false;
        final dispose = effect(
          () {
            calls++;
            return () => called = true;
          },
        );
        dispose();
        expect(calls, 1);
        expect(called, true);
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
