import 'dart:async';

import 'package:preact_signals/preact_signals.dart';
import 'package:test/test.dart';

void main() {
  group('Stream', () {
    test('StreamSignal', () async {
      final stream = _stream();
      final signal = StreamSignal(() => stream);
      expect(signal.value == null, true);

      // final completer = Completer();
      // effect(() {
      //   if (signal.isSuccess) {
      //     completer.complete(signal.value);
      //   }
      // });
      // final result = await completer.future;

      // expect(result, 10);
    });

    test('extension on Stream', () async {
      final stream = _stream();
      final signal = stream.toSignal();
      expect(signal.value == null, true);

      // final completer = Completer();
      // effect(() {
      //   if (signal.isSuccess) {
      //     completer.complete(signal.value);
      //   }
      // });
      // final result = await completer.future;

      // expect(result, 10);
    });
  });
}

Stream<int> _stream() async* {
  await Future.delayed(const Duration(milliseconds: 5));
  yield 10;
}
