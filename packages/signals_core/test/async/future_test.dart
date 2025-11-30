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
        // Make it behave dynamically by returning the number of times it's called times 10
        return calls * 10;
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

      expect(calls, 2);
      expect(signal.value.value, 20);
      expect(signal.value.error, null);
      expect(states.length, 4);

      // Make sure that the future is triggered multiple times if calling reload while it didn't finish loading
      await Future.wait([
        signal.reload(),
        signal.reload(),
      ]);

      expect(calls, 4); // 2 more calls
      expect(signal.value.value, 40);
      expect(signal.value.error, null);

      expect(states, <AsyncState<int>>[
        AsyncState.loading(),
        AsyncState.data(10),
        AsyncState.dataReloading(10),
        AsyncState.data(20),
        AsyncState.dataReloading(20),
        AsyncState.dataReloading(20),
        AsyncState.data(40),
      ]);
    });

    test('check refresh calls', () async {
      int calls = 0;

      Future<int> future() async {
        calls++;
        await Future.delayed(const Duration(milliseconds: 5));
        // Make it behave dynamically by returning the number of times it's called times 10
        return calls * 10;
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
      expect(states.length, 4);

      // Make sure that the future is triggered multiple times if calling refresh while it didn't finish loading
      await Future.wait([
        signal.refresh(),
        signal.refresh(),
      ]);

      expect(calls, 4); // 2 more calls
      expect(signal.value.value, 40);
      expect(signal.value.error, null);

      expect(states, <AsyncState<int>>[
        AsyncState.loading(),
        AsyncState.data(10),
        AsyncState.dataRefreshing(10),
        AsyncState.data(20),
        AsyncState.dataRefreshing(20),
        AsyncState.dataRefreshing(20),
        AsyncState.data(40),
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
