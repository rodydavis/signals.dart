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
      final s = stream.toSignal();
      expect(s.peek().isLoading, true);

      final completer = Completer<int>();
      effect(() {
        s.value;
        if (s.value.hasValue) {
          completer.complete(s.peek().requireValue);
        }
      });
      final result = await completer.future;

      expect(result, 10);
    });

    test('dependencies', () async {
      final prefix = signal('a');
      final count = signal(1);
      final s = streamSignal(() => _string(prefix(), count()));
      expect(s.peek().isLoading, true);

      var result = await s.future;
      expect(result, 'a0');

      prefix.value = 'b';
      result = await s.future;
      expect(result, 'b0');
    });

    test('check reload calls', () async {
      int calls = 0;

      Stream<int> stream() async* {
        calls++;
        await Future.delayed(const Duration(milliseconds: 5));
        yield* _stream();
      }

      final signal = streamSignal(() => stream());
      expect(signal.peek().isLoading, true);
      expect(calls, 0);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);

      await signal.reload();

      expect(calls, 2);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);
    });

    test('check refresh calls', () async {
      int calls = 0;

      Stream<int> stream() async* {
        calls++;
        await Future.delayed(const Duration(milliseconds: 5));
        yield* _stream();
      }

      final signal = streamSignal(() => stream());
      expect(signal.peek().isLoading, true);
      expect(calls, 0);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);

      await signal.refresh();

      expect(calls, 2);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);
    });
  });
}

Stream<int> _stream() async* {
  await Future.delayed(const Duration(milliseconds: 5));
  yield 10;
}

Stream<String> _string(String prefix, int count) async* {
  for (var i = 0; i < count; i++) {
    yield '$prefix$i';
  }
}
