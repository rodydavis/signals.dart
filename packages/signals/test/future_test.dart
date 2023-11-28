import 'dart:async';

import 'package:signals/signals.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Future', () {
    test('futureSignal', () async {
      Future<int> future() async {
        await Future.delayed(const Duration(milliseconds: 5));
        return 10;
      }

      final signal = futureSignal(() => future());
      expect(signal.peek() == null, true);

      final completer = Completer<int>();
      effect(() {
        signal.value;
        if (signal.isSuccess) {
          completer.complete(signal.peek());
        }
      });
      final result = await completer.future;

      expect(result, 10);
    });

    test('extension on Future', () async {
      Future<int> future() async {
        await Future.delayed(const Duration(milliseconds: 5));
        return 10;
      }

      final signal = future().toSignal();
      expect(signal.peek() == null, true);

      final completer = Completer<int>();
      effect(() {
        signal.value;
        if (signal.isSuccess) {
          completer.complete(signal.peek());
        }
      });
      final result = await completer.future;

      expect(result, 10);
    });

    test('check repeated calls', () async {
      int calls = 0;

      Future<int> future() async {
        calls++;
        await Future.delayed(const Duration(milliseconds: 5));
        return 10;
      }

      final signal = futureSignal(() => future());
      expect(signal.peek() == null, true);
      expect(calls, 0);

      var (val, err) = await signal.result;

      expect(calls, 1);
      expect(val, 10);
      expect(err, null);

      (val, err) = await signal.result;

      expect(calls, 1);
      expect(val, 10);
      expect(err, null);

      await signal.reset();
      (val, err) = await signal.result;

      expect(calls, 2);
      expect(val, 10);
      expect(err, null);
    });
  });
}
