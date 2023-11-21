import 'dart:async';

import 'package:preact_signals/preact_signals.dart';
import 'package:test/test.dart';

void main() {
  group('Stream', () {
    test('signalFromStream', () async {
      final stream = _stream();
      final signal = signalFromStream(stream);
      expect(signal() is SignalLoading, true);

      final completer = Completer();
      effect(() {
        final state = signal.value;
        if (state is SignalValue) {
          completer.complete(state.value);
        }
      });
      final result = await completer.future;

      expect(result, 10);
    });

    test('extension on Stream', () async {
      final stream = _stream();
      final signal = stream.toSignal();
      expect(signal() is SignalLoading, true);

      final completer = Completer<int>();
      effect(() {
        final state = signal.value;
        if (state is SignalValue) {
          completer.complete(state.value);
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
