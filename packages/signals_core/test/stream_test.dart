import 'dart:async';

import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  group('Stream', () {
    test('streamSignal', () async {
      final stream = _stream();
      final signal = streamSignal(() => stream);
      expect(signal.peek().isLoading, true);

      final completer = Completer<int>();
      effect(() {
        signal.value;
        if (signal.value.hasValue) {
          completer.complete(signal.peek().requireValue);
        }
      });
      final result = await completer.future;

      expect(result, 10);
    });

    test('extension on Stream', () async {
      final stream = _stream();
      final signal = stream.toSignal();
      expect(signal.peek().isLoading, true);

      final completer = Completer<int>();
      effect(() {
        signal.value;
        if (signal.value.hasValue) {
          completer.complete(signal.peek().requireValue);
        }
      });
      final result = await completer.future;

      expect(result, 10);
    });

    test('add stream', () async {
      final signal = StreamSignal<int>();
      expect(signal.peek().isLoading, true);

      final s1 = Completer();
      final s2 = Completer();

      signal.addStream(_counter(10), onDone: s1.complete);
      signal.addStream(_counter(20), onDone: s2.complete);

      await s1.future;
      await s2.future;

      expect(signal.requireValue, 20);
    });

    test('reset stream', () async {
      final signal = StreamSignal<int>();
      signal.onDispose(() {
        print('stream disposed');
      });
      expect(signal.peek().isLoading, true);

      final s1 = Completer();
      final s2 = Completer();

      signal.addStream(_counter(10), onDone: s1.complete);
      signal.resetStream(_counter(5), onDone: s2.complete);

      await s1.future;
      await s2.future;

      expect(signal.requireValue, 5);
    });
  });
}

Stream<int> _stream() async* {
  await Future.delayed(const Duration(milliseconds: 5));
  yield 10;
}

Stream<int> _counter(int limit) async* {
  for (int i = 0; i < limit; i++) {
    yield i;
  }
  yield limit;
}
