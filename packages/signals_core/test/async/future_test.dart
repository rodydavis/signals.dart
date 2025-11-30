import 'dart:async';

import 'package:signals_core/signals_core.dart';
import 'package:test/test.dart';

void main() {
  SignalsObserver.instance = null;
  group('Future', () {
    test('futureSignal', () async {
      Future<int> future() async {
        await Future.delayed(const Duration(milliseconds: 5));
        return 10;
      }

      final signal = futureSignal(() => future());
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

    test('extension on Future', () async {
      Future<int> future() async {
        await Future.delayed(const Duration(milliseconds: 5));
        return 10;
      }

      final signal = future().toFutureSignal();
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

    test('check repeated calls', () async {
      int calls = 0;

      Future<int> future() async {
        calls++;
        await Future.delayed(const Duration(milliseconds: 5));
        return 10;
      }

      final signal = futureSignal(() => future());
      expect(signal.peek().isLoading, true);
      expect(calls, 1);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);
    });

    test('check reload calls', () async {
      int calls = 0;

      Future<int> future() async {
        calls++;
        await Future.delayed(const Duration(milliseconds: 5));
        // After the first future, return another value
        return calls == 1 ? 10 : 20;
      }

      final signal = futureSignal(() => future());
      expect(signal.peek().isLoading, true);
      expect(calls, 1);

      final List<AsyncState<int>> states = [];
      addTearDown(signal.subscribe((v) => states.add(v)));
      expect(states.length, 1);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);
      expect(states.length, 2);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);
      expect(states.length, 2);

      await signal.reload();

      print(states);

      expect(calls, 2);
      expect(signal.value.value, 20);
      expect(signal.value.error, null);

      expect(states, <AsyncState<int>>[
        AsyncState.loading(),
        AsyncState.data(10),
        AsyncState.dataReloading(10),
        AsyncState.data(20),
      ]);
    });

    test('check refresh calls', () async {
      int calls = 0;

      Future<int> future() async {
        calls++;
        await Future.delayed(const Duration(milliseconds: 5));
        // After the first future, return another value
        return calls == 1 ? 10 : 20;
      }

      final signal = futureSignal(() => future());
      expect(signal.peek().isLoading, true);
      expect(calls, 1);

      final List<AsyncState<int>> states = [];
      addTearDown(signal.subscribe((v) => states.add(v)));
      expect(states.length, 1);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);
      expect(states.length, 2);

      await signal.future;

      expect(calls, 1);
      expect(signal.value.value, 10);
      expect(signal.value.error, null);
      expect(states.length, 2);

      await signal.refresh();

      expect(calls, 2);
      expect(signal.value.value, 20);
      expect(signal.value.error, null);

      expect(states, <AsyncState<int>>[
        AsyncState.loading(),
        AsyncState.data(10),
        AsyncState.dataRefreshing(10),
        AsyncState.data(20),
      ]);
    });

    test('dependencies', () async {
      final prefix = signal('a');
      final val = signal(0);
      final f = futureSignal(() async {
        final p = prefix();
        final v = val();
        await Future.delayed(const Duration(seconds: 1));
        return '$p$v';
      });
      expect(f.peek().isLoading, true);

      var result = await f.future;

      expect(result, 'a0');

      prefix.value = 'b';
      await f.future;
      result = f.requireValue;

      expect(result, 'b0');
    });
  });
}
