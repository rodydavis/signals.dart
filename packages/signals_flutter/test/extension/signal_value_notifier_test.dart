import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  group('SignalValueNotifier', () {
    testWidgets('signalValueNotifier', (tester) async {
      final s = SignalValueNotifier<int>(0);
      final b = signalValueNotifier<int>(1);

      s.value = 1;

      expect(b.value, s.value);
      expect(s.value, 1);
      expect(s(), 1);
      expect(s.get(), 1);
      expect(s.value, 1);
      expect(s.peek(), 1);
      expect(s.toJson(), 1);
      expect(s.toString(), '1');
      expect(s.previousValue, 0);
      expect(s.initialValue, 0);
      expect(s.readonly().value, 1);
      expect(s.globalId, s.source.globalId);
      expect(s.debugLabel, s.source.debugLabel);
      expect(s.autoDispose, s.source.autoDispose);
      expect(s.disposed, s.source.disposed);

      // ignore: unnecessary_type_check
      expect(s.source is Signal<int>, true);

      // ignore: unnecessary_type_check
      expect(s is Signal<int>, true);

      // ignore: unnecessary_type_check
      expect(s is ValueNotifier<int>, true);

      s.set(2, force: true);

      expect(s(), 2);

      s.set(2, force: true);

      expect(s.overrideWith(3).value, 3);

      s.forceUpdate(3);

      expect(s(), 3);

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

      final o = ValueNotifier<int>(0);
      final src = o.toSignal();

      expect(src.value, o.value);

      o.value = 1;

      expect(src.value, 1);
    });

    testWidgets('toValueNotifier', (tester) async {
      final v = signal<int>(0);
      final s = v.toValueNotifier();

      s.value = 1;

      expect(v.value, s.value);
      expect(s.value, 1);
      expect(s(), 1);
      expect(s.get(), 1);
      expect(s.value, 1);
      expect(s.peek(), 1);
      expect(s.toJson(), 1);
      expect(s.toString(), '1');
      expect(s.previousValue, 0);
      expect(s.initialValue, 0);
      expect(s.readonly().value, 1);

      // ignore: unnecessary_type_check
      expect(s is Signal<int>, true);

      // ignore: unnecessary_type_check
      expect(s is Signal<int>, true);

      // ignore: unnecessary_type_check
      expect(s is ValueNotifier<int>, true);

      s.set(2, force: true);

      expect(s(), 2);

      s.set(2, force: true);

      expect(s.overrideWith(3).value, 3);

      s.forceUpdate(3);

      expect(s(), 3);

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

    testWidgets('add/remove listener', (tester) async {
      int calls = 0;

      final o = signal(0);
      final s = o.toValueNotifier();
      final c = valueNotifierToSignal(s);

      expect(s.value, c.value);
      expect(s.value, 0);
      expect(calls, 0);

      void update() => calls++;
      s.addListener(update);

      o.value = 1;

      expect(s.value, 1);
      expect(calls, 1);
      expect(s.hasListeners, true);

      s.removeListener(update);

      o.value = 2;
      s.notifyListeners();

      expect(s.value, 2);
      expect(calls, 1);
    });
  });
}
