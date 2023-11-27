import 'dart:async';

import 'package:preact_signals/preact_signals.dart';
import 'package:test/test.dart';

void main() {
  group('Future', () {
    test('signalFromFuture', () async {
      final future = _future();
      final signal = FutureSignal(() => future);
      expect(signal() is SignalLoading, true);

      final completer = Completer<int>();
      effect(() {
        final state = signal.value;
        if (state is SignalValue<int>) {
          completer.complete(state.value);
        }
      });
      final result = await completer.future;

      expect(result, 10);
    });

    test('extension on Future', () async {
      final future = _future();
      final signal = future.toSignal();
      expect(signal() is SignalLoading, true);

      final completer = Completer<int>();
      effect(() {
        final state = signal.value;
        if (state is SignalValue<int>) {
          completer.complete(state.value);
        }
      });
      final result = await completer.future;

      expect(result, 10);
    });
  });
}

Future<int> _future() async {
  await Future.delayed(const Duration(milliseconds: 5));
  return 10;
}
