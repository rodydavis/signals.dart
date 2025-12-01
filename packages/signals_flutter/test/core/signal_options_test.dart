import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../utils/spy.dart';

void main() {
  group('FlutterSignalOptions', () {
    test('runCallbackOnListen true', () {
      final s = signal(
        0,
        options: FlutterSignalOptions(
          runCallbackOnListen: true,
        ),
      );

      final spy = Spy(() {});
      s.addListener(spy.call);

      expect(spy.calls, 1);
    });

    test('runCallbackOnListen false', () {
      final s = signal(
        0,
        options: FlutterSignalOptions(
          runCallbackOnListen: false,
        ),
      );

      final spy = Spy(() {});
      s.addListener(spy.call);

      expect(spy.calls, 0);
    });

    test('computed runCallbackOnListen true', () {
      final s = computed(
        () => 0,
        options: FlutterSignalOptions(
          runCallbackOnListen: true,
        ),
      );

      final spy = Spy(() {});
      s.addListener(spy.call);

      expect(spy.calls, 1);
    });

    test('readonly runCallbackOnListen true', () {
      final s = readonly(
        0,
        options: FlutterSignalOptions(
          runCallbackOnListen: true,
        ),
      );

      final spy = Spy(() {});
      s.addListener(spy.call);

      expect(spy.calls, 1);
    });
  });
}
