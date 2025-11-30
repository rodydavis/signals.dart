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
      final s = stream.toStreamSignal();
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

    test('onDone', () async {
      final stream = _stream();
      bool done = false;
      final signal = streamSignal(
        () => stream,
        onDone: () => done = true,
      );
      await signal.future;
      await signal.cancel();

      expect(done, true);
      expect(signal.isDone, true);
    });

    test('first', () async {
      final stream = _stream();
      final signal = streamSignal(() => stream);
      final value = await signal.first;

      expect(value, 10);
    });

    test('last', () async {
      final stream = _stream();
      final signal = streamSignal(() => stream);
      final value = await signal.last;

      expect(value, 10);
    });

    test('initial data', () {
      final signal = streamSignal(() => _stream(), initialValue: 0);
      expect(signal.peek().requireValue, 0);
    });

    test('not lazy', () {
      final signal = streamSignal(() => _stream(), lazy: false);
      expect(signal.peek().isLoading, true);
    });

    test('error', () async {
      bool error = false;
      final signal = streamSignal<int>(() async* {
        throw Exception();
      });
      effect(() {
        if (signal.value.hasError) {
          error = true;
        }
      });
      await Future.delayed(const Duration(milliseconds: 5));

      expect(error, true);
    });

    test('pause', () async {
      final signal = streamSignal(() => _stream());
      await signal.future;
      signal.pause();
      expect(signal.isPaused, true);
    });

    test('resume', () {
      final signal = streamSignal(() => _stream());
      signal.pause();
      signal.resume();
      expect(signal.isPaused, false);
    });

    test('cancel', () async {
      final signal = streamSignal(() => _stream());
      await signal.cancel();
      expect(signal.isDone, true);
    });

    test('onDone', () async {
      bool done = false;
      final signal = streamSignal(
        () => _stream(),
        onDone: () => done = true,
      );
      await signal.future;
      await signal.cancel();
      expect(done, true);
    });

    test('dispose', () async {
      final signal = streamSignal(() => _stream());
      signal.dispose();
      expect(signal.disposed, true);
    });

    test('cancelOnError', () async {
      final signal = streamSignal(
        () => _stream(true),
        cancelOnError: true,
      );

      signal.value;

      await Future.delayed(const Duration(milliseconds: 10));

      expect(signal.peek().error, isA<Exception>());
      expect(signal.isDone, true);
    });
  });
}

Stream<int> _stream([bool error = false]) async* {
  await Future.delayed(const Duration(milliseconds: 5));
  if (!error) {
    yield 10;
  } else {
    throw Exception();
  }
}

Stream<String> _string(String prefix, int count) async* {
  for (var i = 0; i < count; i++) {
    yield '$prefix$i';
  }
}
