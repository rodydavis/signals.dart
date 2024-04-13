import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  SignalsObserver.instance = null;
  group('SignalValueListenable', () {
    testWidgets('signalValueNotifier', (tester) async {
      final s = SignalValueListenable(0);
      final b = signalValueListenable<int>(0);

      expect(b.value, s.value);
      expect(s.value, 0);
      expect(s(), 0);
      expect(s.get(), 0);
      expect(s.value, 0);
      expect(s.peek(), 0);
      expect(s.toJson(), 0);
      expect(s.toString(), '0');
      expect(s.previousValue, null);
      expect(s.initialValue, 0);
      expect(s.globalId, s.source.globalId);
      expect(s.debugLabel, s.source.debugLabel);
      expect(s.autoDispose, s.source.autoDispose);
      expect(s.disposed, s.source.disposed);

      // ignore: unnecessary_type_check
      expect(s.source is ReadonlySignal<int>, true);

      // ignore: unnecessary_type_check
      expect(s is ReadonlySignal<int>, true);

      // ignore: unnecessary_type_check
      expect(s is ValueListenable<int>, true);

      int calls = 0;

      final dispose = s.subscribe((value) => calls++);

      expect(calls, 1);

      dispose();

      calls = 0;
      s.onDispose(() => calls++);
      s.dispose();

      expect(calls, 1);
      expect(s.disposed, true);

      s.disposed = false;
      expect(s.disposed, false);
    });

    testWidgets('toValueListenable', (tester) async {
      final a = computed(() => 0);
      final s = a.toValueListenable();
      final b = signalValueListenable<int>(0);
      final c = valueListenableToSignal(s);

      expect(s.value, c.value);
      expect(b.value, s.value);
      expect(s.value, 0);
      expect(s(), 0);
      expect(s.get(), 0);
      expect(s.value, 0);
      expect(s.peek(), 0);
      expect(s.toJson(), 0);
      expect(s.toString(), '0');
      expect(s.previousValue, null);
      expect(s.initialValue, 0);
      expect(s.globalId, s.source.globalId);
      expect(s.debugLabel, s.source.debugLabel);
      expect(s.autoDispose, s.source.autoDispose);
      expect(s.disposed, s.source.disposed);

      // ignore: unnecessary_type_check
      expect(s.source is ReadonlySignal<int>, true);

      // ignore: unnecessary_type_check
      expect(s is ReadonlySignal<int>, true);

      // ignore: unnecessary_type_check
      expect(s is ValueListenable<int>, true);

      int calls = 0;

      final dispose = s.subscribe((value) => calls++);

      expect(calls, 1);

      dispose();

      calls = 0;
      s.onDispose(() => calls++);
      s.dispose();

      expect(calls, 1);
      expect(s.disposed, true);

      s.disposed = false;
      expect(s.disposed, false);
    });

    testWidgets('toSignal', (tester) async {
      final a = computed(() => 0);
      final s = a.toValueListenable() as ValueListenable<int>;
      final b = s.toSignal();
      final d = SignalValueListenable.merge(s, a);

      expect(b.value, d.value);
      expect(b.value, s.value);
      expect(s.value, 0);
    });
  });
}
