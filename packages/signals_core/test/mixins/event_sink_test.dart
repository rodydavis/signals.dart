// ignore_for_file: unnecessary_type_check

import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

import '../utils/spy.dart';

class _Signal<T> extends Signal<AsyncState<T>> with EventSinkSignalMixin<T> {
  _Signal(super.internalValue);
}

void main() {
  group('EventSink', () {
    test('check if extends type', () {
      final s = _Signal(AsyncState.data(0));

      expect(s.value.requireValue, 0);
      expect(s is Signal, true);
      expect(s is Sink, true);
    });

    test('add', () {
      final s = _Signal(AsyncState.data(0));
      final spy = Spy(() {});
      s.subscribe((_) => spy());

      expect(s.value.requireValue, 0);
      expect(spy.calls, 1);

      s.add(1);

      expect(spy.calls, 2);
      expect(s.value.requireValue, 1);

      s.value = AsyncState.data(2);

      expect(spy.calls, 3);
      expect(s.value.requireValue, 2);
    });

    test('addError', () {
      final s = _Signal(AsyncState.data(0));
      final spy = Spy(() {});
      s.subscribe((_) => spy());

      expect(s.value.requireValue, 0);
      expect(spy.calls, 1);

      s.addError('error');

      expect(spy.calls, 2);
      expect(s.value.error, 'error');
    });

    test('close', () {
      final s = _Signal(AsyncState.data(0));

      s.close();

      expect(s.disposed, true);
    });
  });
}
