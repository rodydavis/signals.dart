import 'dart:async';

import 'package:signals/signals.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Stream', () {
    test('streamSignal', () async {
      final stream = _stream();
      final signal = streamSignal(() => stream);
      expect(signal.peek() == null, true);

      final completer = Completer();
      effect(() {
        signal.value;
        if (signal.isSuccess) {
          completer.complete(signal.peek());
        }
      });
      final result = await completer.future;

      expect(result, 10);
    });

    test('extension on Stream', () async {
      final stream = _stream();
      final signal = stream.toSignal();
      expect(signal.peek() == null, true);

      final completer = Completer();
      effect(() {
        signal.value;
        if (signal.isSuccess) {
          completer.complete(signal.peek());
        }
      });
      final result = await completer.future;

      expect(result, 10);
    });
  });
}

Stream<int> _stream() async* {
  await Future.delayed(const Duration(milliseconds: 5));
  yield 10;
}
