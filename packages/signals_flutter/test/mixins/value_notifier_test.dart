// ignore_for_file: unnecessary_type_check

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../utils/spy.dart';

class _Signal<T> extends Signal<T> with ValueNotifierSignalMixin<T> {
  _Signal(super.internalValue);

  @override
  bool runCallbackOnListen = true;
}

void main() {
  group('ValueNotifier', () {
    test('check if extends type', () {
      final s = _Signal(0);

      expect(s.value, 0);
      expect(s is Signal, true);
      expect(s is ValueListenable, true);
      expect(s is ValueNotifier, true);
    });

    test('addListener', () {
      final s = _Signal(0);

      expect(s.value, 0);

      final spy = Spy(() {});
      s.addListener(spy.call);

      expect(spy.calls, 1);
      expect(s.value, 0);

      s.value = 1;

      expect(spy.calls, 2);
      expect(s.value, 1);
    });

    test('removeListener', () {
      final s = _Signal(0);

      expect(s.value, 0);

      final spy = Spy(() {});
      s.addListener(spy.call);

      expect(spy.calls, 1);
      expect(s.value, 0);

      s.value = 1;

      expect(spy.calls, 2);
      expect(s.value, 1);

      s.removeListener(spy.call);

      expect(spy.calls, 2);
      expect(s.value, 1);

      s.value = 2;

      expect(spy.calls, 2);
      expect(s.value, 2);
    });

    test('notifyListeners', () {
      final s = _Signal(0);

      expect(s.value, 0);

      final spy = Spy(() {});
      s.addListener(spy.call);

      expect(spy.calls, 1);
      expect(s.value, 0);

      s.value = 1;

      expect(spy.calls, 2);
      expect(s.value, 1);

      s.notifyListeners();

      expect(spy.calls, 3);
      expect(s.value, 1);
    });
  });
}
